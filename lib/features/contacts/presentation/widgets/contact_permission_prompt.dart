import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_card.dart';

// Explains why Unier needs the address book, and how to grant it.
class ContactPermissionPrompt extends StatelessWidget {
  const ContactPermissionPrompt({
    required this.failure,
    required this.onGrantPressed,
    super.key,
  });

  final PermissionFailure failure;
  final VoidCallback onGrantPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contacts access needed',
            style: context.textStyles.cardTitle.copyWith(color: colors.label),
          ),
          SizedBox(height: dimens.spaceXs),
          Text(
            failure.message,
            style: context.textStyles.cardBody.copyWith(
              color: colors.secondaryLabel,
            ),
          ),
          SizedBox(height: dimens.spaceLg),
          FilledButton(
            onPressed: onGrantPressed,
            child: Text(
              failure.isPermanentlyDenied ? 'Open settings' : 'Allow access',
            ),
          ),
        ],
      ),
    );
  }
}
