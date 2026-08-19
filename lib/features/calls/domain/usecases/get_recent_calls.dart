import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../entities/call_record.dart';
import '../repositories/call_log_repository.dart';

/// How many recent calls each surface asks for.
abstract final class RecentCallsLimit {
  static const int homePreview = 4;
  static const int? full = null;
}

/// Reads the call history, newest first.
final class GetRecentCalls implements UseCase<List<CallRecord>, int?> {
  const GetRecentCalls(this._repository);
  final CallLogRepository _repository;

  @override
  Future<Result<List<CallRecord>>> call(int? limit) async {
    final result = await _repository.getRecentCalls(limit: limit);
    return result.map(
      (calls) =>
          calls.toList()..sort((a, b) => b.startedAt.compareTo(a.startedAt)),
    );
  }
}
