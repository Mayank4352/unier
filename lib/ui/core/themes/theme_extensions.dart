import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'dimens.dart';

/// Short, safe accessors for the app's design tokens.
///
/// `Theme.of(context).extension<T>()!` at every call site is noisy and hides a
/// null assertion; these getters make token lookup the path of least
/// resistance, which is what keeps literals out of the widget tree.
extension AppThemeContext on BuildContext {
  /// The active palette.
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  /// The active spacing and sizing tokens.
  Dimens get dimens => Theme.of(this).extension<Dimens>()!;

  /// The active type ramp.
  AppTypography get textStyles => Theme.of(this).extension<AppTypography>()!;
}
