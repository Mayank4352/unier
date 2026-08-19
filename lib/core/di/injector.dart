import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/data/datasources/google_auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/dev_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in_with_google.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/domain/usecases/watch_auth_state.dart';
import '../../features/auth/presentation/view_models/auth_view_model.dart';
import '../../features/calls/data/datasources/call_log_local_data_source.dart';
import '../../features/calls/data/datasources/quick_dial_local_data_source.dart';
import '../../features/calls/data/repositories/call_log_repository_impl.dart';
import '../../features/calls/data/repositories/quick_dial_repository_impl.dart';
import '../../features/calls/domain/repositories/call_log_repository.dart';
import '../../features/calls/domain/repositories/quick_dial_repository.dart';
import '../../features/calls/domain/usecases/get_quick_dial.dart';
import '../../features/calls/domain/usecases/get_recent_calls.dart';
import '../../features/calls/presentation/view_models/recents_view_model.dart';
import '../../features/contacts/data/datasources/device_contacts_data_source.dart';
import '../../features/contacts/data/repositories/contacts_repository_impl.dart';
import '../../features/contacts/domain/repositories/contacts_repository.dart';
import '../../features/contacts/domain/usecases/get_contacts.dart';
import '../../features/contacts/domain/usecases/open_contacts_settings.dart';
import '../../features/contacts/presentation/view_models/contacts_view_model.dart';
import '../../features/home/domain/usecases/get_greeting.dart';
import '../../features/home/presentation/view_models/home_view_model.dart';
import '../../features/settings/data/datasources/call_settings_local_data_source.dart';
import '../../features/settings/data/repositories/call_settings_repository_impl.dart';
import '../../features/settings/domain/repositories/call_settings_repository.dart';
import '../../features/settings/domain/usecases/get_call_settings.dart';
import '../../features/settings/domain/usecases/save_call_settings.dart';
import '../config/app_config.dart';
import '../storage/key_value_store.dart';
import '../storage/shared_preferences_store.dart';
import '../utils/clock.dart';

/// Composition root: data sources, then repositories, use cases, view models.
abstract final class Injector {
  static Future<List<SingleChildWidget>> resolve() async {
    final store = await SharedPreferencesStore.open();
    return providers(store);
  }

  /// Split out so tests can pass an [InMemoryKeyValueStore].
  static List<SingleChildWidget> providers(KeyValueStore store) {
    return <SingleChildWidget>[
      Provider<KeyValueStore>.value(value: store),
      Provider<Clock>.value(value: const SystemClock()),

      // Data sources.
      Provider<GoogleAuthDataSource>(create: (_) => GoogleAuthDataSource()),
      Provider<DeviceContactsDataSource>(
        create: (_) => const DeviceContactsDataSource(),
      ),
      Provider<CallLogLocalDataSource>(
        create: (context) => CallLogLocalDataSource(context.read()),
      ),
      Provider<QuickDialLocalDataSource>(
        create: (context) => QuickDialLocalDataSource(context.read()),
      ),
      Provider<CallSettingsLocalDataSource>(
        create: (context) => CallSettingsLocalDataSource(context.read()),
      ),

      // Repositories.
      Provider<AuthRepository>(
        create: (context) => AppConfig.useDevAuth
            ? DevAuthRepository()
            : AuthRepositoryImpl(context.read()),
      ),
      Provider<ContactsRepository>(
        create: (context) => ContactsRepositoryImpl(context.read()),
      ),
      Provider<CallLogRepository>(
        create: (context) =>
            CallLogRepositoryImpl(context.read(), context.read()),
      ),
      Provider<QuickDialRepository>(
        create: (context) => QuickDialRepositoryImpl(
          context.read(),
          context.read(),
          context.read(),
        ),
      ),
      Provider<CallSettingsRepository>(
        create: (context) => CallSettingsRepositoryImpl(context.read()),
      ),

      // Use cases.
      Provider<SignInWithGoogle>(
        create: (context) => SignInWithGoogle(context.read()),
      ),
      Provider<SignOut>(create: (context) => SignOut(context.read())),
      Provider<WatchAuthState>(
        create: (context) => WatchAuthState(context.read()),
      ),
      Provider<GetGreeting>(
        create: (context) => GetGreeting(context.read(), context.read()),
      ),
      Provider<GetRecentCalls>(
        create: (context) => GetRecentCalls(context.read()),
      ),
      Provider<GetQuickDial>(create: (context) => GetQuickDial(context.read())),
      Provider<GetCallSettings>(
        create: (context) => GetCallSettings(context.read()),
      ),
      Provider<SaveCallSettings>(
        create: (context) => SaveCallSettings(context.read()),
      ),
      Provider<GetContacts>(create: (context) => GetContacts(context.read())),
      Provider<OpenContactsSettings>(
        create: (context) => OpenContactsSettings(context.read()),
      ),

      // View models.
      ChangeNotifierProvider<AuthViewModel>(
        lazy: false,
        create: (context) => AuthViewModel(
          watchAuthState: context.read(),
          signInWithGoogle: context.read(),
          signOut: context.read(),
        ),
      ),
      ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(
          getGreeting: context.read(),
          getRecentCalls: context.read(),
          getQuickDial: context.read(),
          getCallSettings: context.read(),
          watchAuthState: context.read(),
          clock: context.read(),
        ),
      ),
      ChangeNotifierProvider<RecentsViewModel>(
        create: (context) => RecentsViewModel(
          getRecentCalls: context.read(),
          clock: context.read(),
        ),
      ),
      ChangeNotifierProvider<ContactsViewModel>(
        create: (context) => ContactsViewModel(
          getContacts: context.read(),
          openContactsSettings: context.read(),
        ),
      ),
    ];
  }
}
