import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(context),
            
            const SizedBox(height: 24),
            
            // Profile Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Details Section
                  _buildUserDetailsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Settings Section
                  _buildSettingsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Actions Section
                  _buildActionsSection(context),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryBlue.withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.primaryBlue,
                size: 60,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Name
            Text(
              'John Doe',
              style: AppTextStyles.heading1.copyWith(
                color: AppColors.white,
                fontSize: 28,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Email
            Text(
              'john.doe@example.com',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Edit Profile Button
            ElevatedButton(
              onPressed: () => _editProfile(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primaryBlue,
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Edit Profile',
                    style: AppTextStyles.button.copyWith(
                      fontSize: 16,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Personal Information',
      [
        _buildInfoRow(context, 'Phone', '+1 (555) 123-4567', Icons.phone),
        _buildInfoRow(context, 'Location', 'Mumbai, Maharashtra', Icons.location_on),
        _buildInfoRow(context, 'Career Goal', 'Software Engineer', Icons.work),
        _buildInfoRow(context, 'Education', 'Computer Science Student', Icons.school),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return _buildSection(
      context,
      'Settings',
      [
        _buildSettingsTile(context, 'Notifications', 'Manage your notification preferences', Icons.notifications, () => _openNotifications(context)),
        _buildSettingsTile(context, 'Privacy', 'Control your privacy settings', Icons.privacy_tip, () => _openPrivacy(context)),
        _buildSettingsTile(context, 'Help & Support', 'Get help and support', Icons.help, () => _openSupport(context)),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return _buildSection(
      context,
      'Account',
      [
        _buildSettingsTile(context, 'Change Password', 'Update your account password', Icons.lock, () => _changePassword(context)),
        _buildSettingsTile(context, 'Delete Account', 'Permanently delete your account', Icons.delete_forever, () => _deleteAccount(context), isDestructive: true),
        _buildSettingsTile(context, 'Sign Out', 'Sign out of your account', Icons.logout, () => _signOut(context), isDestructive: true),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 20,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDestructive 
                    ? AppColors.error.withOpacity(0.1)
                    : AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.error : AppColors.primaryBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDestructive ? AppColors.error : AppColors.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryBlue,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Action methods
  void _editProfile(BuildContext context) {
    // Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit Profile - Coming Soon'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _openNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notifications Settings - Coming Soon'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _openPrivacy(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Privacy Settings - Coming Soon'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _openSupport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Help & Support - Coming Soon'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _changePassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Change Password - Coming Soon'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: AppColors.error)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Delete Account - Coming Soon'),
                    backgroundColor: AppColors.error,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Sign Out', style: TextStyle(color: AppColors.error)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sign Out - Coming Soon'),
                    backgroundColor: AppColors.primaryBlue,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}