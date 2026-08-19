import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';
import 'app_icons.dart';
import 'app_svg_icon.dart';

/// Grey caption above a section, with an optional trailing action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.actionLabel,
    this.onActionPressed,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final label = actionLabel;

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: context.textStyles.sectionHeader.copyWith(
              color: colors.secondaryLabel,
            ),
          ),
        ),
        if (label != null)
          SectionHeaderAction(label: label, onPressed: onActionPressed),
      ],
    );
  }
}

/// The "See all >" affordance at the end of a [SectionHeader].
class SectionHeaderAction extends StatelessWidget {
  const SectionHeaderAction({required this.label, this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: context.textStyles.link.copyWith(color: colors.accent),
          ),
          SizedBox(width: dimens.spaceXs),
          AppSvgIcon(
            AppIcons.chevronRight,
            size: dimens.iconMd,
            color: colors.accent,
          ),
        ],
      ),
    );
  }
}
