import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:unier/firebase_options.dart';
import 'package:unier/theme/themes.dart';
import 'package:unier/utils/routes.dart';
import 'package:unier/view/screen/auth_screen.dart';
import 'package:unier/view/screen/chat_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Request permissions for LiveKit
  await requestPermissions();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> requestPermissions() async {
  await [
    Permission.microphone,
    Permission.camera, // Add camera permission
  ].request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Unier',
      theme: Themes.getLightTheme(),
      darkTheme: Themes.getDarkTheme(),
      themeMode: ThemeMode.dark,
      // initialBinding: InitialBinding(),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: AppRoutes.chatScreen,
          page: () => const ChatScreen(),
        ),
        // GetPage(
        //   name: AppRoutes.callRoom,
        //   page: () => const CallRoomScreen(),
        //   binding: CallBinding(),
        // ),
      ],
    );
  }
}
