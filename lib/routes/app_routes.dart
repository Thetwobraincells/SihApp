import 'package:flutter/material.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/onboarding/login_screen.dart';
import '../views/splash_screen.dart';
import '../views/main_screen.dart';
import '../views/roadmap/clean_roadmap_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String main = '/main';
  static const String registration = '/registration';
  static const String quiz = '/quiz';
  static const String collegeFinder = '/college-finder';
  static const String roadmap = '/roadmap';
  static const String roleModels = '/role-models';
  static const String scholarships = '/scholarships';
  static const String timeline = '/timeline';
  static const String parentZone = '/parent-zone';
  static const String careerSwitch = '/career-switch';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case roadmap:
        return MaterialPageRoute(builder: (_) => const CleanRoadmapScreen());
      // Add other routes here as needed
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}