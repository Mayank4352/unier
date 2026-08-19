import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/utils/command.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/watch_auth_state.dart';

/// Owns the session for the whole app and drives the router's redirect.
class AuthViewModel extends ChangeNotifier {
  AuthViewModel({
    required WatchAuthState watchAuthState,
    required SignInWithGoogle signInWithGoogle,
    required SignOut signOut,
  }) : _signInWithGoogle = signInWithGoogle,
       _signOut = signOut {
    signIn = Command0<AppUser>(_signInWithGoogle.call)
      ..addListener(notifyListeners);
    signOutCommand = Command0<void>(_signOut.call)
      ..addListener(notifyListeners);
    _subscription = watchAuthState().listen(_onUserChanged);
  }

  final SignInWithGoogle _signInWithGoogle;
  final SignOut _signOut;

  late final Command0<AppUser> signIn;
  late final Command0<void> signOutCommand;

  StreamSubscription<AppUser?>? _subscription;

  AppUser? _user;
  AppUser? get user => _user;

  bool _resolved = false;

  /// True until the first auth event arrives, so the router can hold a splash.
  bool get isResolving => !_resolved;

  bool get isSignedIn => _user != null;

  void _onUserChanged(AppUser? user) {
    _user = user;
    _resolved = true;
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    signIn.dispose();
    signOutCommand.dispose();
    super.dispose();
  }
}
