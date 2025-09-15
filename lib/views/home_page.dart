import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../routes/app_routes.dart';
import 'roadmap/clean_roadmap_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header/AppBar
            _buildHeader(context),
            
            // Main Content - Scrollable
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Alerts/Announcements Section
                      _buildAlertsSection(context),
                      
                      const SizedBox(height: 24),
                      
                      // Quick Actions Grid
                      _buildQuickActionsGrid(context),
                      
                      const SizedBox(height: 24),
                      
                      // Recent Announcements Section
                      _buildAnnouncementsSection(context),
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Welcome Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ready to advance your career?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryBlue,
                  ),
                ),
              ],
            ),
          ),
          
          // User Avatar - Now Clickable
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Latest Updates',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildAlertCard(context, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard(BuildContext context, int index) {
    final alerts = [
      {
        'title': 'New Scholarship Available',
        'description': 'Tech scholarship for engineering students',
        'color': AppColors.primaryBlue,
        'icon': Icons.school,
      },
      {
        'title': 'Career Fair Next Week',
        'description': 'Connect with top companies',
        'color': AppColors.orange,
        'icon': Icons.business,
      },
      {
        'title': 'New Course Added',
        'description': 'AI & Machine Learning fundamentals',
        'color': AppColors.primaryBlue,
        'icon': Icons.book,
      },
    ];

    final alert = alerts[index];
    
    return Container(
      width: 280,
      margin: EdgeInsets.only(
        left: index == 0 ? 4 : 8,
        right: index == alerts.length - 1 ? 4 : 0,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (alert['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              alert['icon'] as IconData,
              color: alert['color'] as Color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  alert['title'] as String,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert['description'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryBlue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            // Responsive grid based on screen width
            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            double childAspectRatio = constraints.maxWidth > 600 ? 1.4 : 1.2;
            
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: childAspectRatio,
              children: [
                _buildQuickActionCard(
                  context,
                  'Roadmap',
                  'Plan your career path',
                  Icons.map,
                  AppColors.primaryBlue,
                  () => _navigateToRoadmap(context),
                ),
                _buildQuickActionCard(
                  context,
                  'Tests & Quizzes',
                  'Assess your skills',
                  Icons.quiz,
                  AppColors.orange,
                  () => _navigateToTests(context),
                ),
                if (crossAxisCount == 3) ...[
                  _buildQuickActionCard(
                    context,
                    'Career Advice',
                    'Get personalized tips',
                    Icons.lightbulb,
                    AppColors.primaryBlue,
                    () => _navigateToAdvice(context),
                  ),
                ],
              ],
            );
          },
        ),
        
        // Additional action card for mobile (2-column layout)
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth <= 600) {
              return Column(
                children: [
                  const SizedBox(height: 12),
                  _buildQuickActionCard(
                    context,
                    'Career Advice',
                    'Get personalized tips',
                    Icons.lightbulb,
                    AppColors.primaryBlue,
                    () => _navigateToAdvice(context),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryBlue,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Announcements',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBlue,
                ),
              ),
              TextButton(
                onPressed: () => _viewAllAnnouncements(context),
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _buildAnnouncementCard(context, index);
          },
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, int index) {
    final announcements = [
      {
        'title': 'Summer Internship Program',
        'description': 'Applications now open for summer 2025 internship program at leading tech companies.',
        'date': '2 days ago',
        'category': 'Internship',
      },
      {
        'title': 'Alumni Success Story',
        'description': 'Meet Sarah Johnson, who landed her dream job at Google after following our roadmap.',
        'date': '1 week ago',
        'category': 'Success Story',
      },
      {
        'title': 'New Partnership Announced',
        'description': 'We\'ve partnered with Microsoft to provide exclusive learning resources and certifications.',
        'date': '2 weeks ago',
        'category': 'Partnership',
      },
    ];

    final announcement = announcements[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  announcement['category'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                announcement['date'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            announcement['title'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            announcement['description'] as String,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryBlue,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Navigation methods
  void _navigateToRoadmap(BuildContext context) {
    // Navigate using the same roadmap screen that's in your bottom nav
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CleanRoadmapScreen(roadmapId: 'software_engineer'),
      ),
    );
  }

  void _navigateToTests(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TestsPage()),
    );
  }

  void _navigateToAdvice(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CareerAdvicePage()),
    );
  }

  void _viewAllAnnouncements(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AnnouncementsPage()),
    );
  }
}

// Placeholder screens for navigation using your app colors
class TestsPage extends StatelessWidget {
  const TestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tests & Quizzes'),
        backgroundColor: AppColors.orange,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz,
              size: 80,
              color: AppColors.orange.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Tests & Quizzes',
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
}

class CareerAdvicePage extends StatelessWidget {
  const CareerAdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Advice'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb,
              size: 80,
              color: AppColors.primaryBlue.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Career Advice',
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
}

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Announcements'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.announcement,
              size: 80,
              color: AppColors.primaryBlue.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'All Announcements',
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
}