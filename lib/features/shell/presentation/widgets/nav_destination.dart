import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_icons.dart';

/// One tab of the bottom navigation bar.
class NavDestination {
  const NavDestination({
    required this.label,
    required this.iconAsset,
    required this.routeName,
  });

  final String label;
  final String iconAsset;
  final String routeName;

  /// The tabs, in the order they appear in the bar.
  static const List<NavDestination> all = <NavDestination>[
    NavDestination(
      label: 'Home',
      iconAsset: AppIcons.navHome,
      routeName: AppRoutes.homeName,
    ),
    NavDestination(
      label: 'Contacts',
      iconAsset: AppIcons.navContacts,
      routeName: AppRoutes.contactsName,
    ),
    NavDestination(
      label: 'Recents',
      iconAsset: AppIcons.navRecents,
      routeName: AppRoutes.recentsName,
    ),
  ];
}
