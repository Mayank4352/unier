import '../../../../core/config/app_config.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/call_record.dart';
import '../../domain/repositories/call_log_repository.dart';
import '../datasources/call_log_local_data_source.dart';
import '../datasources/call_log_seed.dart';

class CallLogRepositoryImpl implements CallLogRepository {
  CallLogRepositoryImpl(this._localDataSource, this._clock);

  final CallLogLocalDataSource _localDataSource;
  final Clock _clock;

  @override
  Future<Result<List<CallRecord>>> getRecentCalls({int? limit}) async {
    try {
      await _seedIfEmpty();
      final records = _localDataSource.read();
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

  Future<void> _seedIfEmpty() async {
    if (!AppConfig.seedSampleCallLog || !_localDataSource.isEmpty) return;
    await _localDataSource.write(CallLogSeed.forDate(_clock.now()));
  }

  List<CallRecord> _take(List<CallRecord> records, int? limit) =>
      limit == null || limit >= records.length
      ? records
      : records.sublist(0, limit);
}
