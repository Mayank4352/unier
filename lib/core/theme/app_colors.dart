import 'package:flutter/material.dart';

// Semantic colour roles for the Unier design system.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brightness,
    required this.canvas,
    required this.surface,
    required this.surfaceElevated,
    required this.fill,
    required this.label,
    required this.secondaryLabel,
    required this.accent,
    required this.onAccent,
    required this.destructive,
    required this.positive,
    required this.separator,
    required this.avatarFill,
    required this.onAvatar,
    required this.translucentSurface,
  });

  static const AppColors light = AppColors(
    brightness: Brightness.light,
    canvas: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    fill: Color(0xFFF2F2F7),
    label: Color(0xFF1C1C1E),
    secondaryLabel: Color(0xFF8E8E93),
    accent: Color(0xFF007AFF),
    onAccent: Color(0xFFFFFFFF),
    destructive: Color(0xFFFF3B30),
    positive: Color(0xFF34C759),
    separator: Color(0xFFE5E5EA),
    avatarFill: Color(0xFFC7C7CC),
    onAvatar: Color(0xFFFFFFFF),
    translucentSurface: Color(0xE6FFFFFF),
  );

  static const AppColors dark = AppColors(
    brightness: Brightness.dark,
    canvas: Color(0xFF000000),
    surface: Color(0xFF1C1C1E),
    surfaceElevated: Color(0xFF2C2C2E),
    fill: Color(0xFF2C2C2E),
    label: Color(0xFFF2F2F7),
    secondaryLabel: Color(0xFF8E8E93),
    accent: Color(0xFF0A84FF),
    onAccent: Color(0xFFFFFFFF),
    destructive: Color(0xFFFF453A),
    positive: Color(0xFF30D158),
    separator: Color(0xFF38383A),
    avatarFill: Color(0xFF48484A),
    onAvatar: Color(0xFFFFFFFF),
    translucentSurface: Color(0xE61C1C1E),
  );

  final Brightness brightness;
  final Color canvas;
  final Color surface;
  final Color surfaceElevated;
  final Color fill;
  final Color label;
  final Color secondaryLabel;
  final Color accent;
  final Color onAccent;
  final Color destructive;
  final Color positive;
  final Color separator;
  final Color avatarFill;
  final Color onAvatar;
  final Color translucentSurface;

  @override
  AppColors copyWith({
    Brightness? brightness,
    Color? canvas,
    Color? surface,
    Color? surfaceElevated,
    Color? fill,
    Color? label,
    Color? secondaryLabel,
    Color? accent,
    Color? onAccent,
    Color? destructive,
    Color? positive,
    Color? separator,
    Color? avatarFill,
    Color? onAvatar,
    Color? translucentSurface,
  }) {
    return AppColors(
      brightness: brightness ?? this.brightness,
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      fill: fill ?? this.fill,
      label: label ?? this.label,
      secondaryLabel: secondaryLabel ?? this.secondaryLabel,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      destructive: destructive ?? this.destructive,
      positive: positive ?? this.positive,
      separator: separator ?? this.separator,
      avatarFill: avatarFill ?? this.avatarFill,
      onAvatar: onAvatar ?? this.onAvatar,
      translucentSurface: translucentSurface ?? this.translucentSurface,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      fill: Color.lerp(fill, other.fill, t)!,
      label: Color.lerp(label, other.label, t)!,
      secondaryLabel: Color.lerp(secondaryLabel, other.secondaryLabel, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      separator: Color.lerp(separator, other.separator, t)!,
      avatarFill: Color.lerp(avatarFill, other.avatarFill, t)!,
      onAvatar: Color.lerp(onAvatar, other.onAvatar, t)!,
      translucentSurface: Color.lerp(
        translucentSurface,
        other.translucentSurface,
        t,
      )!,
    );
  }

  // Builds the Material ColorScheme that mirrors this palette, so framework
  ColorScheme toColorScheme() => ColorScheme(
    brightness: brightness,
    primary: accent,
    onPrimary: onAccent,
    secondary: accent,
    onSecondary: onAccent,
    error: destructive,
    onError: onAccent,
    surface: surface,
    onSurface: label,
    surfaceContainerLowest: canvas,
    surfaceContainerHighest: fill,
    onSurfaceVariant: secondaryLabel,
    outlineVariant: separator,
  );
}
