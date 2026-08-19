import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/call_settings.dart';

/// Reads and writes the caption/voice preferences in local storage.
class CallSettingsLocalDataSource {
  const CallSettingsLocalDataSource(this._store);

  static const String _captionsKey = 'settings.captions_enabled';
  static const String _voiceKey = 'settings.voice_name';
  static const String _readyKey = 'settings.ready_for_calls';

  final KeyValueStore _store;

  CallSettings read() => CallSettings(
    captionsEnabled:
        _store.getBool(_captionsKey) ?? CallSettings.defaults.captionsEnabled,
    voiceName: _store.getString(_voiceKey) ?? CallSettings.defaults.voiceName,
    readyForCalls:
        _store.getBool(_readyKey) ?? CallSettings.defaults.readyForCalls,
  );

  Future<void> write(CallSettings settings) async {
    await _store.setBool(_captionsKey, settings.captionsEnabled);
    await _store.setString(_voiceKey, settings.voiceName);
    await _store.setBool(_readyKey, settings.readyForCalls);
  }
}
