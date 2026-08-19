import '../../../../core/config/app_config.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Always-signed-in stand-in used when `--dart-define=DEV_AUTH=true`.
///
/// Swapping the repository at the composition root keeps the bypass out of the
/// router and the view models entirely.
class DevAuthRepository implements AuthRepository {
  static const AppUser _user = AppUser(
    id: 'dev-user',
    displayName: AppConfig.devUserName,
    email: 'dev@unier.app',
  );

  @override
  Stream<AppUser?> get authStateChanges => Stream<AppUser?>.value(_user);

  @override
  AppUser? get currentUser => _user;

  @override
  Future<Result<AppUser>> signInWithGoogle() async => const Result.ok(_user);

  @override
  Future<Result<void>> signOut() async => const Result.ok(null);
}
