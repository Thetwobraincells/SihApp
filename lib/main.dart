// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'views/onboarding/login_screen.dart';
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
        // Add other providers here as needed
      ],
      child: MaterialApp(
        title: 'Career Compass',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primaryBlue,
          scaffoldBackgroundColor: AppColors.white,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // Configure the default text theme
          textTheme: const TextTheme(
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
        ),
        home: const LoginScreen(),
        // You can add routes here
        routes: {
          '/login': (context) => const LoginScreen(),
          // Add other routes as you create more screens
        },
      ),
    );
  }
}