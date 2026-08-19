import 'package:flutter_test/flutter_test.dart';
import 'package:unier/core/utils/result.dart';
import 'package:unier/features/calls/domain/entities/call_record.dart';
import 'package:unier/features/calls/domain/repositories/call_log_repository.dart';
import 'package:unier/features/calls/domain/usecases/get_recent_calls.dart';

class _FakeCallLogRepository implements CallLogRepository {
  _FakeCallLogRepository(this.records);

  final List<CallRecord> records;
  int? lastLimit;

  @override
  Future<Result<List<CallRecord>>> getRecentCalls({int? limit}) async {
    lastLimit = limit;
    return Result.ok(records);
  }
}

void main() {
  CallRecord record(String id, DateTime startedAt) => CallRecord(
    id: id,
    contactName: id,
    direction: CallDirection.incoming,
    startedAt: startedAt,
  );

  test('sorts newest first', () async {
    final repository = _FakeCallLogRepository(<CallRecord>[
      record('older', DateTime(2026, 8, 12)),
      record('newest', DateTime(2026, 8, 13, 12)),
      record('oldest', DateTime(2026, 8, 1)),
    ]);

    final result = await GetRecentCalls(repository)(null);

    expect(result, isA<Ok<List<CallRecord>>>());
    expect(
      (result as Ok<List<CallRecord>>).value.map((r) => r.id),
      <String>['newest', 'older', 'oldest'],
    );
  });

  test('passes the limit through to the repository', () async {
    final repository = _FakeCallLogRepository(const <CallRecord>[]);

    await GetRecentCalls(repository)(RecentCallsLimit.homePreview);

    expect(repository.lastLimit, RecentCallsLimit.homePreview);
  });
}
