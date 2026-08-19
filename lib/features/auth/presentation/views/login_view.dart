import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/responsive_body.dart';
import '../view_models/auth_view_model.dart';

// Google sign-in. Restyled once its design lands.
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;
    final textStyles = context.textStyles;
    final failure = viewModel.signIn.failure;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: ResponsiveBody(
          child: Padding(
            padding: dimens.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppConfig.appName,
                  style: textStyles.greetingTitle.copyWith(color: colors.label),
                ),
                SizedBox(height: dimens.spaceSm),
                Text(
                  'Calls you can read. Sign in to get started.',
                  style: textStyles.cardBody.copyWith(
                    color: colors.secondaryLabel,
                  ),
                ),
                SizedBox(height: dimens.spaceXxl),
                FilledButton(
                  onPressed: viewModel.signIn.running
                      ? null
                      : viewModel.signIn.execute,
                  child: Text(
                    viewModel.signIn.running
                        ? 'Signing in…'
                        : 'Continue with Google',
                  ),
                ),
                if (failure != null && !_wasCancelled(failure)) ...<Widget>[
                  SizedBox(height: dimens.spaceMd),
                  Text(
                    failure.message,
                    style: textStyles.cardBody.copyWith(
                      color: colors.destructive,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _wasCancelled(Failure failure) =>
      failure is AuthFailure && failure.wasCancelled;
}
