import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../../../contacts/data/datasources/device_contacts_data_source.dart';
import '../../../contacts/domain/entities/phone_contact.dart';
import '../../domain/entities/call_record.dart';
import '../../domain/entities/quick_dial_entry.dart';
import '../../domain/repositories/quick_dial_repository.dart';
import '../datasources/call_log_local_data_source.dart';
import '../datasources/quick_dial_local_data_source.dart';

// Resolves the quick-dial strip from pinned contacts, falling back to the
// people called most often so the strip is never empty without a reason.
class QuickDialRepositoryImpl implements QuickDialRepository {
  const QuickDialRepositoryImpl(
    this._pinnedDataSource,
    this._contactsDataSource,
    this._callLogDataSource,
  );

  final QuickDialLocalDataSource _pinnedDataSource;
  final DeviceContactsDataSource _contactsDataSource;
  final CallLogLocalDataSource _callLogDataSource;

  @override
  Future<Result<List<QuickDialEntry>>> getQuickDial({int? limit}) async {
    try {
      final pinned = await _resolvePinned();
      final entries = pinned.isNotEmpty ? pinned : await _mostCalled();
      return Result.ok(_take(entries, limit));
    } on Exception catch (error, stackTrace) {
      return Result.err(
        CacheFailure(
          'Could not load quick dial.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<List<QuickDialEntry>> _resolvePinned() async {
    final ids = _pinnedDataSource.readPinnedIds();
    if (ids.isEmpty) return const <QuickDialEntry>[];
    if (!await _contactsDataSource.hasPermission()) {
      return const <QuickDialEntry>[];
    }

    final contacts = <String, PhoneContact>{
      for (final contact in await _contactsDataSource.fetchContacts(
        withPhotos: false,
      ))
        contact.id: contact,
    };

    return ids
        .map((id) => contacts[id])
        .whereType<PhoneContact>()
        .map(_fromContact)
        .toList(growable: false);
  }

  // Ranks by call count, then by recency, using the local history only.
  Future<List<QuickDialEntry>> _mostCalled() async {
    final counts = <String, int>{};
    final latest = <String, CallRecord>{};

    for (final record in await _callLogDataSource.read()) {
      final name = record.contactName;
      counts[name] = (counts[name] ?? 0) + 1;
      final seen = latest[name];
      if (seen == null || record.startedAt.isAfter(seen.startedAt)) {
        latest[name] = record;
      }
    }

    final names = counts.keys.toList()
      ..sort((a, b) {
        final byCount = counts[b]!.compareTo(counts[a]!);
        if (byCount != 0) return byCount;
        return latest[b]!.startedAt.compareTo(latest[a]!.startedAt);
      });

    return names
        .map(
          (name) => QuickDialEntry(
            id: latest[name]!.id,
            displayName: name,
            phoneNumber: latest[name]!.phoneNumber,
          ),
        )
        .toList(growable: false);
  }

  QuickDialEntry _fromContact(PhoneContact contact) => QuickDialEntry(
    id: contact.id,
    displayName: contact.displayName,
    phoneNumber: contact.primaryPhoneNumber,
  );

  List<QuickDialEntry> _take(List<QuickDialEntry> entries, int? limit) =>
      limit == null || limit >= entries.length
      ? entries
      : entries.sublist(0, limit);
}
