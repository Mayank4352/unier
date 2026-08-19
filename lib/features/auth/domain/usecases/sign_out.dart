import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

// Ends the current session.
final class SignOut implements UseCaseNoParams<void> {
  const SignOut(this._repository);
  final AuthRepository _repository;

  @override
  Future<Result<void>> call() => _repository.signOut();
}
