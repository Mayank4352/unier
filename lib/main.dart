import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unier/theme/themes.dart';
import 'package:unier/utils/routes.dart';
import 'package:unier/view/screen/chat_screen.dart';
import 'package:unier/view/screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const HomeScreen(),
      routes: {
         appRoutes.chatScreen: (context) => const ChatScreen(),
      },
    );
  }
}
