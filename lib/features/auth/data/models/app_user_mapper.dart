import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../domain/entities/app_user.dart';

/// Translates the Firebase user into the app's own entity.
extension FirebaseUserMapper on firebase.User {
  /// The domain entity for this Firebase session.
  AppUser toEntity() => AppUser(
    id: uid,
    displayName: _resolveDisplayName(),
    email: email,
    photoUrl: photoURL,
  );

  /// Google always supplies a display name; email/password sign-ups may not, so
  String _resolveDisplayName() {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) return name;

    final address = email?.trim();
    if (address != null && address.contains('@')) {
      return address.split('@').first;
    }
    return '';
  }
}
