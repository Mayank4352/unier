import '../../utils/display_name.dart';

/// A contact read from the device's address book.
class PhoneContact {
  const PhoneContact({
    required this.id,
    required this.displayName,
    this.phoneNumbers = const <String>[],
    this.photo,
  });

  /// The platform contact identifier.
  final String id;

  /// The contact's display name.
  final String displayName;

  /// Every number on the contact, in the order the platform returned them.
  final List<String> phoneNumbers;

  /// Thumbnail bytes, when the contact has a photo.
  final List<int>? photo;

  /// The number used when the contact is dialled.
  String? get primaryPhoneNumber =>
      phoneNumbers.isEmpty ? null : phoneNumbers.first;

  /// Whether this contact can be called.
  bool get isCallable => phoneNumbers.isNotEmpty;

  /// Initials drawn when there is no [photo].
  String get initials => displayName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PhoneContact && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PhoneContact($id, $displayName)';
}
