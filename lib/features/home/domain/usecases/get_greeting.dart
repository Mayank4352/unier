import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/result.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../entities/greeting.dart';
import '../entities/part_of_day.dart';

// Builds the home screen's date line and salutation.
final class GetGreeting implements UseCaseNoParams<Greeting> {
  const GetGreeting(this._authRepository, this._clock);
  final AuthRepository _authRepository;
  final Clock _clock;

  @override
  Future<Result<Greeting>> call() async {
    final now = _clock.now();
    return Result.ok(
      Greeting(
        date: now,
        partOfDay: PartOfDay.at(now),
        name: _authRepository.currentUser?.givenName,
      ),
    );
  }
}
