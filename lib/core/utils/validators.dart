// lib/core/utils/validators.dart
class Validators {
  // Helper method for length validation
  static String? _validateLength(String? value, int min, int max, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    if (value.length < min) {
      return '$fieldName must be at least $min characters long';
    }
    
    if (value.length > max) {
      return '$fieldName must be less than $max characters long';
    }
    
    return null;
  }
  
  // Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
  
  // Password validation
  static String? validatePassword(String? password) {
    return _validateLength(password, 6, 50, 'Password');
  }
  
  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  // Phone number validation
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    
    if (!phoneRegExp.hasMatch(phone)) {
      return 'Please enter a valid 10-digit phone number';
    }
    
    return null;
  }
  
  // First name validation
  static String? validateFirstName(String? firstName) {
    return _validateLength(firstName, 2, 50, 'First name');
  }
  
  // Last name validation
  static String? validateLastName(String? lastName) {
    return _validateLength(lastName, 2, 50, 'Last name');
  }
  
  // Strong password validation
  static String? validateStrongPassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    if (!password.contains(RegExp(r'[!@#\$%^&*(),.?\":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }
  
  // Confirm password validation
  static String? validateConfirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  // Name validation
  static String? validateName(String? name) {
    return _validateLength(name, 2, 50, 'Name');
  }
}