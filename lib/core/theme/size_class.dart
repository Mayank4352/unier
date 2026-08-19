import 'package:flutter/widgets.dart';

/// Width breakpoints, following the Material 3 window size classes.
enum SizeClass {
  /// Phones in portrait. Below [compactMaxWidth].
  compact(compactMaxWidth),

  /// Large phones in landscape, small tablets. Below [mediumMaxWidth].
  medium(mediumMaxWidth),

  /// Tablets and desktop windows.
  expanded(double.infinity);

  const SizeClass(this.maxWidth);
  final double maxWidth;
  static const double compactMaxWidth = 600;
  static const double mediumMaxWidth = 840;

  /// Resolves the size class for the nearest [MediaQuery] above [context].
  static SizeClass of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  /// Resolves the size class for an arbitrary [width].
  static SizeClass fromWidth(double width) => switch (width) {
    < compactMaxWidth => SizeClass.compact,
    < mediumMaxWidth => SizeClass.medium,
    _ => SizeClass.expanded,
  };
}
