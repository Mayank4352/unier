import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/utils/clock.dart';
import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/domain/usecases/watch_auth_state.dart';
import '../../../calls/domain/entities/call_record.dart';
import '../../../calls/domain/entities/quick_dial_entry.dart';
import '../../../calls/domain/usecases/get_quick_dial.dart';
import '../../../calls/domain/usecases/get_recent_calls.dart';
import '../../../settings/domain/entities/call_settings.dart';
import '../../../settings/domain/usecases/get_call_settings.dart';
import '../../domain/entities/greeting.dart';
import '../../domain/usecases/get_greeting.dart';

// Backs the home screen: greeting, status card, quick dial and recent calls.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required GetGreeting getGreeting,
    required GetRecentCalls getRecentCalls,
    required GetQuickDial getQuickDial,
    required GetCallSettings getCallSettings,
    required WatchAuthState watchAuthState,
    required Clock clock,
  }) : _getGreeting = getGreeting,
       _getRecentCalls = getRecentCalls,
       _getQuickDial = getQuickDial,
       _getCallSettings = getCallSettings,
       _clock = clock {
    load = Command0<void>(_load)..addListener(notifyListeners);
    _subscription = watchAuthState().listen(_onUserChanged);
    unawaited(load.execute());
  }

  final GetGreeting _getGreeting;
  final GetRecentCalls _getRecentCalls;
  final GetQuickDial _getQuickDial;
  final GetCallSettings _getCallSettings;
  final Clock _clock;

  late final Command0<void> load;
  StreamSubscription<AppUser?>? _subscription;

  Greeting? _greeting;
  Greeting? get greeting => _greeting;

  List<CallRecord> _recentCalls = const <CallRecord>[];
  List<CallRecord> get recentCalls => _recentCalls;

  List<QuickDialEntry> _quickDial = const <QuickDialEntry>[];
  List<QuickDialEntry> get quickDial => _quickDial;

  CallSettings _settings = CallSettings.defaults;
  CallSettings get settings => _settings;

  // Reference time for relative labels such as "Yesterday".
  DateTime get now => _clock.now();

  Future<void> refresh() => load.execute();

  Future<Result<void>> _load() async {
    final greeting = await _getGreeting();
    if (greeting case Ok<Greeting>(:final value)) {
      _greeting = value;
    }

    final settings = await _getCallSettings();
    if (settings case Ok<CallSettings>(:final value)) {
      _settings = value;
    }

    final quickDial = await _getQuickDial(QuickDialLimit.home);
    if (quickDial case Ok<List<QuickDialEntry>>(:final value)) {
      _quickDial = value;
    }

    final recent = await _getRecentCalls(RecentCallsLimit.homePreview);
    if (recent case Ok<List<CallRecord>>(:final value)) {
      _recentCalls = value;
    }

    // Report the first failure, if any: partial data is still worth showing.
    for (final result in <Result<Object?>>[
      greeting,
      settings,
      quickDial,
      recent,
    ]) {
      if (result case Err<Object?>(:final failure)) return Result.err(failure);
    }
    return const Result.ok(null);
  }

  void _onUserChanged(AppUser? user) {
    _greeting = _greeting?.withName(user?.givenName);
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    load.dispose();
    super.dispose();
  }
}
