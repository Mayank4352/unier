import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

// Rounded surface used by every grouped block on a screen.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding,
    this.clipContents = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool clipContents;

  @override
  Widget build(BuildContext context) {
    final dimens = context.dimens;

    return Container(
      clipBehavior: clipContents ? Clip.antiAlias : Clip.none,
      padding: padding ?? dimens.cardPadding,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: dimens.cardBorderRadius,
      ),
      child: child,
    );
  }
}
