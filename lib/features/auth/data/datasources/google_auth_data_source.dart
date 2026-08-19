import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/config/app_config.dart';

/// Talks to Firebase Auth and Google Sign-In.
class GoogleAuthDataSource {
  GoogleAuthDataSource({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  bool _initialized = false;

  /// Prepares the Google Sign-In SDK.
  Future<void> initialize() async {
    if (_initialized) return;
    await _googleSignIn.initialize(
      serverClientId: AppConfig.googleServerClientId,
    );
    _initialized = true;
  }

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;
  bool get supportsInteractiveSignIn => _googleSignIn.supportsAuthenticate();

  /// Runs the Google account picker and exchanges the ID token for a Firebase
  Future<User> signInWithGoogle() async {
    await initialize();

    final account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw FirebaseAuthException(
        code: 'missing-id-token',
        message: 'Google did not return an ID token for this account.',
      );
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'Firebase accepted the credential but returned no user.',
      );
    }
    return user;
  }

  /// Ends the session on Firebase and on the Google account.
  Future<void> signOut() async {
    await Future.wait<void>(<Future<void>>[
      _firebaseAuth.signOut(),
      if (_initialized) _googleSignIn.signOut(),
    ]);
  }
}
