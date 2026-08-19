import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/call_record.dart';
import '../models/call_record_dto.dart';

// Stores the call history on the device.
//
// Empty until the call feature starts writing rows; the screens render their
// empty states until then.
class CallLogLocalDataSource {
  const CallLogLocalDataSource(this._store);

  static const String _key = 'calls.log';

  final KeyValueStore _store;

  Future<List<CallRecord>> read() async =>
      (_store.getStringList(_key) ?? const <String>[])
          .map(CallRecordDto.decode)
          .whereType<CallRecord>()
          .toList(growable: false);

  Future<void> write(List<CallRecord> records) => _store.setStringList(
    _key,
    records.map(CallRecordDto.encode).toList(growable: false),
  );

  bool get isEmpty => (_store.getStringList(_key) ?? const <String>[]).isEmpty;
}
