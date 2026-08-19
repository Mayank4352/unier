import 'dart:typed_data';

import '../../../../core/utils/display_name.dart';

/// A contact read from the device's address book.
class PhoneContact {
  const PhoneContact({
    required this.id,
    required this.displayName,
    this.phoneNumbers = const <String>[],
    this.photo,
  });

  final String id;
  final String displayName;
  final List<String> phoneNumbers;
  final Uint8List? photo;

  String? get primaryPhoneNumber =>
      phoneNumbers.isEmpty ? null : phoneNumbers.first;

  bool get isCallable => phoneNumbers.isNotEmpty;
  String get initials => displayName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PhoneContact && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PhoneContact($id, $displayName)';
}
