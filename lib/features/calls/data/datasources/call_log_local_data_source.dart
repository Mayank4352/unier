import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/call_record.dart';
import '../models/call_record_dto.dart';

/// Stores the call history on the device.
class CallLogLocalDataSource {
  const CallLogLocalDataSource(this._store);

  static const String _key = 'calls.log';

  final KeyValueStore _store;

  List<CallRecord> read() {
    final rows = _store.getStringList(_key) ?? const <String>[];
    return rows
        .map(CallRecordDto.decode)
        .whereType<CallRecord>()
        .toList(growable: false);
  }

  Future<void> write(List<CallRecord> records) => _store.setStringList(
    _key,
    records.map(CallRecordDto.encode).toList(growable: false),
  );

  bool get isEmpty => (_store.getStringList(_key) ?? const <String>[]).isEmpty;
}
