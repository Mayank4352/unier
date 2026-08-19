import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

// Hairline divider between rows of a grouped list.
class AppSeparator extends StatelessWidget {
  const AppSeparator({this.indent = 0, super.key});

  final double indent;

  @override
  Widget build(BuildContext context) {
    final dimens = context.dimens;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: indent),
      child: SizedBox(
        height: dimens.separatorThickness,
        child: ColoredBox(color: context.colors.separator),
      ),
    );
  }
}
