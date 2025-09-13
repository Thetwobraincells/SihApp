$content = @'
// lib/core/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BottomNavItem {
  final String label;
  final IconData icon;
  final String route;

  const BottomNavItem({
    required this.label,
    required this.icon,
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
      label: 'Roadmap',
      icon: Icons.timeline_outlined,
      route: '/roadmap',
    ),
    BottomNavItem(
      label: 'Jobs',
      icon: Icons.work_outline,
      route: '/jobs',
    ),
    BottomNavItem(
      label: 'Profile',
      icon: Icons.person_outline,
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
          label: item.label,
        );
      }).toList(),
    );
  }
}
'@

$filePath = "c:\Users\Shivam\OneDrive\Desktop\Sihnew app\SihApp\lib\core\widgets\bottom_navigation.dart"
[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
