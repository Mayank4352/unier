import 'package:flutter/material.dart';

import 'size_class.dart';

/// Every spacing, size and radius used by the app, in one place.
@immutable
class Dimens extends ThemeExtension<Dimens> {
  const Dimens({
    required this.sizeClass,
    required this.scale,
    required this.maxContentWidth,
  });

  static const Dimens compact = Dimens(
    sizeClass: SizeClass.compact,
    scale: 1,
    maxContentWidth: double.infinity,
  );

  static const Dimens medium = Dimens(
    sizeClass: SizeClass.medium,
    scale: 1.08,
    maxContentWidth: 600,
  );

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

  final SizeClass sizeClass;
  final double scale;
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

  double get spaceXxs => _spaceXxs * scale;
  double get spaceXs => _spaceXs * scale;
  double get spaceSm => _spaceSm * scale;
  double get spaceMd => _spaceMd * scale;
  double get spaceLg => _spaceLg * scale;
  double get spaceXl => _spaceXl * scale;
  double get spaceXxl => _spaceXxl * scale;
  double get screenPaddingHorizontal => _screenPaddingHorizontal * scale;
  double get screenPaddingTop => _screenPaddingTop * scale;
  double get sectionSpacing => _sectionSpacing * scale;
  double get sectionHeaderSpacing => _sectionHeaderSpacing * scale;
  double get radiusCard => _radiusCard * scale;
  double get radiusChip => _radiusChip * scale;
  double get radiusFull => _radiusFull;
  double get separatorThickness => _separatorThickness;
  double get iconSm => _iconSm * scale;
  double get iconMd => _iconMd * scale;
  double get iconLg => _iconLg * scale;
  double get statusDotSize => _statusDotSize * scale;
  double get avatarSize => _avatarSize * scale;
  double get quickDialItemWidth => _quickDialItemWidth * scale;
  double get quickDialSpacing => _spaceXl * scale;
  double get quickDialColumnWidth => (_quickDialItemWidth + _spaceXl) * scale;
  double get chipHeight => _chipHeight * scale;
  double get listRowHeight => _listRowHeight * scale;
  double get listLeadingWidth => _listLeadingWidth * scale;
  double get navBarContentHeight => _navBarContentHeight * scale;
  double get navBarBlurSigma => _navBarBlurSigma;
  EdgeInsets get cardPadding => EdgeInsets.all(spaceLg);

  EdgeInsets get screenPadding =>
      EdgeInsets.symmetric(horizontal: screenPaddingHorizontal);

  BorderRadius get cardBorderRadius => BorderRadius.circular(radiusCard);
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
