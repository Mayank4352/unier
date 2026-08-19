import 'package:flutter/material.dart';

// The app's type ramp.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.greetingDate,
    required this.greetingTitle,
    required this.sectionHeader,
    required this.link,
    required this.cardTitle,
    required this.cardBody,
    required this.chipLabel,
    required this.chipValue,
    required this.avatarInitials,
    required this.quickDialName,
    required this.listTitle,
    required this.listSubtitle,
    required this.listTrailing,
    required this.navLabel,
  });

  // Builds the ramp at scale, where 1 is the Figma frame's native scale.
  factory AppTypography.scaled(double scale) {
    TextStyle style({
      required double size,
      required FontWeight weight,
      required double lineHeight,
      double letterSpacing = 0,
    }) {
      final scaledSize = size * scale;
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: scaledSize,
        fontWeight: weight,
        // Flutter expresses line height as a multiple of the font size, so the
        // design's absolute leading is divided out here and stays correct at
        // any scale.
        height: lineHeight / size,
        letterSpacing: letterSpacing * scale,
      );
    }

    return AppTypography(
      greetingDate: style(
        size: 13,
        weight: FontWeight.w500,
        lineHeight: 19.5,
        letterSpacing: 0.78,
      ),
      greetingTitle: style(
        size: 34,
        weight: FontWeight.w700,
        lineHeight: 42.5,
        letterSpacing: -0.68,
      ),
      sectionHeader: style(
        size: 13,
        weight: FontWeight.w600,
        lineHeight: 19.5,
        letterSpacing: 0.78,
      ),
      link: style(size: 13, weight: FontWeight.w500, lineHeight: 19.5),
      cardTitle: style(size: 17, weight: FontWeight.w600, lineHeight: 25.5),
      cardBody: style(size: 13, weight: FontWeight.w400, lineHeight: 21.125),
      chipLabel: style(
        size: 11,
        weight: FontWeight.w400,
        lineHeight: 16.5,
        letterSpacing: 0.44,
      ),
      chipValue: style(size: 13, weight: FontWeight.w500, lineHeight: 19.5),
      avatarInitials: style(size: 22, weight: FontWeight.w500, lineHeight: 33),
      quickDialName: style(size: 12, weight: FontWeight.w400, lineHeight: 18),
      listTitle: style(size: 17, weight: FontWeight.w400, lineHeight: 21.25),
      listSubtitle: style(size: 13, weight: FontWeight.w400, lineHeight: 19.5),
      listTrailing: style(size: 15, weight: FontWeight.w400, lineHeight: 22.5),
      navLabel: style(
        size: 10,
        weight: FontWeight.w500,
        lineHeight: 15,
        letterSpacing: -0.25,
      ),
    );
  }

  static const String fontFamily = 'Inter';
  final TextStyle greetingDate;
  final TextStyle greetingTitle;
  final TextStyle sectionHeader;
  final TextStyle link;
  final TextStyle cardTitle;
  final TextStyle cardBody;
  final TextStyle chipLabel;
  final TextStyle chipValue;
  final TextStyle avatarInitials;
  final TextStyle quickDialName;
  final TextStyle listTitle;
  final TextStyle listSubtitle;
  final TextStyle listTrailing;
  final TextStyle navLabel;

  // Maps the ramp onto Material's TextTheme so framework widgets inherit it.
  TextTheme toTextTheme() => TextTheme(
    displaySmall: greetingTitle,
    headlineSmall: greetingTitle,
    titleLarge: cardTitle,
    titleMedium: listTitle,
    titleSmall: sectionHeader,
    bodyLarge: listTitle,
    bodyMedium: cardBody,
    bodySmall: listSubtitle,
    labelLarge: chipValue,
    labelMedium: quickDialName,
    labelSmall: navLabel,
  );

  @override
  AppTypography copyWith({
    TextStyle? greetingDate,
    TextStyle? greetingTitle,
    TextStyle? sectionHeader,
    TextStyle? link,
    TextStyle? cardTitle,
    TextStyle? cardBody,
    TextStyle? chipLabel,
    TextStyle? chipValue,
    TextStyle? avatarInitials,
    TextStyle? quickDialName,
    TextStyle? listTitle,
    TextStyle? listSubtitle,
    TextStyle? listTrailing,
    TextStyle? navLabel,
  }) {
    return AppTypography(
      greetingDate: greetingDate ?? this.greetingDate,
      greetingTitle: greetingTitle ?? this.greetingTitle,
      sectionHeader: sectionHeader ?? this.sectionHeader,
      link: link ?? this.link,
      cardTitle: cardTitle ?? this.cardTitle,
      cardBody: cardBody ?? this.cardBody,
      chipLabel: chipLabel ?? this.chipLabel,
      chipValue: chipValue ?? this.chipValue,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      quickDialName: quickDialName ?? this.quickDialName,
      listTitle: listTitle ?? this.listTitle,
      listSubtitle: listSubtitle ?? this.listSubtitle,
      listTrailing: listTrailing ?? this.listTrailing,
      navLabel: navLabel ?? this.navLabel,
    );
  }

  @override
  AppTypography lerp(covariant AppTypography? other, double t) {
    if (other == null) return this;
    return AppTypography(
      greetingDate: TextStyle.lerp(greetingDate, other.greetingDate, t)!,
      greetingTitle: TextStyle.lerp(greetingTitle, other.greetingTitle, t)!,
      sectionHeader: TextStyle.lerp(sectionHeader, other.sectionHeader, t)!,
      link: TextStyle.lerp(link, other.link, t)!,
      cardTitle: TextStyle.lerp(cardTitle, other.cardTitle, t)!,
      cardBody: TextStyle.lerp(cardBody, other.cardBody, t)!,
      chipLabel: TextStyle.lerp(chipLabel, other.chipLabel, t)!,
      chipValue: TextStyle.lerp(chipValue, other.chipValue, t)!,
      avatarInitials: TextStyle.lerp(avatarInitials, other.avatarInitials, t)!,
      quickDialName: TextStyle.lerp(quickDialName, other.quickDialName, t)!,
      listTitle: TextStyle.lerp(listTitle, other.listTitle, t)!,
      listSubtitle: TextStyle.lerp(listSubtitle, other.listSubtitle, t)!,
      listTrailing: TextStyle.lerp(listTrailing, other.listTrailing, t)!,
      navLabel: TextStyle.lerp(navLabel, other.navLabel, t)!,
    );
  }
}
