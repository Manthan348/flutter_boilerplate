import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/widgets/navigation/app_bottom_tab_bar.dart';

class AppShellController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<AppBottomTabItem> tabs = const [
    AppBottomTabItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    AppBottomTabItem(
      label: 'Explore',
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore,
    ),
    AppBottomTabItem(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  void onTabSelected(int index) {
    currentIndex.value = index;
  }

  String get title => tabs[currentIndex.value].label;
}
