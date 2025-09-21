// lib/views/onboarding/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _acceptTerms = false;

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
                    
                    const SizedBox(height: 24),
                    
                    // Welcome text
                    _buildWelcomeText(),
                    
                    const SizedBox(height: 32),
                    
                    // Social sign up buttons
                    _buildSocialSignUp(context, authController),
                    
                    const SizedBox(height: 24),
                    
                    // Divider
                    _buildDivider(),
                    
                    const SizedBox(height: 24),
                    
                    // Sign up form
                    _buildSignUpForm(context, authController),
                    
                    const SizedBox(height: 16),
                    
                    // Terms and conditions checkbox
                    _buildTermsCheckbox(),
                    
                    const SizedBox(height: 24),
                    
                    // Sign up button
                    _buildSignUpButton(context, authController),
                    
                    const SizedBox(height: 24),
                    
                    // Login link
                    _buildLoginLink(context),
                    
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
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.darkBlue,
              size: 20,
            ),
          ),
        ),
        const Expanded(
          child: Text(
            'Career Compass',
            style: AppTextStyles.heading2,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 40), // Balance the back button
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        const Text(
          'Create Account',
          style: AppTextStyles.heading1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Join Career Compass and discover your future!',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryBlue,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSocialSignUp(BuildContext context, AuthController authController) {
    return Column(
      children: [
        // Google sign up
        CustomButton(
          text: 'Continue with Google',
          backgroundColor: AppColors.white,
          textColor: AppColors.darkBlue,
          isLoading: authController.isLoading,
          onPressed: () async {
            final success = await authController.signUpWithGoogle();
            if (success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google sign up successful!'),
                  backgroundColor: AppColors.success,
                ),
              );
              // TODO: Navigate to home screen or onboarding
            }
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryBlue),
            elevation: 0,
          ),
          icon: const Icon(
            Icons.g_mobiledata_rounded,
            size: 24,
            color: AppColors.secondaryBlue,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Facebook sign up
        CustomButton(
          text: 'Continue with Facebook',
          backgroundColor: AppColors.white,
          textColor: AppColors.darkBlue,
          isLoading: authController.isLoading,
          onPressed: () async {
            final success = await authController.signUpWithFacebook();
            if (success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Facebook sign up successful!'),
                  backgroundColor: AppColors.success,
                ),
              );
              // TODO: Navigate to home screen or onboarding
            }
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryBlue),
            elevation: 0,
          ),
          icon: const Text(
            'f',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryBlue,
              fontFamily: 'serif',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.primaryBlue)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or sign up with email',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.secondaryBlue,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.primaryBlue)),
      ],
    );
  }

  Widget _buildSignUpForm(BuildContext context, AuthController authController) {
    return Form(
      key: authController.signUpFormKey,
      child: Column(
        children: [
          // First Name and Last Name Row
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: 'First Name',
                  prefixIcon: Icons.person_outline,
                  controller: authController.signUpFirstNameController,
                  validator: Validators.validateFirstName,
                  keyboardType: TextInputType.name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  hintText: 'Last Name',
                  prefixIcon: Icons.person_outline,
                  controller: authController.signUpLastNameController,
                  validator: Validators.validateLastName,
                  keyboardType: TextInputType.name,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Email field
          CustomTextField(
            hintText: 'Email Address',
            prefixIcon: Icons.email_outlined,
            controller: authController.signUpEmailController,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          
          const SizedBox(height: 16),
          
          // Phone number field (optional)
          CustomTextField(
            hintText: 'Phone Number (Optional)',
            prefixIcon: Icons.phone_outlined,
            controller: authController.signUpPhoneController,
            validator: Validators.validatePhone,
            keyboardType: TextInputType.phone,
          ),
          
          const SizedBox(height: 16),
          
          // Password field
          CustomTextField(
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            controller: authController.signUpPasswordController,
            validator: Validators.validateStrongPassword,
            isPassword: true,
          ),
          
          const SizedBox(height: 16),
          
          // Confirm Password field
          CustomTextField(
            hintText: 'Confirm Password',
            prefixIcon: Icons.lock_outline,
            controller: authController.signUpConfirmPasswordController,
            validator: (value) => Validators.validateConfirmPassword(
              authController.signUpPasswordController.text,
              value,
            ),
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppColors.orange,
          checkColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.secondaryBlue,
                fontSize: 12,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context, AuthController authController) {
    return CustomButton(
      text: 'Create Account',
      isLoading: authController.isLoading,
      onPressed: _acceptTerms ? () async {
        final success = await authController.signUp();
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: AppColors.success,
            ),
          );
          // TODO: Navigate to email verification or home screen
        } else if (authController.errorMessage != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authController.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } : null,
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryBlue,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: Text(
            'Log In',
            style: AppTextStyles.linkBold.copyWith(
              color: AppColors.orange,
            ),
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
            color: AppColors.secondaryBlue,
          ),
          children: [
            const TextSpan(
              text: 'By creating an account, you acknowledge that you have read and understood our ',
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
}