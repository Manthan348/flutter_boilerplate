import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/widgets/bottom_sheets/app_bottom_sheets.dart';
import 'package:starter_lib/src/widgets/cards/app_section_card.dart';
import 'package:starter_lib/src/widgets/tiles/app_list_tile.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Future<void> _onLogout(BuildContext context) async {
    final bool confirmed = await AppBottomSheets.showConfirmation(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout from this account?',
      confirmText: 'Logout',
      cancelText: 'Stay Logged In',
      isDestructive: true,
    );

    if (!context.mounted || !confirmed) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout action confirmed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.pagePadding),
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.itemSpacing),
        Text(
          'Reusable profile tiles and bottom-sheet flows.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AppSectionCard(
          title: 'Account',
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.pagePadding,
            vertical: 8,
          ),
          child: Column(
            children: [
              AppListTile(
                title: 'Edit Profile',
                subtitle: 'Update name, email, and phone',
                leading: const Icon(Icons.person_outline),
                onTap: () {},
                showTopBorder: true,
              ),
              AppListTile(
                title: 'Addresses',
                subtitle: 'Manage saved places',
                leading: const Icon(Icons.place_outlined),
                onTap: () {},
              ),
              AppListTile(
                title: 'Notifications',
                subtitle: 'Control push and in-app preferences',
                leading: const Icon(Icons.notifications_none_outlined),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.itemSpacing),
        AppSectionCard(
          title: 'Session',
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.pagePadding,
            vertical: 8,
          ),
          child: Column(
            children: [
              AppListTile(
                title: 'Logout',
                subtitle: 'Exit from this device',
                leading: const Icon(Icons.logout),
                isDestructive: true,
                onTap: () => _onLogout(context),
                showTopBorder: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
