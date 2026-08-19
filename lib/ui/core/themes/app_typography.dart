import 'package:flutter/material.dart';

/// The app's type ramp.
///
/// Styles deliberately carry no colour: a colour is a semantic role that the
/// widget picks from `context.colors`, which keeps a single ramp usable in
/// every palette. Sizes are scaled by the active [Dimens] scale so type grows
/// with the window, on top of the user's own text-scale preference.
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

  /// Builds the ramp at [scale], where 1 is the Figma frame's native scale.
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
      avatarInitials: style(
        size: 22,
        weight: FontWeight.w500,
        lineHeight: 33,
      ),
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

  /// Family bundled in `assets/fonts`.
  static const String fontFamily = 'Inter';

  /// Date line above the greeting.
  final TextStyle greetingDate;

  /// "Good afternoon, <name>".
  final TextStyle greetingTitle;

  /// "Quick dial", "Recent".
  final TextStyle sectionHeader;

  /// "See all" and other inline actions.
  final TextStyle link;

  /// Title inside a card.
  final TextStyle cardTitle;

  /// Body copy inside a card.
  final TextStyle cardBody;

  /// Caption above a chip's value.
  final TextStyle chipLabel;

  /// A chip's value.
  final TextStyle chipValue;

  /// Initials drawn inside an avatar.
  final TextStyle avatarInitials;

  /// Name under a quick-dial avatar.
  final TextStyle quickDialName;

  /// Primary line of a call-log row.
  final TextStyle listTitle;

  /// Secondary line of a call-log row.
  final TextStyle listSubtitle;

  /// Timestamp at the end of a call-log row.
  final TextStyle listTrailing;

  /// Label under a navigation-bar icon.
  final TextStyle navLabel;

  /// Maps the ramp onto Material's [TextTheme] so framework widgets inherit it.
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
