import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

/// Caps content at a readable width and centres it on wide windows.
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final maxWidth = context.dimens.maxContentWidth;
    if (!maxWidth.isFinite) return child;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
