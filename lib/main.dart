// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controller.dart';
import 'controllers/roadmap_controller.dart';
import 'views/main_screen.dart'; // For direct testing
import 'core/constants/app_colors.dart';
import 'routes/app_routes.dart';

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
          // Keep your existing Material 3 configuration
          useMaterial3: true,
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primaryBlue,
          scaffoldBackgroundColor: AppColors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          
          // Keep your existing Google Fonts configuration
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
          
          // Keep your existing app bar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.darkBlue,
            elevation: 0,
            centerTitle: true,
          ),
          
          // Keep your existing elevated button theme
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
          
          // Keep your existing input decoration theme
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
          
          // Add card theme for consistent styling
          cardTheme: CardThemeData(
            elevation: 0,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.black.withOpacity(0.04),
          ),
        ),
        
        // TEMPORARY: Start directly with MainScreen to test the Home page
        // Comment this out once everything works and uncomment the lines below
        home: const MainScreen(),
        
        // PRODUCTION: Use this once everything is working
        // initialRoute: AppRoutes.splash,
        // onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}