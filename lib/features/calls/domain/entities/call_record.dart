import '../../../../core/utils/display_name.dart';

/// Which way a call went, and whether it connected.
enum CallDirection { incoming, outgoing, missed }

/// One row of the call log.
class CallRecord {
  const CallRecord({
    required this.id,
    required this.contactName,
    required this.direction,
    required this.startedAt,
    this.duration,
    this.captionLineCount,
    this.phoneNumber,
  });

  final String id;
  final String contactName;
  final CallDirection direction;
  final DateTime startedAt;
  final Duration? duration;
  final int? captionLineCount;
  final String? phoneNumber;

  bool get wasAnswered => direction != CallDirection.missed;
  String get initials => contactName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CallRecord && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CallRecord($id, $contactName, $direction)';
}
