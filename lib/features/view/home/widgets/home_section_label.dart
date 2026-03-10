import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeSectionLabel extends StatelessWidget {
  final String title;
  const HomeSectionLabel(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
