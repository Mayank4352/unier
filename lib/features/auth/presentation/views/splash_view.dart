import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';

/// Held while the stored session is being resolved at start-up.
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.canvas,
      body: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
