import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:unier/core/theme/app_theme.dart';
import 'package:unier/core/utils/clock.dart';
import 'package:unier/core/utils/result.dart';
import 'package:unier/features/auth/domain/entities/app_user.dart';
import 'package:unier/features/auth/domain/repositories/auth_repository.dart';
import 'package:unier/features/auth/domain/usecases/watch_auth_state.dart';
import 'package:unier/features/calls/domain/entities/call_record.dart';
import 'package:unier/features/calls/domain/entities/quick_dial_entry.dart';
import 'package:unier/features/calls/domain/repositories/call_log_repository.dart';
import 'package:unier/features/calls/domain/repositories/quick_dial_repository.dart';
import 'package:unier/features/calls/domain/usecases/get_quick_dial.dart';
import 'package:unier/features/calls/domain/usecases/get_recent_calls.dart';
import 'package:unier/features/home/domain/usecases/get_greeting.dart';
import 'package:unier/features/home/presentation/view_models/home_view_model.dart';
import 'package:unier/features/home/presentation/views/home_view.dart';
import 'package:unier/features/settings/domain/entities/call_settings.dart';
import 'package:unier/features/settings/domain/repositories/call_settings_repository.dart';
import 'package:unier/features/settings/domain/usecases/get_call_settings.dart';

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this._user);

  final AppUser? _user;

  @override
  Stream<AppUser?> get authStateChanges => Stream<AppUser?>.value(_user);

  @override
  AppUser? get currentUser => _user;

  @override
  Future<Result<AppUser>> signInWithGoogle() => throw UnimplementedError();

  @override
  Future<Result<void>> signOut() => throw UnimplementedError();
}

class _FakeCallLogRepository implements CallLogRepository {
  _FakeCallLogRepository(this._records);

  final List<CallRecord> _records;

  @override
  Future<Result<List<CallRecord>>> getRecentCalls({int? limit}) async =>
      Result.ok(_records);
}

class _FakeQuickDialRepository implements QuickDialRepository {
  _FakeQuickDialRepository(this._entries);

  final List<QuickDialEntry> _entries;

  @override
  Future<Result<List<QuickDialEntry>>> getQuickDial({int? limit}) async =>
      Result.ok(_entries);
}

class _FakeCallSettingsRepository implements CallSettingsRepository {
  @override
  Future<Result<CallSettings>> load() async =>
      const Result.ok(CallSettings.defaults);

  @override
  Future<Result<CallSettings>> save(CallSettings settings) async =>
      Result.ok(settings);
}

void main() {
  final now = DateTime(2026, 8, 13, 14, 30);

  HomeViewModel buildViewModel({
    AppUser? user,
    List<CallRecord> records = const <CallRecord>[],
    List<QuickDialEntry> quickDial = const <QuickDialEntry>[],
  }) {
    final auth = _FakeAuthRepository(user);
    return HomeViewModel(
      getGreeting: GetGreeting(auth, FixedClock(now)),
      getRecentCalls: GetRecentCalls(_FakeCallLogRepository(records)),
      getQuickDial: GetQuickDial(_FakeQuickDialRepository(quickDial)),
      getCallSettings: GetCallSettings(_FakeCallSettingsRepository()),
      watchAuthState: WatchAuthState(auth),
      clock: FixedClock(now),
    );
  }

  Widget wrap(HomeViewModel viewModel) =>
      ChangeNotifierProvider<HomeViewModel>.value(
        value: viewModel,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(body: HomeView()),
          builder: (context, child) => AppResponsiveTheme(child: child!),
        ),
      );

  testWidgets('greets the signed-in person and lists their calls', (
    tester,
  ) async {
    final viewModel = buildViewModel(
      user: const AppUser(id: 'u1', displayName: 'Andu Sharma'),
      records: <CallRecord>[
        CallRecord(
          id: 'c1',
          contactName: 'Kid Pglu',
          direction: CallDirection.incoming,
          startedAt: DateTime(2026, 8, 13, 12, 52),
          duration: const Duration(minutes: 4, seconds: 12),
          captionLineCount: 14,
        ),
        CallRecord(
          id: 'c2',
          contactName: 'SAM',
          direction: CallDirection.missed,
          startedAt: DateTime(2026, 8, 12, 18),
        ),
      ],
      quickDial: const <QuickDialEntry>[
        QuickDialEntry(id: 'q1', displayName: 'Angle Operator'),
      ],
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(wrap(viewModel));
    await tester.pumpAndSettle();

    expect(find.text('Thursday, 13 August'), findsOneWidget);
    expect(find.text('Good afternoon, Andu'), findsOneWidget);
    expect(find.text('Ready for calls'), findsOneWidget);
    expect(find.text('Captions'), findsOneWidget);
    expect(find.text('On'), findsOneWidget);
    expect(find.text('Quick dial'), findsOneWidget);
    expect(find.text('AO'), findsOneWidget);
    expect(find.text('Angle Operator'), findsOneWidget);
    expect(find.text('Recent'), findsOneWidget);
    expect(find.text('See all'), findsOneWidget);
    expect(find.text('Kid Pglu'), findsOneWidget);
    expect(find.text('4 min 12 sec'), findsOneWidget);
    expect(find.text('14 lines'), findsOneWidget);
    expect(find.text('SAM'), findsOneWidget);
    expect(find.text('No answer'), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);
  });

  testWidgets('shows empty states with no data', (tester) async {
    final viewModel = buildViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(wrap(viewModel));
    await tester.pumpAndSettle();

    expect(find.text('Good afternoon'), findsOneWidget);
    expect(
      find.text('People you call often will show up here.'),
      findsOneWidget,
    );
    expect(find.text('Your recent calls will appear here.'), findsOneWidget);
    expect(find.text('See all'), findsNothing);
  });

  testWidgets('lays out without overflow on a small phone', (tester) async {
    tester.view.physicalSize = const Size(360 * 3, 640 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final viewModel = buildViewModel(
      user: const AppUser(id: 'u1', displayName: 'Andu'),
      quickDial: const <QuickDialEntry>[
        QuickDialEntry(id: 'q1', displayName: 'Angle Operator'),
        QuickDialEntry(id: 'q2', displayName: 'Sexy Jadoo'),
        QuickDialEntry(id: 'q3', displayName: 'Pretty'),
      ],
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(wrap(viewModel));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
