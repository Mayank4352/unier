import 'dart:convert';

import '../../domain/entities/call_record.dart';

// JSON form of a CallRecord, as stored on the device.
abstract final class CallRecordDto {
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _direction = 'direction';
  static const String _startedAt = 'startedAt';
  static const String _durationSeconds = 'durationSeconds';
  static const String _captionLines = 'captionLines';
  static const String _phoneNumber = 'phoneNumber';

  static String encode(CallRecord record) => jsonEncode(<String, Object?>{
    _id: record.id,
    _name: record.contactName,
    _direction: record.direction.name,
    _startedAt: record.startedAt.toIso8601String(),
    _durationSeconds: record.duration?.inSeconds,
    _captionLines: record.captionLineCount,
    _phoneNumber: record.phoneNumber,
  });

  // Returns `null` when the stored entry cannot be read, so one bad row does
  // not take the whole call log down with it.
  static CallRecord? decode(String source) {
    try {
      final json = jsonDecode(source) as Map<String, dynamic>;
      final seconds = json[_durationSeconds] as int?;
      return CallRecord(
        id: json[_id] as String,
        contactName: json[_name] as String,
        direction: CallDirection.values.byName(json[_direction] as String),
        startedAt: DateTime.parse(json[_startedAt] as String),
        duration: seconds == null ? null : Duration(seconds: seconds),
        captionLineCount: json[_captionLines] as int?,
        phoneNumber: json[_phoneNumber] as String?,
      );
    } on Object {
      return null;
    }
  }
}
