import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/widgets/bottom_navigation.dart';
import '../controllers/roadmap_controller.dart';
import '../core/constants/app_colors.dart';
import 'home_page.dart'; // Import the new home page
import 'roadmap/clean_roadmap_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(), // Replace PlaceholderScreen with the new HomePage
      const CleanRoadmapScreen(roadmapId: 'software_engineer'),
      const PlaceholderScreen(title: 'Jobs'),
      const PlaceholderScreen(title: 'Profile'),
    ];
    
    // Initialize the roadmap data when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final roadmapController = context.read<RoadmapController>();
      roadmapController.loadRoadmap('software_engineer');
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current route name based on the selected index
    final currentRoute = AppBottomNavItems.mainNavItems[_currentIndex].route;
    
    return Scaffold(
      // Only show AppBar for non-home pages (Home page has its own header)
      appBar: _currentIndex == 0 ? null : AppBar(
        title: Text(
          _getTitleForRoute(currentRoute),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A), // Dark blue color
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: AppBottomNavItems.mainNavItems,
      ),
    );
  }
  
  String _getTitleForRoute(String route) {
    switch (route) {
      case '/home':
        return 'Home';
      case '/roadmap':
        return 'Career Roadmap';
      case '/jobs':
        return 'Job Opportunities';
      case '/profile':
        return 'My Profile';
      default:
        return 'Career Compass';
    }
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForTitle(title),
              size: 80,
              color: AppColors.primaryBlue.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              '$title Screen',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'jobs':
        return Icons.work;
      case 'profile':
        return Icons.person;
      default:
        return Icons.dashboard;
    }
  }
}