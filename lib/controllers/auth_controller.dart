// lib/controllers/auth_controller.dart
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form key
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Login method
  Future<bool> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Here you would typically call your API service
      // Example: await ApiService.login(email, password);
      
      // For demo purposes, we'll simulate a successful login
      final email = emailController.text;
      final password = passwordController.text;
      
      if (email.isNotEmpty && password.isNotEmpty) {
        _isLoggedIn = true;
        _setLoading(false);
        return true;
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Social login methods
  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate Google login
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would implement Google Sign-In
      _isLoggedIn = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Google login failed');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> loginWithFacebook() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate Facebook login
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would implement Facebook Sign-In
      _isLoggedIn = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Facebook login failed');
      _setLoading(false);
      return false;
    }
  }

  // Forgot password
  Future<bool> forgotPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate forgot password API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would call your forgot password API
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to send reset email');
      _setLoading(false);
      return false;
    }
  }

  // Logout
  void logout() {
    _isLoggedIn = false;
    emailController.clear();
    passwordController.clear();
    _clearError();
    notifyListeners();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}