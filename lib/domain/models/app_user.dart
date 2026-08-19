import '../../utils/display_name.dart';

/// The signed-in person.
///
/// Populated from the Google account behind the Firebase session, which is
/// where the home screen's greeting name comes from.
class AppUser {
  const AppUser({
    required this.id,
    required this.displayName,
    this.email,
    this.photoUrl,
  });

  /// Firebase UID.
  final String id;

  /// Full name as provided by the identity provider.
  final String displayName;

  /// Account email, when the provider exposes one.
  final String? email;

  /// Avatar URL, when the provider exposes one.
  final String? photoUrl;

  /// First name, for the greeting.
  String get givenName => displayName.givenName;

  /// Initials, for an avatar with no photo.
  String get initials => displayName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          other.id == id &&
          other.displayName == displayName &&
          other.email == email &&
          other.photoUrl == photoUrl;

  @override
  int get hashCode => Object.hash(id, displayName, email, photoUrl);

  @override
  String toString() => 'AppUser($id, $displayName)';
}
