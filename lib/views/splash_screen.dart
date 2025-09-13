import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Add any initialization logic here (e.g., checking if user is logged in)
    await Future.delayed(const Duration(seconds: 2));
    
    // Navigate to MainScreen directly (skip onboarding for testing)
    // Change this to AppRoutes.onboarding if you want to go through onboarding flow
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.school,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // App name
            Text(
              'Career Compass',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Tagline
            Text(
              'Your path to success starts here',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryBlue,
              ),
            ),
            const SizedBox(height: 40),
            // Loading indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
          ],
        ),
      ),
    );
  }
}