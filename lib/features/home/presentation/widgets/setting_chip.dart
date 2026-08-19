import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_svg_icon.dart';

// Rounded chip pairing an icon with a caption and its current value.
class SettingChip extends StatelessWidget {
  const SettingChip({
    required this.iconAsset,
    required this.label,
    required this.value,
    this.onPressed,
    super.key,
  });

  final String iconAsset;
  final String label;
  final String value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final textStyles = context.textStyles;

    return Material(
      color: colors.fill,
      borderRadius: dimens.chipBorderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: dimens.chipHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: dimens.spaceMd),
            child: Row(
              children: <Widget>[
                AppSvgIcon(
                  iconAsset,
                  size: dimens.iconMd,
                  color: colors.accent,
                ),
                SizedBox(width: dimens.spaceSm),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.chipLabel.copyWith(
                          color: colors.secondaryLabel,
                        ),
                      ),
                      Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.chipValue.copyWith(
                          color: colors.label,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
