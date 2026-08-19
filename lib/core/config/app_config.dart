import 'package:flutter/foundation.dart';

// Build-time configuration.
abstract final class AppConfig {
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue:
        '542184887753-002gprab9lr8st1v1auhfe1cbkgds9ps.apps.googleusercontent.com',
  );

  static const String appName = 'Unier';

  // Skips Google sign-in and runs as devUserName. Never on in release.
  static const bool useDevAuth =
      bool.fromEnvironment('DEV_AUTH') && !kReleaseMode;

  static const String devUserName = String.fromEnvironment(
    'DEV_AUTH_NAME',
    defaultValue: 'Andu',
  );
}
