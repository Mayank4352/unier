import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../entities/quick_dial_entry.dart';
import '../repositories/quick_dial_repository.dart';

// How many quick-dial avatars fit on the home screen.
abstract final class QuickDialLimit {
  static const int home = 4;
}

// Reads the pinned quick-dial people.
final class GetQuickDial implements UseCase<List<QuickDialEntry>, int?> {
  const GetQuickDial(this._repository);
  final QuickDialRepository _repository;

  @override
  Future<Result<List<QuickDialEntry>>> call(int? limit) =>
      _repository.getQuickDial(limit: limit);
}
