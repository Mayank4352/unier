import 'package:flutter/material.dart';

import '../error/failure.dart';
import '../theme/theme_extensions.dart';

// Inline message shown when a section could not load.
class FailureView extends StatelessWidget {
  const FailureView({required this.failure, this.onRetry, super.key});

  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          failure.message,
          style: context.textStyles.cardBody.copyWith(
            color: colors.secondaryLabel,
          ),
        ),
        if (onRetry != null) ...<Widget>[
          SizedBox(height: dimens.spaceSm),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onRetry,
            child: Text(
              'Try again',
              style: context.textStyles.link.copyWith(color: colors.accent),
            ),
          ),
        ],
      ],
    );
  }
}
