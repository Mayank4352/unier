import 'package:intl/intl.dart';

import '../../domain/entities/call_record.dart';

extension CallRecordFormatter on CallRecord {
  /// "6 min 58 sec", or null when the call never connected.
  String? get durationLabel {
    final elapsed = duration;
    if (elapsed == null) return null;

    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes.remainder(Duration.minutesPerHour);
    final seconds = elapsed.inSeconds.remainder(Duration.secondsPerMinute);

    return <String>[
      if (hours > 0) '$hours hr',
      if (hours > 0 || minutes > 0) '$minutes min',
      '$seconds sec',
    ].join(' ');
  }

  /// "14 lines", or null when nothing was transcribed.
  String? get captionLabel {
    final lines = captionLineCount;
    if (lines == null || lines <= 0) return null;
    return Intl.plural(lines, one: '$lines line', other: '$lines lines');
  }

  /// Second line of a missed call.
  String get missedLabel => 'No answer';

  /// "12:52 PM" today, "Yesterday", a weekday this week, "13 Aug" beyond that.
  String timeLabel(DateTime now) {
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfCall = DateTime(
      startedAt.year,
      startedAt.month,
      startedAt.day,
    );
    final daysAgo = startOfToday.difference(startOfCall).inDays;

    return switch (daysAgo) {
      <= 0 => DateFormat.jm().format(startedAt),
      1 => 'Yesterday',
      < DateTime.daysPerWeek => DateFormat.EEEE().format(startedAt),
      _ => DateFormat('d MMM').format(startedAt),
    };
  }
}
