import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/google_auth_data_source.dart';
import '../models/app_user_mapper.dart';

/// [AuthRepository] backed by Firebase Auth and Google Sign-In.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final GoogleAuthDataSource _dataSource;
  final _log = Logger('AuthRepository');

  @override
  Stream<AppUser?> get authStateChanges =>
      _dataSource.userChanges.map((user) => user?.toEntity());

  @override
  AppUser? get currentUser => _dataSource.currentUser?.toEntity();

  @override
  Future<Result<AppUser>> signInWithGoogle() async {
    if (!_dataSource.supportsInteractiveSignIn) {
      return const Result.err(
        AuthFailure('Google sign-in is not available on this platform.'),
      );
    }

    try {
      final user = await _dataSource.signInWithGoogle();
      _log.info('Signed in as ${user.uid}');
      return Result.ok(user.toEntity());
    } on GoogleSignInException catch (error, stackTrace) {
      return Result.err(_translateGoogleException(error, stackTrace));
    } on firebase.FirebaseAuthException catch (error, stackTrace) {
      _log.warning(
        'Firebase rejected the Google credential',
        error,
        stackTrace,
      );
      return Result.err(
        AuthFailure(
          error.message ?? 'Could not complete sign-in.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    } on Exception catch (error, stackTrace) {
      _log.severe('Unexpected sign-in failure', error, stackTrace);
      return Result.err(
        UnexpectedFailure(
          'Something went wrong signing in.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Result.ok(null);
    } on Exception catch (error, stackTrace) {
      _log.warning('Sign-out failed', error, stackTrace);
      return Result.err(
        AuthFailure(
          'Could not sign out.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Restores a previous session at startup, ignoring any failure: a person who
  Future<void> restoreSession() async {
    try {
      await _dataSource.restoreSession();
    } on Exception catch (error, stackTrace) {
      _log.info('No session to restore', error, stackTrace);
    }
  }

  Failure _translateGoogleException(
    GoogleSignInException error,
    StackTrace stackTrace,
  ) {
    _log.info('Google sign-in ended with ${error.code}', error, stackTrace);
    return switch (error.code) {
      GoogleSignInExceptionCode.canceled => AuthFailure(
        'Sign-in was cancelled.',
        wasCancelled: true,
        cause: error,
        stackTrace: stackTrace,
      ),
      GoogleSignInExceptionCode.interrupted ||
      GoogleSignInExceptionCode.uiUnavailable => NetworkFailure(
        'Sign-in was interrupted. Please try again.',
        cause: error,
        stackTrace: stackTrace,
      ),
      GoogleSignInExceptionCode.clientConfigurationError ||
      GoogleSignInExceptionCode.providerConfigurationError => AuthFailure(
        'Google sign-in is not configured for this build.',
        cause: error,
        stackTrace: stackTrace,
      ),
      _ => AuthFailure(
        'Could not sign in with Google.',
        cause: error,
        stackTrace: stackTrace,
      ),
    };
  }
}
