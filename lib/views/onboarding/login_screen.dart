// lib/views/onboarding/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<AuthController>(
          builder: (context, authController, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Header
                    _buildHeader(),
                    
                    const SizedBox(height: 32),
                    
                    // Welcome text
                    _buildWelcomeText(),
                    
                    const SizedBox(height: 32),
                    
                    // Login form
                    _buildLoginForm(context, authController),
                    
                    const SizedBox(height: 24),
                    
                    // Forgot password
                    _buildForgotPassword(context, authController),
                    
                    const SizedBox(height: 32),
                    
                    // Login button
                    _buildLoginButton(context, authController),
                    
                    const SizedBox(height: 24),
                    
                    // Divider
                    _buildDivider(),
                    
                    const SizedBox(height: 16),
                    
                    // Social login buttons
                    _buildSocialLogin(context, authController),
                    
                    const SizedBox(height: 32),
                    
                    // Sign up link
                    _buildSignUpLink(context),
                    
                    const SizedBox(height: 24),
                    
                    // Terms and privacy
                    _buildTermsAndPrivacy(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Text(
        'Career Compass',
        style: AppTextStyles.heading2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome Back!',
      style: AppTextStyles.heading1,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginForm(BuildContext context, AuthController authController) {
    return Form(
      key: authController.loginFormKey,
      child: Column(
        children: [
          // Email field
          CustomTextField(
            hintText: 'Email Address',
            prefixIcon: Icons.email_outlined,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          
          const SizedBox(height: 16),
          
          // Password field
          CustomTextField(
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            controller: authController.passwordController,
            validator: Validators.validatePassword,
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context, AuthController authController) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () async {
          // Show forgot password dialog
          _showForgotPasswordDialog(context, authController);
        },
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.link.copyWith(
            color: AppColors.secondaryBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, AuthController authController) {
    return CustomButton(
      text: 'Log In',
      isLoading: authController.isLoading,
      onPressed: () async {
        final success = await authController.login();
        if (success && context.mounted) {
          // Navigate to home screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: AppColors.success,
            ),
          );
          // TODO: Navigate to home screen
        } else if (authController.errorMessage != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authController.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.primaryBlue)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.secondaryBlue,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.primaryBlue)),
      ],
    );
  }

  Widget _buildSocialLogin(BuildContext context, AuthController authController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google login
        CustomOutlinedButton(
          text: '',
          width: 56,
          onPressed: () async {
            final success = await authController.loginWithGoogle();
            if (success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google login successful!'),
                  backgroundColor: AppColors.success,
                ),
              );
              // TODO: Navigate to home screen
            }
          },
          child: const Icon(
            Icons.g_mobiledata_rounded,
            size: 28,
            color: AppColors.secondaryBlue,
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Facebook login
        CustomOutlinedButton(
          text: '',
          width: 56,
          onPressed: () async {
            final success = await authController.loginWithFacebook();
            if (success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Facebook login successful!'),
                  backgroundColor: AppColors.success,
                ),
              );
              // TODO: Navigate to home screen
            }
          },
          child: const Text(
            'f',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryBlue,
              fontFamily: 'serif',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryBlue,
          ),
        ),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to sign up screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Navigate to Sign Up screen'),
                backgroundColor: AppColors.info,
              ),
            );
          },
          child: Text(
            'Sign Up',
            style: AppTextStyles.linkBold,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndPrivacy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10,
            height: 1.4,
          ),
          children: [
            const TextSpan(
              text: 'By continuing, you agree to our ',
            ),
            TextSpan(
              text: 'Terms of Service',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: AppColors.darkBlue,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: AppColors.darkBlue,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context, AuthController authController) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Reset Password',
            style: AppTextStyles.heading2.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password.',
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  controller: emailController,
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.link.copyWith(
                  color: AppColors.gray,
                ),
              ),
            ),
            CustomButton(
              text: 'Send Reset Link',
              width: 140,
              height: 40,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final success = await authController.forgotPassword(
                    emailController.text,
                  );
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? 'Reset link sent to your email!'
                              : 'Failed to send reset link. Please try again.',
                        ),
                        backgroundColor: success ? AppColors.success : AppColors.error,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}