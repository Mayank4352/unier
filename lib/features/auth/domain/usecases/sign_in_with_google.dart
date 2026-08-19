import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

/// Signs the person in with their Google account.
final class SignInWithGoogle implements UseCaseNoParams<AppUser> {
  const SignInWithGoogle(this._repository);
  final AuthRepository _repository;

  @override
  Future<Result<AppUser>> call() => _repository.signInWithGoogle();
}
