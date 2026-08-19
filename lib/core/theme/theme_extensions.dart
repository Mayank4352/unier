import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'dimens.dart';

/// Short, safe accessors for the app's design tokens.
extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  Dimens get dimens => Theme.of(this).extension<Dimens>()!;
  AppTypography get textStyles => Theme.of(this).extension<AppTypography>()!;
}
