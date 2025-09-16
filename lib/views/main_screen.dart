import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/widgets/bottom_navigation.dart';
import '../controllers/roadmap_controller.dart';
import '../core/constants/app_colors.dart';
import 'home_page.dart';
import 'roadmap/clean_roadmap_screen.dart';
import 'timeline/timeline_tracker_screen.dart';
import 'college_finder/college_finder_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    
    // Create pages with proper tab context
    _pages = [
      const HomePage(),
      const TimelineTrackerScreen(),
      const CleanRoadmapScreen(roadmapId: 'software_engineer'),
      const CollegeFinderScreen(isTab: true), // KEY FIX: Tell it it's a tab
    ];
    
    // Initialize the roadmap data when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final roadmapController = context.read<RoadmapController>();
      roadmapController.loadRoadmap('software_engineer');
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FIXED: Always show AppBar for consistency, but customize per screen
      appBar: _buildAppBarForCurrentPage(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: AppBottomNavItems.mainNavItems,
      ),
    );
  }
  
  PreferredSizeWidget? _buildAppBarForCurrentPage() {
    // Home page manages its own header
    if (_currentIndex == 0) {
      return null;
    }
    
    return AppBar(
      title: Text(
        _getTitleForIndex(_currentIndex),
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      backgroundColor: const Color(0xFF1E3A8A),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false, // KEY FIX: No back button for tabs
      actions: _getActionsForCurrentPage(),
    );
  }
  
  List<Widget>? _getActionsForCurrentPage() {
    // Add specific actions for College Finder tab
    if (_currentIndex == 3) { // College Finder index
      return [
        IconButton(
          icon: const Icon(Icons.bookmark_outline, color: Colors.white),
          onPressed: () {
            // Handle bookmark action
          },
        ),
      ];
    }
    return null;
  }
  
  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Timeline Tracker';
      case 2:
        return 'Career Roadmap';
      case 3:
        return 'Career Compass'; // Match your screenshot
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