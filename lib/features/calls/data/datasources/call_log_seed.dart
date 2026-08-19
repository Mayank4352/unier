import '../../domain/entities/call_record.dart';

/// Placeholder call history used until the call feature writes real rows.
abstract final class CallLogSeed {
  static List<CallRecord> forDate(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    return <CallRecord>[
      CallRecord(
        id: 'seed-1',
        contactName: 'Kid Pglu',
        direction: CallDirection.incoming,
        startedAt: today.add(const Duration(hours: 12, minutes: 52)),
        duration: const Duration(minutes: 4, seconds: 12),
        captionLineCount: 14,
      ),
      CallRecord(
        id: 'seed-2',
        contactName: 'Aranav',
        direction: CallDirection.outgoing,
        startedAt: today.add(const Duration(hours: 9, minutes: 52)),
        duration: const Duration(minutes: 6, seconds: 58),
        captionLineCount: 26,
      ),
      CallRecord(
        id: 'seed-3',
        contactName: 'SAM',
        direction: CallDirection.missed,
        startedAt: yesterday.add(const Duration(hours: 18, minutes: 20)),
      ),
      CallRecord(
        id: 'seed-4',
        contactName: 'Chand',
        direction: CallDirection.missed,
        startedAt: yesterday.add(const Duration(hours: 16, minutes: 5)),
      ),
    ];
  }
}
