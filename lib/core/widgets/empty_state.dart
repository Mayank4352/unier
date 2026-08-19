import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

/// Placeholder shown when a section has nothing to list yet.
class EmptyState extends StatelessWidget {
  const EmptyState({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dimens.spaceLg),
      child: Text(
        message,
        style: context.textStyles.cardBody.copyWith(
          color: context.colors.secondaryLabel,
        ),
      ),
    );
  }
}
