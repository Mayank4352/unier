import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view_models/auth_view_model.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/splash_view.dart';
import '../../features/calls/presentation/views/recents_view.dart';
import '../../features/contacts/presentation/views/contacts_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/shell/presentation/views/app_shell.dart';
import 'app_routes.dart';

// Builds the router, redirecting on every change of authViewModel.
GoRouter createAppRouter(AuthViewModel authViewModel) {
  return GoRouter(
    initialLocation: AppRoutes.homePath,
    refreshListenable: authViewModel,
    redirect: (context, state) => _redirect(authViewModel, state),
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.signInPath,
        name: AppRoutes.signInName,
        builder: (context, state) => const LoginView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.homePath,
                name: AppRoutes.homeName,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.contactsPath,
                name: AppRoutes.contactsName,
                builder: (context, state) => const ContactsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.recentsPath,
                name: AppRoutes.recentsName,
                builder: (context, state) => const RecentsView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

String? _redirect(AuthViewModel auth, GoRouterState state) {
  final location = state.matchedLocation;

  if (auth.isResolving) {
    return location == AppRoutes.splashPath ? null : AppRoutes.splashPath;
  }
  if (!auth.isSignedIn) {
    return location == AppRoutes.signInPath ? null : AppRoutes.signInPath;
  }
  if (location == AppRoutes.signInPath || location == AppRoutes.splashPath) {
    return AppRoutes.homePath;
  }
  return null;
}
