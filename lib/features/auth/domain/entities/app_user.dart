import '../../../../core/utils/display_name.dart';

// The signed-in person.
class AppUser {
  const AppUser({
    required this.id,
    required this.displayName,
    this.email,
    this.photoUrl,
  });

  final String id;
  final String displayName;
  final String? email;
  final String? photoUrl;

  String get givenName => displayName.givenName;
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
