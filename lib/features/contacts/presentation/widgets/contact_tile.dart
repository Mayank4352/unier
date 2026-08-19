import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../domain/entities/phone_contact.dart';

/// One address-book row: avatar, name and primary number.
class ContactTile extends StatelessWidget {
  const ContactTile({required this.contact, this.onPressed, super.key});

  final PhoneContact contact;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final textStyles = context.textStyles;
    final number = contact.primaryPhoneNumber;

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.spaceLg,
          vertical: dimens.spaceMd,
        ),
        child: Row(
          children: <Widget>[
            InitialsAvatar(
              initials: contact.initials,
              photo: contact.photo,
              diameter: dimens.iconLg * 2,
              textStyle: textStyles.chipValue,
            ),
            SizedBox(width: dimens.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    contact.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles.listTitle.copyWith(color: colors.label),
                  ),
                  if (number != null)
                    Text(
                      number,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyles.listSubtitle.copyWith(
                        color: colors.secondaryLabel,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
