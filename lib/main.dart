import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controller.dart';
import 'controllers/roadmap_controller.dart';
import 'controllers/quiz_controller.dart';
import 'routes/app_routes.dart';
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
        ChangeNotifierProvider(create: (_) => QuizController()),
      ],
      child: MaterialApp(
        title: 'Career Compass',
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRoutes.navigatorKey,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primaryBlue,
          scaffoldBackgroundColor: AppColors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          
          // Google Fonts configuration
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
          
          // App bar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.darkBlue,
            elevation: 0,
            centerTitle: true,
          ),
          
          // Elevated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              foregroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          
          // Input decoration theme
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
          
          // Card theme
          cardTheme: CardThemeData(
            elevation: 2,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.black.withOpacity(0.1),
            margin: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
          ),
          
          // Checkbox theme
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.orange;
              }
              return AppColors.white;
            }),
            checkColor: MaterialStateProperty.all(AppColors.white),
            overlayColor: MaterialStateProperty.all(AppColors.orange.withOpacity(0.1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}