// lib/views/quiz/roadmap_result_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/roadmap_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/roadmap_card.dart';
import '../../core/widgets/college_card.dart';
import '../../models/roadmap_model.dart';
import '../main_screen.dart';

class RoadmapResultPage extends StatefulWidget {
  final String stream;

  const RoadmapResultPage({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  State<RoadmapResultPage> createState() => _RoadmapResultPageState();
}

class _RoadmapResultPageState extends State<RoadmapResultPage> {
  @override
  void initState() {
    super.initState();
    // Load roadmap data for the specific stream
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final roadmapController = Provider.of<RoadmapController>(context, listen: false);
      roadmapController.loadRoadmapByStream(widget.stream);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoadmapController>(
      builder: (context, roadmapController, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Custom Header
                _buildHeader(context),
                
                // Roadmap Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Stream Header
                        _buildStreamHeader(context, widget.stream),
                        
                        const SizedBox(height: 24),
                        
                        // Career Roadmap Section
                        _buildCareerRoadmapSection(context, roadmapController),
                        
                        const SizedBox(height: 24),
                        
                        // Suggested Colleges Section
                        _buildSuggestedCollegesSection(context, roadmapController),
                        
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                
                // Action Buttons
                _buildActionButtons(context),
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
            _getStreamColor(widget.stream),
            _getStreamColor(widget.stream).withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
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
                  '${widget.stream} Career Roadmap',
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your personalized career path',
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
            child: Icon(
              _getStreamIcon(widget.stream),
              color: AppColors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamHeader(BuildContext context, String stream) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getStreamColor(stream).withOpacity(0.1),
            _getStreamColor(stream).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getStreamColor(stream).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _getStreamColor(stream),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: _getStreamColor(stream).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              _getStreamIcon(stream),
              color: AppColors.white,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            stream,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 28,
              color: AppColors.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Career Development Path',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.secondaryBlue,
            ),
            textAlign: TextAlign.center,
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
                  color: _getStreamColor(widget.stream),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Career Development Steps',
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
                  'Government colleges that align with your chosen field',
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

  Widget _buildActionButtons(BuildContext context) {
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
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.gray.withOpacity(0.3)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Back to Results',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.secondaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _getStreamColor(widget.stream),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Go to Home',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
}
