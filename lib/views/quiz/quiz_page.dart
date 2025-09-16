import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/quiz_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../models/quiz_model.dart';
import 'quiz_result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizController()..initializeQuiz(),
      child: const _QuizPageContent(),
    );
  }
}

class _QuizPageContent extends StatelessWidget {
  const _QuizPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizController>(
      builder: (context, quizController, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: _buildAppBar(context, quizController),
          body: Column(
            children: [
              // Progress Bar
              _buildProgressBar(context, quizController),
              
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Counter
                      _buildQuestionCounter(context, quizController),
                      
                      const SizedBox(height: 16),
                      
                      // Question Card
                      _buildQuestionCard(context, quizController),
                      
                      const SizedBox(height: 24),
                      
                      // Options Grid
                      _buildOptionsGrid(context, quizController),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              
              // Navigation Buttons
              _buildNavigationButtons(context, quizController),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, QuizController controller) {
    return AppBar(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.darkBlue,
      elevation: 0,
      title: Text(
        'Aptitude & Interest Quiz',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkBlue,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi,
                size: 16,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 4),
              Text(
                'Online',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context, QuizController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${controller.currentQuestionIndex + 1}/${controller.totalQuestions}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(controller.progressPercentage * 100).toInt()}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: controller.progressPercentage,
            backgroundColor: AppColors.gray.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCounter(BuildContext context, QuizController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Question ${controller.currentQuestionIndex + 1}/${controller.totalQuestions}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, QuizController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        controller.currentQuestion.question,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: AppColors.darkBlue,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildOptionsGrid(BuildContext context, QuizController controller) {
    final options = controller.currentQuestion.options;
    
    // Determine grid layout based on screen size and option count
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    double childAspectRatio;
    
    if (options.length <= 4) {
      // For 4 or fewer options, use 2 columns on mobile, 3 on tablet
      crossAxisCount = screenWidth > 600 ? 3 : 2;
      // Give tiles more height to avoid vertical overflow of icon + text
      childAspectRatio = screenWidth > 600 ? 1.6 : 1.2;
    } else {
      // For more than 4 options (like rating scales), use single column
      crossAxisCount = 1;
      childAspectRatio = 3.0;
    }
    
    // Check if this is a rating scale question (options are numbers)
    final isRatingScale = options.every((option) => 
        RegExp(r'^\d+$').hasMatch(option.text));
    
    if (isRatingScale) {
      return _buildRatingScale(context, controller);
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = controller.getSelectedAnswer(controller.currentQuestionIndex) == option;
        
        return _buildOptionCard(context, option, isSelected, () {
          controller.selectAnswer(option);
        });
      },
    );
  }

  Widget _buildRatingScale(BuildContext context, QuizController controller) {
    final options = controller.currentQuestion.options;
    final selectedOption = controller.getSelectedAnswer(controller.currentQuestionIndex);
    
    return Column(
      children: [
        // Scale Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Not at all',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryBlue,
              ),
            ),
            Text(
              'Very much',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryBlue,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Rating Scale
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            final value = int.parse(option.text);
            
            return GestureDetector(
              onTap: () => controller.selectAnswer(option),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.orange : AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? AppColors.orange : AppColors.gray.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ] : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected ? AppColors.white : AppColors.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOptionCard(BuildContext context, QuizOption option, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.gray.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Option icon based on content
            _buildOptionIcon(option, isSelected),
            
            const SizedBox(height: 8),
            
            // Option text
            Flexible(
              child: Text(
              option.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.primaryBlue : AppColors.darkBlue,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionIcon(QuizOption option, bool isSelected) {
    IconData icon;
    Color color = isSelected ? AppColors.primaryBlue : AppColors.secondaryBlue;
    
    // Determine icon based on option content
    final text = option.text.toLowerCase();
    if (text.contains('math') || text.contains('formula') || text.contains('numerical')) {
      icon = Icons.calculate;
    } else if (text.contains('art') || text.contains('creative') || text.contains('drawing')) {
      icon = Icons.palette;
    } else if (text.contains('business') || text.contains('money') || text.contains('entrepreneur')) {
      icon = Icons.business;
    } else if (text.contains('practical') || text.contains('hands') || text.contains('building')) {
      icon = Icons.build;
    } else if (text.contains('science') || text.contains('research') || text.contains('technology')) {
      icon = Icons.science;
    } else if (text.contains('writing') || text.contains('literature') || text.contains('essay')) {
      icon = Icons.edit;
    } else if (text.contains('social') || text.contains('speaking') || text.contains('debate')) {
      icon = Icons.group;
    } else {
      icon = Icons.radio_button_unchecked;
    }
    
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        size: 18,
        color: color,
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, QuizController controller) {
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
          // Previous Button
          if (controller.currentQuestionIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: controller.previousQuestion,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Previous',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          else
            const Spacer(),
          
          if (controller.currentQuestionIndex > 0) const SizedBox(width: 16),
          
          // Next/Submit Button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: controller.isCurrentQuestionAnswered 
                  ? () => _handleNextOrSubmit(context, controller)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.gray.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: Text(
                controller.currentQuestionIndex == controller.totalQuestions - 1
                    ? 'Submit Quiz'
                    : 'Next',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

  void _handleNextOrSubmit(BuildContext context, QuizController controller) {
    if (controller.currentQuestionIndex == controller.totalQuestions - 1) {
      // Submit quiz
      if (controller.canSubmitQuiz()) {
        controller.calculateResults();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: controller,
              child: const QuizResultPage(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please answer all questions before submitting'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      // Go to next question
      controller.nextQuestion();
    }
  }
}