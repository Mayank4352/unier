import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_svg_icon.dart';
import 'nav_destination.dart';

// Translucent, blurred tab bar pinned to the bottom of the shell.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<NavDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: dimens.navBarBlurSigma,
          sigmaY: dimens.navBarBlurSigma,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.translucentSurface,
            border: Border(
              top: BorderSide(
                color: colors.separator,
                width: dimens.separatorThickness,
              ),
            ),
          ),
          child: SizedBox(
            height: dimens.navBarContentHeight + bottomInset,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Row(
                children: <Widget>[
                  for (final (index, destination) in destinations.indexed)
                    Expanded(
                      child: _NavBarItem(
                        destination: destination,
                        isSelected: index == currentIndex,
                        onPressed: () => onDestinationSelected(index),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.destination,
    required this.isSelected,
    required this.onPressed,
  });

  final NavDestination destination;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final color = isSelected ? colors.accent : colors.secondaryLabel;

    return Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppSvgIcon(
              destination.iconAsset,
              size: dimens.iconLg,
              color: color,
            ),
            SizedBox(height: dimens.spaceXs),
            Text(
              destination.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.navLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
