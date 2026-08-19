import '../../../../core/utils/result.dart';
import '../entities/app_user.dart';

/// Session and identity, as the rest of the app sees it.
abstract interface class AuthRepository {
  /// Emits the signed-in user, or `null` once signed out.
  Stream<AppUser?> get authStateChanges;

  /// The user of the active session, or `null` when signed out.
  AppUser? get currentUser;

  /// Runs the Google sign-in flow and exchanges the result for a session.
  Future<Result<AppUser>> signInWithGoogle();

  /// Ends the session on both Firebase and the Google account.
  Future<Result<void>> signOut();
}
