import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_store.dart';

/// [KeyValueStore] backed by `shared_preferences`.
class SharedPreferencesStore implements KeyValueStore {
  const SharedPreferencesStore(this._preferences);

  /// Opens the platform store. Call once during start-up.
  static Future<SharedPreferencesStore> open() async =>
      SharedPreferencesStore(await SharedPreferences.getInstance());

  final SharedPreferences _preferences;

  @override
  String? getString(String key) => _preferences.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  bool? getBool(String key) => _preferences.getBool(key);

  @override
  Future<void> setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  @override
  List<String>? getStringList(String key) => _preferences.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _preferences.setStringList(key, value);

  @override
  Future<void> remove(String key) => _preferences.remove(key);
}

/// An in-memory [KeyValueStore], for tests and previews.
class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, Object> _values = <String, Object>{};

  @override
  String? getString(String key) => _values[key] as String?;

  @override
  Future<void> setString(String key, String value) async =>
      _values[key] = value;

  @override
  bool? getBool(String key) => _values[key] as bool?;

  @override
  Future<void> setBool(String key, bool value) async => _values[key] = value;

  @override
  List<String>? getStringList(String key) => _values[key] as List<String>?;

  @override
  Future<void> setStringList(String key, List<String> value) async =>
      _values[key] = value;

  @override
  Future<void> remove(String key) async => _values.remove(key);
}
