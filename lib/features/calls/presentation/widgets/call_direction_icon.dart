import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/app_svg_icon.dart';
import '../../domain/entities/call_record.dart';

// Arrow or missed-call glyph at the start of a call-log row.
class CallDirectionIcon extends StatelessWidget {
  const CallDirectionIcon({required this.direction, super.key});

  final CallDirection direction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final (asset, color, label) = switch (direction) {
      CallDirection.incoming => (
        AppIcons.callIncoming,
        colors.secondaryLabel,
        'Incoming call',
      ),
      CallDirection.outgoing => (
        AppIcons.callOutgoing,
        colors.secondaryLabel,
        'Outgoing call',
      ),
      CallDirection.missed => (
        AppIcons.callMissed,
        colors.destructive,
        'Missed call',
      ),
    };

    return AppSvgIcon(
      asset,
      size: context.dimens.iconMd,
      color: color,
      semanticLabel: label,
    );
  }
}
