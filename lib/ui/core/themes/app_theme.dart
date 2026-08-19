import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'dimens.dart';
import 'size_class.dart';

/// Assembles [ThemeData] from the app's design tokens.
///
/// A theme is a function of (palette, size class): the palette decides colour,
/// the size class decides how large the whole design renders. Results are
/// memoised because [AppResponsiveTheme] rebuilds on every window resize.
abstract final class AppTheme {
  static final Map<(Brightness, SizeClass), ThemeData> _cache = {};

  /// The light theme at [sizeClass].
  static ThemeData light({SizeClass sizeClass = SizeClass.compact}) =>
      _resolve(AppColors.light, sizeClass);

  /// The dark theme at [sizeClass].
  static ThemeData dark({SizeClass sizeClass = SizeClass.compact}) =>
      _resolve(AppColors.dark, sizeClass);

  static ThemeData _resolve(AppColors colors, SizeClass sizeClass) {
    return _cache.putIfAbsent(
      (colors.brightness, sizeClass),
      () => _build(colors, sizeClass),
    );
  }

  static ThemeData _build(AppColors colors, SizeClass sizeClass) {
    final dimens = Dimens.forSizeClass(sizeClass);
    final typography = AppTypography.scaled(dimens.scale);

    return ThemeData(
      useMaterial3: true,
      brightness: colors.brightness,
      colorScheme: colors.toColorScheme(),
      scaffoldBackgroundColor: colors.canvas,
      fontFamily: AppTypography.fontFamily,
      textTheme: typography.toTextTheme().apply(
        bodyColor: colors.label,
        displayColor: colors.label,
      ),
      splashFactory: InkSparkle.splashFactory,
      dividerTheme: DividerThemeData(
        color: colors.separator,
        thickness: dimens.separatorThickness,
        space: dimens.separatorThickness,
      ),
      iconTheme: IconThemeData(color: colors.label, size: dimens.iconLg),
      extensions: <ThemeExtension<dynamic>>[colors, dimens, typography],
    );
  }
}

/// Rebuilds the theme whenever the window crosses a [SizeClass] boundary.
///
/// Wraps the app below `MaterialApp` so `context.dimens` and
/// `context.textStyles` are always resolved for the current window.
class AppResponsiveTheme extends StatelessWidget {
  const AppResponsiveTheme({required this.child, super.key});

  /// The subtree that reads the resolved theme.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sizeClass = SizeClass.of(context);
    final brightness = Theme.of(context).brightness;

    return Theme(
      data: brightness == Brightness.dark
          ? AppTheme.dark(sizeClass: sizeClass)
          : AppTheme.light(sizeClass: sizeClass),
      child: child,
    );
  }
}
