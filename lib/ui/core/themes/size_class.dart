import 'package:flutter/widgets.dart';

/// Width breakpoints, following the Material 3 window size classes.
///
/// Every responsive decision in the app derives from this enum instead of
/// comparing raw pixel widths at the call site.
enum SizeClass {
  /// Phones in portrait. Below [compactMaxWidth].
  compact(compactMaxWidth),

  /// Large phones in landscape, small tablets. Below [mediumMaxWidth].
  medium(mediumMaxWidth),

  /// Tablets and desktop windows.
  expanded(double.infinity);

  const SizeClass(this.maxWidth);

  /// Exclusive upper bound of this size class, in logical pixels.
  final double maxWidth;

  /// Upper bound of [SizeClass.compact].
  static const double compactMaxWidth = 600;

  /// Upper bound of [SizeClass.medium].
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
