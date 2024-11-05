import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unier/firebase_options.dart';
import 'package:unier/theme/themes.dart';
import 'package:unier/utils/routes.dart';
import 'package:unier/view/screen/auth_screen.dart';
import 'package:unier/view/screen/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unier',
      theme: Themes.getLightTheme(),
      darkTheme: Themes.getDarkTheme(),
      themeMode: ThemeMode.dark,
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
      routes: {
        appRoutes.chatScreen: (context) => const ChatScreen(),
      },
    );
  }
}
