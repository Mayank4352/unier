import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

// Wires the `logging` package into the Dart DevTools console.
abstract final class AppLogger {
  // Installs the root logger listener.
  static void configure() {
    Logger.root.level = kReleaseMode ? Level.WARNING : Level.ALL;
    Logger.root.onRecord.listen((record) {
      developer.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });
  }
}
