import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

/// Circular avatar showing a photo when there is one, initials otherwise.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    required this.initials,
    this.photo,
    this.diameter,
    this.textStyle,
    super.key,
  });

  final String initials;
  final Uint8List? photo;
  final double? diameter;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final size = diameter ?? context.dimens.avatarSize;
    final image = photo;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.avatarFill,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: image != null
          ? Image.memory(image, width: size, height: size, fit: BoxFit.cover)
          : Text(
              initials,
              textAlign: TextAlign.center,
              style: (textStyle ?? context.textStyles.avatarInitials).copyWith(
                color: colors.onAvatar,
              ),
            ),
    );
  }
}
