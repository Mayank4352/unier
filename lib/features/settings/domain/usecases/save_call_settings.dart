import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../entities/call_settings.dart';
import '../repositories/call_settings_repository.dart';

/// Persists a change to the caption or voice preferences.
final class SaveCallSettings implements UseCase<CallSettings, CallSettings> {
  const SaveCallSettings(this._repository);
  final CallSettingsRepository _repository;

  @override
  Future<Result<CallSettings>> call(CallSettings params) =>
      _repository.save(params);
}
