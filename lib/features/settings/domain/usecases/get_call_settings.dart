import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../entities/call_settings.dart';
import '../repositories/call_settings_repository.dart';

// Reads the caption and voice preferences.
final class GetCallSettings implements UseCaseNoParams<CallSettings> {
  const GetCallSettings(this._repository);
  final CallSettingsRepository _repository;

  @override
  Future<Result<CallSettings>> call() => _repository.load();
}
