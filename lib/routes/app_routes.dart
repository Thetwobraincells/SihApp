// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/onboarding/login_screen.dart';
import '../views/onboarding/signup_screen.dart';
import '../views/splash_screen.dart';
import '../views/main_screen.dart';
import '../views/roadmap/clean_roadmap_screen.dart';
import '../views/college_finder/college_finder_screen.dart';
import '../views/profile_page.dart';
import '../views/quiz/quiz_page.dart';
import '../views/quiz/quiz_result_page.dart';
import '../views/quiz/roadmap_result_page.dart';

class AppRoutes {
  // Navigator Key for global navigation
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String main = '/main';
  static const String onboarding = '/onboarding';
  static const String quiz = '/quiz';
  static const String quizResult = '/quiz-result';
  static const String roadmap = '/roadmap';
  static const String collegeFinder = '/college-finder';
  static const String profile = '/profile';
  static const String registration = '/registration';
  static const String roadmapResult = '/roadmap-result';
  static const String roleModels = '/role-models';
  static const String scholarships = '/scholarships';
  static const String timeline = '/timeline';
  static const String parentZone = '/parent-zone';
  static const String careerSwitch = '/career-switch';
  
  // Check if route requires authentication
  static bool _isProtectedRoute(String? routeName) {
    final protectedRoutes = [
      main,
      profile,
      quiz,
      roadmap,
      collegeFinder,
    ];
    return protectedRoutes.contains(routeName);
  }
  
  // Generate route based on settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Get the auth controller if context is available
    final auth = navigatorKey.currentContext?.read<AuthController>();
    
    // Check if route is protected and user is not logged in
    if (_isProtectedRoute(settings.name) && (auth == null || !auth.isLoggedIn)) {
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    }
    
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case quiz:
        return MaterialPageRoute(builder: (_) => const QuizPage());
      case quizResult:
        return MaterialPageRoute(builder: (_) => const QuizResultPage());
      case roadmapResult:
        final args = settings.arguments as Map<String, dynamic>?;
        final stream = args?['stream'] ?? 'Science';
        return MaterialPageRoute(builder: (_) => RoadmapResultPage(stream: stream));
      case roadmap:
        return MaterialPageRoute(builder: (_) => const CleanRoadmapScreen());
      case collegeFinder:
        return MaterialPageRoute(builder: (_) => const CollegeFinderScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case registration:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case roleModels:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Role Models'))));
      case scholarships:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Scholarships'))));
      case timeline:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Timeline'))));
      case parentZone:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Parent Zone'))));
      case careerSwitch:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Career Switch'))));
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
  
  // Navigation helper methods
  static Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    bool Function(Route<dynamic>)? predicate,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }
}