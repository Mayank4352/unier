import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/app_svg_icon.dart';
import '../../domain/entities/call_record.dart';
import '../formatters/call_record_formatter.dart';
import 'call_direction_icon.dart';

/// One row of the call log: direction, who, how long, and when.
class CallRecordTile extends StatelessWidget {
  const CallRecordTile({
    required this.record,
    required this.now,
    this.onPressed,
    super.key,
  });

  final CallRecord record;
  final DateTime now;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final textStyles = context.textStyles;
    final isMissed = record.direction == CallDirection.missed;

    return InkWell(
      onTap: onPressed,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: dimens.listRowHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: dimens.spaceMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: dimens.listLeadingWidth,
                child: Center(
                  child: CallDirectionIcon(direction: record.direction),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      record.contactName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyles.listTitle.copyWith(
                        color: isMissed ? colors.destructive : colors.label,
                      ),
                    ),
                    SizedBox(height: dimens.spaceXxs),
                    _Subtitle(record: record),
                  ],
                ),
              ),
              SizedBox(width: dimens.spaceMd),
              Text(
                record.timeLabel(now),
                style: textStyles.listTrailing.copyWith(
                  color: colors.secondaryLabel,
                ),
              ),
              SizedBox(width: dimens.spaceLg),
            ],
          ),
        ),
      ),
    );
  }
}

/// Duration and caption count, or the missed-call reason.
class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.record});

  final CallRecord record;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final style = context.textStyles.listSubtitle.copyWith(
      color: colors.secondaryLabel,
    );

    final duration = record.durationLabel;
    final captions = record.captionLabel;

    if (duration == null) {
      return Text(record.missedLabel, style: style, maxLines: 1);
    }

    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            duration,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (captions != null) ...<Widget>[
          SizedBox(width: dimens.spaceSm),
          Text('·', style: style),
          SizedBox(width: dimens.spaceSm),
          AppSvgIcon(
            AppIcons.captionLines,
            size: dimens.iconSm,
            color: colors.secondaryLabel,
          ),
          SizedBox(width: dimens.spaceXs),
          Flexible(
            child: Text(
              captions,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}
