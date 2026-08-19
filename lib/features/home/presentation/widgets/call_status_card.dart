import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../settings/domain/entities/call_settings.dart';
import 'setting_chip.dart';

/// Availability card with the caption and voice shortcuts.
class CallStatusCard extends StatelessWidget {
  const CallStatusCard({
    required this.settings,
    this.onCaptionsPressed,
    this.onVoicePressed,
    super.key,
  });

  final CallSettings settings;
  final VoidCallback? onCaptionsPressed;
  final VoidCallback? onVoicePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;
    final textStyles = context.textStyles;
    final isReady = settings.readyForCalls;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: dimens.statusDotSize,
                height: dimens.statusDotSize,
                decoration: BoxDecoration(
                  color: isReady ? colors.positive : colors.secondaryLabel,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: dimens.spaceSm),
              Expanded(
                child: Text(
                  isReady ? 'Ready for calls' : 'Not receiving calls',
                  style: textStyles.cardTitle.copyWith(color: colors.label),
                ),
              ),
            ],
          ),
          SizedBox(height: dimens.spaceXs),
          Text(
            isReady
                ? 'When someone calls, the screen opens automatically and captions start right away.'
                : 'Turn on availability to receive calls with live captions.',
            style: textStyles.cardBody.copyWith(color: colors.secondaryLabel),
          ),
          SizedBox(height: dimens.spaceLg),
          Row(
            children: <Widget>[
              Expanded(
                child: SettingChip(
                  iconAsset: AppIcons.captions,
                  label: 'Captions',
                  value: settings.captionsEnabled ? 'On' : 'Off',
                  onPressed: onCaptionsPressed,
                ),
              ),
              SizedBox(width: dimens.spaceSm),
              Expanded(
                child: SettingChip(
                  iconAsset: AppIcons.voice,
                  label: 'Voice',
                  value: settings.voiceName,
                  onPressed: onVoicePressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
