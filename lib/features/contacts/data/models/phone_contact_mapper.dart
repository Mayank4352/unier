import 'package:flutter_contacts/flutter_contacts.dart' as device;

import '../../domain/entities/phone_contact.dart';

extension DeviceContactMapper on device.Contact {
  PhoneContact toEntity() => PhoneContact(
    id: id ?? '',
    displayName: displayName?.trim() ?? '',
    phoneNumbers: phones
        .map((phone) => phone.number.trim())
        .where((number) => number.isNotEmpty)
        .toList(growable: false),
    photo: photo?.thumbnail,
  );
}
