import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'dimens.dart';
import 'size_class.dart';

// Assembles ThemeData from the app's design tokens.
abstract final class AppTheme {
  static final Map<(Brightness, SizeClass), ThemeData> _cache = {};

  // The light theme at sizeClass.
  static ThemeData light({SizeClass sizeClass = SizeClass.compact}) =>
      _resolve(AppColors.light, sizeClass);

  // The dark theme at sizeClass.
  static ThemeData dark({SizeClass sizeClass = SizeClass.compact}) =>
      _resolve(AppColors.dark, sizeClass);

  static ThemeData _resolve(AppColors colors, SizeClass sizeClass) {
    return _cache.putIfAbsent((
      colors.brightness,
      sizeClass,
    ), () => _build(colors, sizeClass));
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

// Rebuilds the theme whenever the window crosses a SizeClass boundary.
class AppResponsiveTheme extends StatelessWidget {
  const AppResponsiveTheme({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sizeClass = SizeClass.of(context);
    final brightness = Theme.of(context).brightness;

    final isDark = brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            ),
      child: Theme(
        data: isDark
            ? AppTheme.dark(sizeClass: sizeClass)
            : AppTheme.light(sizeClass: sizeClass),
        child: child,
      ),
    );
  }
}
