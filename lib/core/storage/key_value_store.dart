/// A small key/value store, behind an interface.
abstract interface class KeyValueStore {
  /// Reads a string, or `null` when the key is absent.
  String? getString(String key);

  /// Writes a string.
  Future<void> setString(String key, String value);

  /// Reads a bool, or `null` when the key is absent.
  bool? getBool(String key);

  /// Writes a bool.
  Future<void> setBool(String key, bool value);

  /// Reads a list of strings, or `null` when the key is absent.
  List<String>? getStringList(String key);

  /// Writes a list of strings.
  Future<void> setStringList(String key, List<String> value);

  /// Removes a key.
  Future<void> remove(String key);
}
