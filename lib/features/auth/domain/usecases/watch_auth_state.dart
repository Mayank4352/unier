import '../../../../core/usecase/use_case.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

/// Observes the signed-in user for as long as the app is running.
final class WatchAuthState implements StreamUseCase<AppUser?> {
  const WatchAuthState(this._repository);
  final AuthRepository _repository;

  @override
  Stream<AppUser?> call() => _repository.authStateChanges;
}
