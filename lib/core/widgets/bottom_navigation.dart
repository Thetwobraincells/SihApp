// lib/core/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BottomNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String route;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    required this.route,
  });
}

class AppBottomNavItems {
  static const List<BottomNavItem> mainNavItems = [
    BottomNavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      route: '/home',
    ),
    BottomNavItem(
      label: 'Calendar',
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      route: '/timeline',
    ),
    BottomNavItem(
      label: 'Roadmap',
      icon: Icons.assignment_outlined,
      activeIcon: Icons.assignment,
      route: '/roadmap',
    ),
    BottomNavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      route: '/profile',
    ),
  ];

  static int getRoadmapIndex() {
    return mainNavItems.indexWhere((item) => item.route == '/roadmap');
  }
}

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.secondaryBlue,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: item.activeIcon != null ? Icon(item.activeIcon) : Icon(item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }
}