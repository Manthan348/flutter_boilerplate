import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/features/home/presentation/home_page.dart';
import 'package:starter_lib/src/features/shell/controller/app_shell_controller.dart';
import 'package:starter_lib/src/features/shell/presentation/tabs/explore_tab.dart';
import 'package:starter_lib/src/features/shell/presentation/tabs/profile_tab.dart';
import 'package:starter_lib/src/widgets/buttons/app_floating_action_button.dart';
import 'package:starter_lib/src/widgets/navigation/app_bottom_tab_bar.dart';
import 'package:starter_lib/src/widgets/scaffolds/app_scaffold.dart';

class AppShellPage extends GetView<AppShellController> {
  const AppShellPage({super.key});

  Widget? _buildFab(BuildContext context, int index) {
    if (index == 2) {
      return null;
    }

    return AppFloatingActionButton(
      icon: index == 1 ? Icons.tune : Icons.add,
      label: index == 1 ? 'Filters' : 'Create',
      isExtended: index == 1,
      onPressed: () {
        final String label = index == 1 ? 'Open filters action' : 'Create action';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(label)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = [HomePage(), ExploreTab(), ProfileTab()];

    return Obx(() {
      final int index = controller.currentIndex.value;

      return AppScaffold(
        title: controller.title,
        body: IndexedStack(index: index, children: pages),
        floatingActionButton: _buildFab(context, index),
        bottomNavigationBar: AppBottomTabBar(
          items: controller.tabs,
          currentIndex: index,
          onTap: controller.onTabSelected,
        ),
      );
    });
  }
}
