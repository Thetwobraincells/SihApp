// lib/views/roadmap/clean_roadmap_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/job_card.dart';
import '../../core/widgets/job_card_shimmer.dart';
import '../../controllers/roadmap_controller.dart';
import '../../models/roadmap_model.dart';

class CleanRoadmapScreen extends StatefulWidget {
  final String? roadmapId;

  const CleanRoadmapScreen({
    Key? key,
    this.roadmapId,
  }) : super(key: key);

  @override
  State<CleanRoadmapScreen> createState() => _CleanRoadmapScreenState();
}

class _CleanRoadmapScreenState extends State<CleanRoadmapScreen> {
  late RoadmapController _roadmapController;

  @override
  void initState() {
    super.initState();
    _roadmapController = context.read<RoadmapController>();
    _loadRoadmapData();
  }

  void _loadRoadmapData() {
    final roadmapId = widget.roadmapId ?? 'software_engineer';
    _roadmapController.loadRoadmap(roadmapId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoadmapController>(
      builder: (context, controller, child) {
        return _buildContent(controller);
      },
    );
  }

  // FIXED: Clean scaffold without duplicate navigation
  Widget _buildContent(RoadmapController controller) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: _buildBodyContent(controller),
      ),
    );
  }

  Widget _buildBodyContent(RoadmapController controller) {
    if (controller.isLoading) {
      return _buildLoadingState();
    }

    if (controller.errorMessage != null) {
      return _buildErrorState(controller.errorMessage!);
    }

    if (controller.currentRoadmap == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadRoadmapData();
      });
      return _buildLoadingState();
    }
    
    return _buildRoadmapContent(controller.currentRoadmap!);
  }

  Widget _buildRoadmapContent(RoadmapModel roadmap) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 32),
          _buildFieldHeader(roadmap),
          const SizedBox(height: 32),
          _buildTimelineDivider(),
          const SizedBox(height: 16),
          _buildJobsHeader(),
          const SizedBox(height: 16),
          _buildTimelineDivider(),
          const SizedBox(height: 24),
          _buildJobsList(roadmap.jobs),
        ],
      ),
    );
  }

  // FIXED: Explicit text decoration removal to prevent yellow underline
  Widget _buildFieldHeader(RoadmapModel roadmap) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.secondaryBlue,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryBlue.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            _roadmapController.getIconData(roadmap.iconName),
            size: 40,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          roadmap.field,
          style: AppTextStyles.heading1.copyWith(
            fontSize: 28,
            color: AppColors.darkBlue,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          roadmap.grade,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.gray,
            decoration: TextDecoration.none, // This removes the yellow underline
            decorationColor: Colors.transparent,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimelineDivider() {
    return Container(
      width: 6,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildJobsHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Possible Jobs',
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkBlue,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildJobsList(List<JobOpportunity> jobs) {
    if (jobs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.work_outline,
              size: 48,
              color: AppColors.secondaryBlue.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No jobs available yet',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryBlue,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: jobs.map((job) {
        return JobCard(
          job: job,
          onTap: () => _onJobTap(job),
          showDetails: true,
        );
      }).toList(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primaryBlue,
          ),
          SizedBox(height: 16),
          Text(
            'Loading roadmap data...',
            style: TextStyle(
              color: AppColors.darkBlue,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.darkBlue,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: AppTextStyles.bodyMedium.copyWith(
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadRoadmapData,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: AppColors.darkBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _onJobTap(JobOpportunity job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildJobDetailSheet(job),
    );
  }
  
  Widget _buildJobDetailSheet(JobOpportunity job) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                    decoration: TextDecoration.none,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.darkBlue),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                _buildInfoChip(Icons.attach_money, job.salaryRange),
                const SizedBox(width: 12.0),
                _buildInfoChip(Icons.work_outline, job.experienceLevel),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Job Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              job.description,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.darkBlue,
                height: 1.5,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Required Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: job.requiredSkills.map((skill) => Chip(
                label: Text(
                  skill,
                  style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                backgroundColor: AppColors.primaryBlue,
              )).toList(),
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application process started!'),
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryBlue),
          const SizedBox(width: 4.0),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}