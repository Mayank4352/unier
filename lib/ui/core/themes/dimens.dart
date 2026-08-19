import 'package:flutter/material.dart';

import 'size_class.dart';

/// Every spacing, size and radius used by the app, in one place.
///
/// Values are the measurements taken from the 402pt-wide Figma frame; each one
/// is multiplied by [scale] so the same layout grows on larger windows instead
/// of leaving a phone-sized column stranded in the middle of a tablet. No
/// widget in the app may hard-code a dimension — it reads it from
/// `context.dimens`.
@immutable
class Dimens extends ThemeExtension<Dimens> {
  const Dimens({
    required this.sizeClass,
    required this.scale,
    required this.maxContentWidth,
  });

  /// Phone-sized windows render the design at its native scale.
  static const Dimens compact = Dimens(
    sizeClass: SizeClass.compact,
    scale: 1,
    maxContentWidth: double.infinity,
  );

  /// Small tablets get a slightly larger scale and a bounded column.
  static const Dimens medium = Dimens(
    sizeClass: SizeClass.medium,
    scale: 1.08,
    maxContentWidth: 600,
  );

  /// Large tablets and desktop windows.
  static const Dimens expanded = Dimens(
    sizeClass: SizeClass.expanded,
    scale: 1.15,
    maxContentWidth: 720,
  );

  /// Returns the token set for [sizeClass].
  factory Dimens.forSizeClass(SizeClass sizeClass) => switch (sizeClass) {
    SizeClass.compact => compact,
    SizeClass.medium => medium,
    SizeClass.expanded => expanded,
  };

  /// The window size class these tokens were resolved for.
  final SizeClass sizeClass;

  /// Multiplier applied to every design measurement.
  final double scale;

  /// Upper bound for a readable content column.
  final double maxContentWidth;

  // --- Design measurements, in logical pixels at scale 1. -------------------

  static const double _spaceXxs = 2;
  static const double _spaceXs = 4;
  static const double _spaceSm = 8;
  static const double _spaceMd = 12;
  static const double _spaceLg = 16;
  static const double _spaceXl = 24;
  static const double _spaceXxl = 32;

  static const double _screenPaddingHorizontal = 16;
  static const double _screenPaddingTop = 8;
  static const double _sectionSpacing = 24;
  static const double _sectionHeaderSpacing = 12;

  static const double _radiusCard = 14;
  static const double _radiusChip = 10;
  static const double _radiusFull = 9999;

  static const double _separatorThickness = 0.57;

  static const double _iconSm = 14;
  static const double _iconMd = 16;
  static const double _iconLg = 24;

  static const double _statusDotSize = 8;
  static const double _avatarSize = 64;
  static const double _quickDialItemWidth = 68;
  static const double _chipHeight = 52;
  static const double _listRowHeight = 67;
  static const double _listLeadingWidth = 44;
  static const double _navBarContentHeight = 59;
  static const double _navBarBlurSigma = 12;

  // --- Resolved tokens. -----------------------------------------------------

  /// 2pt. Hairline nudges.
  double get spaceXxs => _spaceXxs * scale;

  /// 4pt.
  double get spaceXs => _spaceXs * scale;

  /// 8pt.
  double get spaceSm => _spaceSm * scale;

  /// 12pt.
  double get spaceMd => _spaceMd * scale;

  /// 16pt. The default gutter.
  double get spaceLg => _spaceLg * scale;

  /// 24pt.
  double get spaceXl => _spaceXl * scale;

  /// 32pt.
  double get spaceXxl => _spaceXxl * scale;

  /// Left and right gutter of every screen.
  double get screenPaddingHorizontal => _screenPaddingHorizontal * scale;

  /// Gap between the safe area and the first element of a screen.
  double get screenPaddingTop => _screenPaddingTop * scale;

  /// Vertical gap between two top-level sections.
  double get sectionSpacing => _sectionSpacing * scale;

  /// Gap between a section header and its content.
  double get sectionHeaderSpacing => _sectionHeaderSpacing * scale;

  /// Corner radius of cards and grouped lists.
  double get radiusCard => _radiusCard * scale;

  /// Corner radius of inline chips.
  double get radiusChip => _radiusChip * scale;

  /// Radius that produces a pill or circle.
  double get radiusFull => _radiusFull;

  /// Thickness of a hairline divider.
  double get separatorThickness => _separatorThickness;

  /// 14pt inline icon.
  double get iconSm => _iconSm * scale;

  /// 16pt leading icon.
  double get iconMd => _iconMd * scale;

  /// 24pt navigation icon.
  double get iconLg => _iconLg * scale;

  /// Diameter of the availability dot.
  double get statusDotSize => _statusDotSize * scale;

  /// Diameter of a quick-dial avatar.
  double get avatarSize => _avatarSize * scale;

  /// Width of one quick-dial column, including its label.
  double get quickDialItemWidth => _quickDialItemWidth * scale;

  /// Horizontal gap between quick-dial columns.
  double get quickDialSpacing => _spaceXl * scale;

  /// Height of a settings chip.
  double get chipHeight => _chipHeight * scale;

  /// Height of a call-log row.
  double get listRowHeight => _listRowHeight * scale;

  /// Width reserved for a row's leading icon, including its gutter.
  double get listLeadingWidth => _listLeadingWidth * scale;

  /// Height of the bottom navigation bar, excluding the safe-area inset.
  double get navBarContentHeight => _navBarContentHeight * scale;

  /// Gaussian blur applied behind the navigation bar.
  double get navBarBlurSigma => _navBarBlurSigma;

  /// Insets for the body of a card.
  EdgeInsets get cardPadding => EdgeInsets.all(spaceLg);

  /// Horizontal insets for a screen's content.
  EdgeInsets get screenPadding =>
      EdgeInsets.symmetric(horizontal: screenPaddingHorizontal);

  /// Rounded rectangle border used by cards.
  BorderRadius get cardBorderRadius => BorderRadius.circular(radiusCard);

  /// Rounded rectangle border used by chips.
  BorderRadius get chipBorderRadius => BorderRadius.circular(radiusChip);

  @override
  Dimens copyWith({
    SizeClass? sizeClass,
    double? scale,
    double? maxContentWidth,
  }) {
    return Dimens(
      sizeClass: sizeClass ?? this.sizeClass,
      scale: scale ?? this.scale,
      maxContentWidth: maxContentWidth ?? this.maxContentWidth,
    );
  }

  @override
  Dimens lerp(covariant Dimens? other, double t) {
    if (other == null) return this;
    return Dimens(
      sizeClass: t < 0.5 ? sizeClass : other.sizeClass,
      scale: lerpDouble(scale, other.scale, t),
      maxContentWidth: lerpDouble(maxContentWidth, other.maxContentWidth, t),
    );
  }

  static double lerpDouble(double a, double b, double t) {
    if (!a.isFinite || !b.isFinite) return t < 0.5 ? a : b;
    return a + (b - a) * t;
  }
}
