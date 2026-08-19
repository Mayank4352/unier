import 'package:flutter_contacts/flutter_contacts.dart' as device;
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/phone_contact.dart';
import '../models/phone_contact_mapper.dart';

/// Wraps the address-book plugin and the OS permission prompt.
class DeviceContactsDataSource {
  const DeviceContactsDataSource();

  Future<PermissionStatus> permissionStatus() => Permission.contacts.status;

  Future<bool> hasPermission() async {
    final status = await permissionStatus();
    return status.isGranted || status.isLimited;
  }

  Future<PermissionStatus> requestPermission() => Permission.contacts.request();

  /// Opens the system settings page, for a permanently denied permission.
  Future<bool> openSettings() => openAppSettings();

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
