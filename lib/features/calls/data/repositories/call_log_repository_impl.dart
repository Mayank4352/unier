import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/call_record.dart';
import '../../domain/repositories/call_log_repository.dart';
import '../datasources/call_log_local_data_source.dart';

class CallLogRepositoryImpl implements CallLogRepository {
  const CallLogRepositoryImpl(this._localDataSource);

  final CallLogLocalDataSource _localDataSource;

  @override
  Future<Result<List<CallRecord>>> getRecentCalls({int? limit}) async {
    try {
      final records = await _localDataSource.read();
      return Result.ok(_take(records, limit));
    } on Exception catch (error, stackTrace) {
      return Result.err(
        CacheFailure(
          'Could not read your recent calls.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  List<CallRecord> _take(List<CallRecord> records, int? limit) =>
      limit == null || limit >= records.length
      ? records
      : records.sublist(0, limit);
}
