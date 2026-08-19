import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/nav_destination.dart';

// Scaffold shared by the tabs: each branch keeps its own navigation stack.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.canvas,
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        destinations: NavDestination.all,
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
