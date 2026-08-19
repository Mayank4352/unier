import '../../utils/display_name.dart';

/// Which way a call went, and whether it connected.
enum CallDirection {
  /// The person called us and we answered.
  incoming,

  /// We called the person.
  outgoing,

  /// The call was not answered.
  missed,
}

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

  /// Stable identifier for list keys and navigation.
  final String id;

  /// Who the call was with.
  final String contactName;

  /// Which way the call went.
  final CallDirection direction;

  /// When the call started, in local time.
  final DateTime startedAt;

  /// How long the call lasted, or `null` if it never connected.
  final Duration? duration;

  /// How many caption lines were transcribed, or `null` if none were.
  final int? captionLineCount;

  /// The number dialled, when known.
  final String? phoneNumber;

  /// Whether the call connected.
  bool get wasAnswered => direction != CallDirection.missed;

  /// Initials for an avatar with no photo.
  String get initials => contactName.initials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CallRecord && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CallRecord($id, $contactName, $direction)';
}
