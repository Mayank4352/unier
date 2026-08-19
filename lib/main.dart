import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/config/app_config.dart';
import 'core/di/injector.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_logger.dart';
import 'features/auth/presentation/view_models/auth_view_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.configure();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(UnierApp(providers: await Injector.resolve()));
}

// Root widget: installs the dependency graph, then the router.
class UnierApp extends StatelessWidget {
  const UnierApp({required this.providers, super.key});

  final List<SingleChildWidget> providers;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providers, child: const _RoutedApp());
  }
}

class _RoutedApp extends StatefulWidget {
  const _RoutedApp();

  @override
  State<_RoutedApp> createState() => _RoutedAppState();
}

class _RoutedAppState extends State<_RoutedApp> {
  late final GoRouter _router = createAppRouter(context.read<AuthViewModel>());

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
      builder: (context, child) => AppResponsiveTheme(child: child!),
    );
  }
}
