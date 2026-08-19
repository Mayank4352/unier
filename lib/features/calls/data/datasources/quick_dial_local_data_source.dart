import '../../../../core/storage/key_value_store.dart';

/// Stores which contacts are pinned to the quick-dial strip.
class QuickDialLocalDataSource {
  const QuickDialLocalDataSource(this._store);

  static const String _key = 'calls.quick_dial_contact_ids';

  final KeyValueStore _store;

  List<String> readPinnedIds() =>
      _store.getStringList(_key) ?? const <String>[];

  Future<void> writePinnedIds(List<String> ids) =>
      _store.setStringList(_key, ids);
}
