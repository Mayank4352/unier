import '../../utils/display_name.dart';

/// A person pinned to the home screen's quick-dial strip.
class QuickDialEntry {
  const QuickDialEntry({
    required this.id,
    required this.displayName,
    this.phoneNumber,
    this.photoUrl,
  });

  /// Stable identifier for list keys and navigation.
  final String id;

  /// Name shown under the avatar.
  final String displayName;

  /// Number dialled when the avatar is tapped.
  final String? phoneNumber;

  /// Avatar image, when the contact has one.
  final String? photoUrl;

  /// Initials drawn when there is no [photoUrl].
  String get initials => displayName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuickDialEntry && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'QuickDialEntry($id, $displayName)';
}
