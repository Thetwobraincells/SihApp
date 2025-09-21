// lib/views/quiz/quiz_result_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/quiz_controller.dart';
import '../../controllers/roadmap_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/roadmap_card.dart';
import '../../core/widgets/college_card.dart';
import '../../models/roadmap_model.dart';
import '../main_screen.dart';
import 'quiz_page.dart';
import '../../routes/app_routes.dart';

class QuizResultPage extends StatefulWidget {
  const QuizResultPage({Key? key}) : super(key: key);

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  @override
  void initState() {
    super.initState();
    // Don't load roadmap data automatically - wait for user to click explore
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuizController, RoadmapController>(
      builder: (context, quizController, roadmapController, child) {
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
                        
                        // Career Roadmap Section removed - will be shown on dedicated page
                        
                        const SizedBox(height: 24),
                        
                        // Score Breakdown
                        _buildScoreBreakdown(context, quizController),
                        
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                
                // Action Buttons
                _buildActionButtons(context, quizController, roadmapController),
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
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your personalized results are ready',
                  style: AppTextStyles.bodyMedium.copyWith(
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
            style: AppTextStyles.heading1.copyWith(
              fontSize: 28,
              color: AppColors.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'You\'ve completed the aptitude and interest assessment',
            style: AppTextStyles.bodyLarge.copyWith(
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
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.recommendedStream,
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 24,
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
            style: AppTextStyles.bodyLarge.copyWith(
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

  Widget _buildCareerRoadmapSection(BuildContext context, RoadmapController roadmapController) {
    if (roadmapController.isLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
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
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading career roadmap...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryBlue,
              ),
            ),
          ],
        ),
      );
    }

    if (roadmapController.currentRoadmap == null || 
        roadmapController.currentRoadmap!.roadmapSteps.isEmpty) {
      return const SizedBox.shrink();
    }

    final roadmap = roadmapController.currentRoadmap!;

    return Container(
      width: double.infinity,
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(
                  Icons.map,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '${roadmap.field} Career Roadmap',
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 20,
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: roadmap.roadmapSteps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                final isLast = index == roadmap.roadmapSteps.length - 1;
                
                return RoadmapCard(
                  step: step,
                  isLast: isLast,
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSuggestedCollegesSection(BuildContext context, RoadmapController roadmapController) {
    if (roadmapController.isLoading) {
      return const SizedBox.shrink();
    }

    if (roadmapController.currentRoadmap == null || 
        roadmapController.currentRoadmap!.suggestedColleges.isEmpty) {
      return const SizedBox.shrink();
    }

    final colleges = roadmapController.currentRoadmap!.suggestedColleges;

    return Container(
      width: double.infinity,
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: AppColors.orange,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Recommended Colleges in Kashmir',
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 20,
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Government colleges in Ghawal district that align with your chosen field',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryBlue,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: colleges.map((college) => CollegeCard(
                college: college,
              )).toList(),
            ),
          ),
          
          const SizedBox(height: 24),
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
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
                fontSize: 16,
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
              style: AppTextStyles.bodySmall.copyWith(
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
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18,
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
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                score.toString(),
                style: AppTextStyles.bodyMedium.copyWith(
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

  Widget _buildActionButtons(BuildContext context, QuizController quizController, RoadmapController roadmapController) {
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
          CustomButton(
            text: 'Explore ${quizController.recommendedStream} Roadmap',
            onPressed: () => _exploreFullRoadmap(context, quizController.recommendedStream),
            backgroundColor: AppColors.primaryBlue,
            textColor: AppColors.white,
            height: 48,
            icon: const Icon(Icons.map, size: 18, color: AppColors.white),
          ),
          
          const SizedBox(height: 12),
          
          // Secondary Actions
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: 'Retake Quiz',
                  onPressed: () => _retakeQuiz(context),
                  borderColor: AppColors.gray.withOpacity(0.3),
                  textColor: AppColors.secondaryBlue,
                  height: 44,
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: CustomOutlinedButton(
                  text: 'Back to Home',
                  onPressed: () => _goToHome(context),
                  borderColor: AppColors.gray.withOpacity(0.3),
                  textColor: AppColors.secondaryBlue,
                  height: 44,
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

  // Navigation methods
  void _exploreFullRoadmap(BuildContext context, String stream) {
    // Navigate to dedicated roadmap page
    Navigator.pushNamed(
      context,
      AppRoutes.roadmapResult,
      arguments: {'stream': stream},
    );
  }

  void _retakeQuiz(BuildContext context) {
    // Navigate to quiz page without using the disposed controller
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