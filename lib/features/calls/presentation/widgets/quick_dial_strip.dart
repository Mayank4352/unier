import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../domain/entities/quick_dial_entry.dart';

/// Horizontal row of one-tap contacts.
class QuickDialStrip extends StatelessWidget {
  const QuickDialStrip({required this.entries, this.onEntryPressed, super.key});

  final List<QuickDialEntry> entries;
  final ValueChanged<QuickDialEntry>? onEntryPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: context.dimens.screenPadding,
      child: Row(
        children: <Widget>[
          for (final entry in entries)
            QuickDialTile(
              entry: entry,
              onPressed: onEntryPressed == null
                  ? null
                  : () => onEntryPressed!(entry),
            ),
        ],
      ),
    );
  }
}

/// One avatar-and-name column of the [QuickDialStrip].
class QuickDialTile extends StatelessWidget {
  const QuickDialTile({required this.entry, this.onPressed, super.key});

  final QuickDialEntry entry;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dimens = context.dimens;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: dimens.quickDialColumnWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InitialsAvatar(initials: entry.initials),
            SizedBox(height: dimens.spaceSm),
            Text(
              entry.displayName,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.quickDialName.copyWith(
                color: context.colors.label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
