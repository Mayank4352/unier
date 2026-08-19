import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../domain/entities/greeting.dart';
import '../formatters/greeting_formatter.dart';

/// Date line and salutation at the top of the home screen.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({required this.greeting, super.key});

  final Greeting? greeting;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final value = greeting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value?.dateLabel ?? '',
          style: textStyles.greetingDate.copyWith(color: colors.secondaryLabel),
        ),
        SizedBox(height: context.dimens.spaceXxs),
        Text(
          value?.headline ?? '',
          style: textStyles.greetingTitle.copyWith(color: colors.label),
        ),
      ],
    );
  }
}
