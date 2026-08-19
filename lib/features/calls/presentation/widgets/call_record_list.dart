import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_separator.dart';
import '../../domain/entities/call_record.dart';
import 'call_record_tile.dart';

// Grouped card of call-log rows, hairline-separated.
class CallRecordList extends StatelessWidget {
  const CallRecordList({
    required this.records,
    required this.now,
    this.onRecordPressed,
    super.key,
  });

  final List<CallRecord> records;
  final DateTime now;
  final ValueChanged<CallRecord>? onRecordPressed;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      clipContents: true,
      child: Column(
        children: <Widget>[
          for (final (index, record) in records.indexed) ...<Widget>[
            if (index > 0)
              AppSeparator(indent: context.dimens.listLeadingWidth),
            CallRecordTile(
              record: record,
              now: now,
              onPressed: onRecordPressed == null
                  ? null
                  : () => onRecordPressed!(record),
            ),
          ],
        ],
      ),
    );
  }
}
