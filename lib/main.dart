// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controller.dart';
import 'controllers/roadmap_controller.dart';
import 'views/onboarding/login_screen.dart';
import 'views/roadmap/clean_roadmap_screen.dart';
import 'views/main_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => RoadmapController()),
        // Add other providers here as needed
      ],
      child: MaterialApp(
        title: 'Career Compass',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primaryBlue,
          scaffoldBackgroundColor: AppColors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          
          // Configure the default text theme with Google Fonts
          textTheme: GoogleFonts.robotoTextTheme(
            const TextTheme(
              displayLarge: TextStyle(color: AppColors.darkBlue),
              displayMedium: TextStyle(color: AppColors.darkBlue),
              displaySmall: TextStyle(color: AppColors.darkBlue),
              headlineLarge: TextStyle(color: AppColors.darkBlue),
              headlineMedium: TextStyle(color: AppColors.darkBlue),
              headlineSmall: TextStyle(color: AppColors.darkBlue),
              titleLarge: TextStyle(color: AppColors.darkBlue),
              titleMedium: TextStyle(color: AppColors.darkBlue),
              titleSmall: TextStyle(color: AppColors.darkBlue),
              bodyLarge: TextStyle(color: AppColors.darkBlue),
              bodyMedium: TextStyle(color: AppColors.secondaryBlue),
              bodySmall: TextStyle(color: AppColors.secondaryBlue),
            ),
          ),
          
          // Configure app bar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.darkBlue,
            elevation: 0,
            centerTitle: true,
          ),
          
          // Configure elevated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              foregroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
          ),
          
          // Configure input decoration theme
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.gray.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        
        // For testing: Start directly with MainScreen
        // In production, use the auth check below
        home: const MainScreen(),
        
        // Production version with auth check:
        // home: Consumer<AuthController>(
        //   builder: (context, auth, _) {
        //     return auth.isLoggedIn ? const MainScreen() : const LoginScreen();
        //   },
        // ),
        
        // Define app routes
        routes: {
          '/login': (context) => const LoginScreen(),
          '/main': (context) => const MainScreen(),
          '/roadmap': (context) => const CleanRoadmapScreen(),
          // Add other routes as you create more screens
        },
        
        // Handle unknown routes
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          );
        },
      ),
    );
  }
}