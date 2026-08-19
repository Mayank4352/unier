import 'package:flutter_contacts/flutter_contacts.dart' as device;
import 'package:logging/logging.dart';

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
      return switch (status) {
        device.PermissionStatus.granted ||
        device.PermissionStatus.limited => const Result<void>.ok(null),
        _ => Result<void>.err(_denied(status)),
      };
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

  @override
  Future<void> openSystemSettings() => _dataSource.openSettings();

  PermissionFailure _denied(device.PermissionStatus status) {
    final isPermanent =
        status == device.PermissionStatus.permanentlyDenied ||
        status == device.PermissionStatus.restricted;
    return PermissionFailure(
      isPermanent
          ? 'Contacts access is turned off. Enable it in Settings to call people from your address book.'
          : 'Unier needs access to your contacts to show them here.',
      isPermanentlyDenied: isPermanent,
    );
  }
}
