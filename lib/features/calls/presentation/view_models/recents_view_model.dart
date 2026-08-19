import 'package:flutter/foundation.dart';

import '../../../../core/utils/clock.dart';
import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/call_record.dart';
import '../../domain/usecases/get_recent_calls.dart';

/// Backs the Recents tab: the full call history.
class RecentsViewModel extends ChangeNotifier {
  RecentsViewModel({
    required GetRecentCalls getRecentCalls,
    required Clock clock,
  }) : _getRecentCalls = getRecentCalls,
       _clock = clock {
    load = Command0<void>(_load)..addListener(notifyListeners);
    load.execute();
  }

  final GetRecentCalls _getRecentCalls;
  final Clock _clock;

  late final Command0<void> load;

  List<CallRecord> _records = const <CallRecord>[];
  List<CallRecord> get records => _records;

  DateTime get now => _clock.now();

  Future<void> refresh() => load.execute();

  Future<Result<void>> _load() async {
    final result = await _getRecentCalls(RecentCallsLimit.full);
    return switch (result) {
      Ok<List<CallRecord>>(:final value) => () {
        _records = value;
        return const Result<void>.ok(null);
      }(),
      Err<List<CallRecord>>(:final failure) => Result<void>.err(failure),
    };
  }

  @override
  void dispose() {
    load.dispose();
    super.dispose();
  }
}
