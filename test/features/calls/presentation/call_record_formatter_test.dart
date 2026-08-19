import 'package:flutter_test/flutter_test.dart';
import 'package:unier/features/calls/domain/entities/call_record.dart';
import 'package:unier/features/calls/presentation/formatters/call_record_formatter.dart';

void main() {
  final now = DateTime(2026, 8, 13, 15);

  CallRecord record({
    Duration? duration,
    int? captionLines,
    DateTime? startedAt,
    CallDirection direction = CallDirection.incoming,
  }) => CallRecord(
    id: 'id',
    contactName: 'Kid Pglu',
    direction: direction,
    startedAt: startedAt ?? DateTime(2026, 8, 13, 12, 52),
    duration: duration,
    captionLineCount: captionLines,
  );

  group('durationLabel', () {
    test('shows minutes and seconds', () {
      expect(
        record(duration: const Duration(minutes: 4, seconds: 12)).durationLabel,
        '4 min 12 sec',
      );
    });

    test('shows hours for a long call', () {
      expect(
        record(
          duration: const Duration(hours: 1, minutes: 2, seconds: 3),
        ).durationLabel,
        '1 hr 2 min 3 sec',
      );
    });

    test('drops minutes under a minute', () {
      expect(
        record(duration: const Duration(seconds: 9)).durationLabel,
        '9 sec',
      );
    });

    test('is null when the call never connected', () {
      expect(record().durationLabel, isNull);
    });
  });

  group('captionLabel', () {
    test('pluralises', () {
      expect(record(captionLines: 14).captionLabel, '14 lines');
      expect(record(captionLines: 1).captionLabel, '1 line');
    });

    test('is null when nothing was transcribed', () {
      expect(record(captionLines: 0).captionLabel, isNull);
      expect(record().captionLabel, isNull);
    });
  });

  group('timeLabel', () {
    test('shows the clock time for today', () {
      // intl separates the meridiem with a narrow no-break space.
      expect(record().timeLabel(now).replaceAll(RegExp(r'\s'), ' '), '12:52 PM');
    });

    test('shows Yesterday', () {
      expect(
        record(startedAt: DateTime(2026, 8, 12, 18)).timeLabel(now),
        'Yesterday',
      );
    });

    test('shows the weekday earlier in the week', () {
      expect(
        record(startedAt: DateTime(2026, 8, 10, 18)).timeLabel(now),
        'Monday',
      );
    });

    test('shows the date beyond a week', () {
      expect(
        record(startedAt: DateTime(2026, 7, 30, 18)).timeLabel(now),
        '30 Jul',
      );
    });
  });
}
