import '../../../../core/utils/result.dart';
import '../entities/call_settings.dart';

/// Where the caption and voice preferences live.
abstract interface class CallSettingsRepository {
  /// Reads the stored settings, falling back to [CallSettings.defaults].
  Future<Result<CallSettings>> load();

  /// Persists [settings] and returns what was written.
  Future<Result<CallSettings>> save(CallSettings settings);
}
