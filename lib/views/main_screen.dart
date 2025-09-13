import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/bottom_navigation.dart';
import '../../controllers/roadmap_controller.dart';
import 'onboarding/login_screen.dart';
import 'roadmap/clean_roadmap_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PlaceholderScreen(title: 'Home'),
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
      appBar: AppBar(
        title: Text(
          _getTitleForRoute(currentRoute),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A), // Dark blue color
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
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
    return Center(
      child: Text(
        '$title Screen',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
