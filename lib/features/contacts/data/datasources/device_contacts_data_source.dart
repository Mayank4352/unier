import 'package:flutter_contacts/flutter_contacts.dart' as device;

import '../../domain/entities/phone_contact.dart';
import '../models/phone_contact_mapper.dart';

// Wraps the address-book plugin and its permission prompt.
class DeviceContactsDataSource {
  const DeviceContactsDataSource();

  static const device.PermissionType _permission = device.PermissionType.read;

  Future<device.PermissionStatus> permissionStatus() =>
      device.FlutterContacts.permissions.check(_permission);

  Future<bool> hasPermission() =>
      device.FlutterContacts.permissions.has(_permission);

  Future<device.PermissionStatus> requestPermission() =>
      device.FlutterContacts.permissions.request(_permission);

  // Opens the system settings page, for a permanently denied permission.
  Future<void> openSettings() =>
      device.FlutterContacts.permissions.openSettings();

  Future<List<PhoneContact>> fetchContacts({required bool withPhotos}) async {
    final contacts = await device.FlutterContacts.getAll(
      properties: <device.ContactProperty>{
        device.ContactProperty.phone,
        if (withPhotos) device.ContactProperty.photoThumbnail,
      },
    );

    return contacts.map((contact) => contact.toEntity()).toList()..sort(
      (a, b) =>
          a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()),
    );
  }
}
