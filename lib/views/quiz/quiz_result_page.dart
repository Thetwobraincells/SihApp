import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/quiz_controller.dart';
import '../../core/constants/app_colors.dart';
import '../main_screen.dart';
import 'quiz_page.dart';
import '../../routes/app_routes.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizController>(
      builder: (context, quizController, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Custom Header
                _buildHeader(context),
                
                // Results Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Congratulations Card
                        _buildCongratulationsCard(context, quizController),
                        
                        const SizedBox(height: 24),
                        
                        // Recommended Stream Card
                        _buildRecommendedStreamCard(context, quizController),
                        
                        const SizedBox(height: 24),
                        
                        // Score Breakdown
                        _buildScoreBreakdown(context, quizController),
                        
                        const SizedBox(height: 24),
                        
                        // Next Steps
                        _buildNextSteps(context, quizController),
                        
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                
                // Action Buttons
                _buildActionButtons(context, quizController),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryBlue.withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quiz Completed!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your personalized results are ready',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.emoji_events,
              color: AppColors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCongratulationsCard(BuildContext context, QuizController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.orange.withOpacity(0.1),
            AppColors.primaryBlue.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.stars,
              color: AppColors.white,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            'Congratulations!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'You\'ve completed the aptitude and interest assessment',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.secondaryBlue,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedStreamCard(BuildContext context, QuizController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getStreamColor(controller.recommendedStream).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getStreamIcon(controller.recommendedStream),
                  color: _getStreamColor(controller.recommendedStream),
                  size: 28,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended Stream',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.recommendedStream,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          Text(
            controller.getStreamDescription(controller.recommendedStream),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.secondaryBlue,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Subjects
          _buildInfoSection(
            context,
            'Key Subjects',
            controller.getStreamSubjects(controller.recommendedStream),
            Icons.book,
          ),
          
          const SizedBox(height: 16),
          
          // Careers
          _buildInfoSection(
            context,
            'Career Options',
            controller.getStreamCareers(controller.recommendedStream),
            Icons.work,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, List<String> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildScoreBreakdown(BuildContext context, QuizController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed Score Breakdown',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 20),
          
          ...controller.streamScores.entries.map((entry) => 
            _buildScoreBar(context, entry.key, entry.value, controller.streamScores.values.reduce((a, b) => a > b ? a : b))
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildScoreBar(BuildContext context, String stream, int score, int maxScore) {
    final percentage = maxScore > 0 ? score / maxScore : 0.0;
    final color = _getStreamColor(stream);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    stream,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                score.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: AppColors.gray.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildNextSteps(BuildContext context, QuizController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue.withOpacity(0.05),
            AppColors.orange.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: AppColors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'What\'s Next?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          ..._getNextSteps(controller.recommendedStream).map((step) => 
            _buildNextStepItem(context, step)
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildNextStepItem(BuildContext context, Map<String, dynamic> step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: step['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              step['icon'],
              size: 14,
              color: step['color'],
            ),
          ),
          
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['title'],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step['description'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, QuizController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Primary Action
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _exploreRoadmap(context, controller.recommendedStream),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Explore ${controller.recommendedStream} Roadmap',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Secondary Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _retakeQuiz(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondaryBlue,
                    side: BorderSide(color: AppColors.gray.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Retake Quiz',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _goToHome(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondaryBlue,
                    side: BorderSide(color: AppColors.gray.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Back to Home',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper methods
  Color _getStreamColor(String stream) {
    switch (stream) {
      case 'Science':
        return AppColors.primaryBlue;
      case 'Commerce':
        return AppColors.orange;
      case 'Arts':
        return const Color(0xFF9C27B0);
      case 'Vocational':
        return const Color(0xFF4CAF50);
      default:
        return AppColors.primaryBlue;
    }
  }

  IconData _getStreamIcon(String stream) {
    switch (stream) {
      case 'Science':
        return Icons.science;
      case 'Commerce':
        return Icons.business;
      case 'Arts':
        return Icons.palette;
      case 'Vocational':
        return Icons.build;
      default:
        return Icons.school;
    }
  }

  List<Map<String, dynamic>> _getNextSteps(String stream) {
    return [
      {
        'title': 'Explore Career Roadmap',
        'description': 'View detailed career paths and required skills for your stream',
        'icon': Icons.map,
        'color': AppColors.primaryBlue,
      },
      {
        'title': 'Find Colleges',
        'description': 'Discover colleges and courses that align with your interests',
        'icon': Icons.school,
        'color': AppColors.orange,
      },
      {
        'title': 'Connect with Mentors',
        'description': 'Get guidance from professionals in your field of interest',
        'icon': Icons.people,
        'color': const Color(0xFF9C27B0),
      },
    ];
  }

  // Navigation methods
  void _exploreRoadmap(BuildContext context, String stream) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
    // You could add specific roadmap navigation here based on the stream
  }

  void _retakeQuiz(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.quiz,
      (route) => false,
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }
}