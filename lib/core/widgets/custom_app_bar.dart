// lib/core/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final bool automaticallyImplyLeading; // NEW: Control automatic leading

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor = AppColors.darkBlue,
    this.foregroundColor = AppColors.primaryBlue,
    this.elevation = 0,
    this.automaticallyImplyLeading = true, // NEW: Default behavior
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Check if we can actually pop before showing back button
    final canPop = Navigator.of(context).canPop();
    final shouldShowBackButton = showBackButton && canPop && automaticallyImplyLeading;

    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: true,
      automaticallyImplyLeading: false, // FIXED: Prevent automatic back button
      leading: shouldShowBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => _handleBackPress(context),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.heading2.copyWith(
          color: foregroundColor,
          fontSize: 20,
        ),
      ),
      actions: actions,
    );
  }

  // FIXED: Safe navigation back
  void _handleBackPress(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? flexibleSpace;
  final double expandedHeight;
  final bool pinned;
  final bool floating;
  final bool automaticallyImplyLeading; // NEW: Control automatic leading

  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor = AppColors.darkBlue,
    this.foregroundColor = AppColors.primaryBlue,
    this.flexibleSpace,
    this.expandedHeight = 120,
    this.pinned = true,
    this.floating = false,
    this.automaticallyImplyLeading = true, // NEW: Default behavior
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Check if we can actually pop before showing back button
    final canPop = Navigator.of(context).canPop();
    final shouldShowBackButton = showBackButton && canPop && automaticallyImplyLeading;

    return SliverAppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      centerTitle: true,
      pinned: pinned,
      floating: floating,
      expandedHeight: expandedHeight,
      automaticallyImplyLeading: false, // FIXED: Prevent automatic back button
      leading: shouldShowBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => _handleBackPress(context),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.heading2.copyWith(
          color: foregroundColor,
          fontSize: 20,
        ),
      ),
      actions: actions,
      flexibleSpace: flexibleSpace,
    );
  }

  // FIXED: Safe navigation back
  void _handleBackPress(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }
}