import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/call_settings.dart';
import '../../domain/repositories/call_settings_repository.dart';
import '../datasources/call_settings_local_data_source.dart';

class CallSettingsRepositoryImpl implements CallSettingsRepository {
  const CallSettingsRepositoryImpl(this._localDataSource);

  final CallSettingsLocalDataSource _localDataSource;

  @override
  Future<Result<CallSettings>> load() async {
    try {
      return Result.ok(_localDataSource.read());
    } on Exception catch (error, stackTrace) {
      return Result.err(
        CacheFailure(
          'Could not read your call settings.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<CallSettings>> save(CallSettings settings) async {
    try {
      await _localDataSource.write(settings);
      return Result.ok(settings);
    } on Exception catch (error, stackTrace) {
      return Result.err(
        CacheFailure(
          'Could not save your call settings.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
