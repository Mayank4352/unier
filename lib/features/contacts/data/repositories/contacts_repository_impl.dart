import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/phone_contact.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../datasources/device_contacts_data_source.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl(this._dataSource);

  final DeviceContactsDataSource _dataSource;
  final _log = Logger('ContactsRepository');

  @override
  Future<bool> hasPermission() => _dataSource.hasPermission();

  @override
  Future<Result<void>> requestPermission() async {
    try {
      final status = await _dataSource.requestPermission();
      if (status.isGranted || status.isLimited) return const Result.ok(null);
      return Result.err(_denied(status));
    } on Exception catch (error, stackTrace) {
      _log.warning('Contacts permission request failed', error, stackTrace);
      return Result.err(
        UnexpectedFailure(
          'Could not ask for contacts access.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<List<PhoneContact>>> getContacts({
    bool withPhotos = false,
  }) async {
    if (!await hasPermission()) {
      final granted = await requestPermission();
      if (granted case Err<void>(:final failure)) {
        return Result.err(failure);
      }
    }

    try {
      final contacts = await _dataSource.fetchContacts(withPhotos: withPhotos);
      _log.fine('Loaded ${contacts.length} contacts');
      return Result.ok(contacts);
    } on Exception catch (error, stackTrace) {
      _log.warning('Reading contacts failed', error, stackTrace);
      return Result.err(
        UnexpectedFailure(
          'Could not read your contacts.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Opens the system settings page so a permanent denial can be reversed.
  Future<void> openSystemSettings() => _dataSource.openSettings();

  PermissionFailure _denied(PermissionStatus status) => PermissionFailure(
    status.isPermanentlyDenied
        ? 'Contacts access is turned off. Enable it in Settings to call people from your address book.'
        : 'Unier needs access to your contacts to show them here.',
    isPermanentlyDenied: status.isPermanentlyDenied,
  );
}
