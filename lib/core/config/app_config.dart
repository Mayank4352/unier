import 'package:flutter/foundation.dart';

/// Build-time configuration.
abstract final class AppConfig {
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue:
        '542184887753-002gprab9lr8st1v1auhfe1cbkgds9ps.apps.googleusercontent.com',
  );

  static const String appName = 'Unier';

  /// Seeds the empty call log with the rows from the design, for development.
  static const bool seedSampleCallLog = bool.fromEnvironment(
    'SEED_SAMPLE_CALL_LOG',
    defaultValue: kDebugMode,
  );
}
