// lib/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class AuthController extends ChangeNotifier {
  // Private fields
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  // Login Form
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Signup Form
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController signUpFirstNameController = TextEditingController();
  final TextEditingController signUpLastNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPhoneController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController signUpConfirmPasswordController = TextEditingController();

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Public methods
  
  // Login with email and password
  Future<bool> login() async {
    _setLoading(true);
    _clearError();

    try {
      // Get the form values
      final email = emailController.text.trim();
      final password = passwordController.text;
      
      // Admin credentials check (bypasses form validation)
      if (email == 'admin' && password == '1234') {
        // Simulate API call delay
        await Future.delayed(const Duration(milliseconds: 500));
        _isLoggedIn = true;
        _setLoading(false);
        notifyListeners();
        
        // Navigate to main screen after successful login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(AppRoutes.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
            AppRoutes.main,
            (route) => false,
          );
        });
        
        return true;
      }
      
      // Regular login validation for non-admin users
      if (!loginFormKey.currentState!.validate()) {
        _setLoading(false);
        return false;
      }
      
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Regular user login logic
      if (email.isNotEmpty && password.isNotEmpty) {
        _isLoggedIn = true;
        _setLoading(false);
        notifyListeners();
        
        // Navigate to main screen after successful login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(AppRoutes.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
            AppRoutes.main,
            (route) => false,
          );
        });
        
        return true;
      } else {
        _setError('Please enter both email and password');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An error occurred. Please try again.');
      _setLoading(false);
      return false;
    } finally {
      // Clear sensitive data
      passwordController.clear();
    }
  }

  // Sign up with email and password
  Future<bool> signUp() async {
    if (!signUpFormKey.currentState!.validate()) {
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoggedIn = true;
      
      // Clear the form after successful signup
      signUpFirstNameController.clear();
      signUpLastNameController.clear();
      signUpEmailController.clear();
      signUpPhoneController.clear();
      signUpPasswordController.clear();
      signUpConfirmPasswordController.clear();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Social sign up methods
  Future<bool> signUpWithGoogle() async {
    return await _handleSocialSignIn('Google');
  }

  Future<bool> signUpWithFacebook() async {
    return await _handleSocialSignIn('Facebook');
  }

  // Social login methods
  Future<bool> loginWithGoogle() async {
    return await _handleSocialLogin('Google');
  }

  Future<bool> loginWithFacebook() async {
    return await _handleSocialLogin('Facebook');
  }

  // Forgot password
  Future<bool> forgotPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to send password reset email: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Logout
  void logout() {
    _isLoggedIn = false;
    _errorMessage = null;
    _isLoading = false;
    
    // Clear all controllers
    emailController.clear();
    passwordController.clear();
    signUpFirstNameController.clear();
    signUpLastNameController.clear();
    signUpEmailController.clear();
    signUpPhoneController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
    
    notifyListeners();
  }

  // Private helper methods for social auth
  Future<bool> _handleSocialSignIn(String provider) async {
    _setLoading(true);
    _clearError();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _isLoggedIn = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to sign in with $provider: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> _handleSocialLogin(String provider) async {
    _setLoading(true);
    _clearError();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _isLoggedIn = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('$provider login failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    emailController.dispose();
    passwordController.dispose();
    signUpFirstNameController.dispose();
    signUpLastNameController.dispose();
    signUpEmailController.dispose();
    signUpPhoneController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    
    super.dispose();
  }
}