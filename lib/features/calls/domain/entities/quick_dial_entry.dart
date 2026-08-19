import '../../../../core/utils/display_name.dart';

/// A person pinned to the home screen's quick-dial strip.
class QuickDialEntry {
  const QuickDialEntry({
    required this.id,
    required this.displayName,
    this.phoneNumber,
    this.photoUrl,
  });

  final String id;
  final String displayName;
  final String? phoneNumber;
  final String? photoUrl;

  String get initials => displayName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuickDialEntry && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'QuickDialEntry($id, $displayName)';
}
