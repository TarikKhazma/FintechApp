import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _QuickActionItem(icon: IconImages.scan, label: 'Scan', onTap: () {}),
          _QuickActionItem(icon: IconImages.pay, label: 'Pay', onTap: () {}),
          _QuickActionItem(icon: IconImages.collect, label: 'Collect', onTap: () {}),
          _QuickActionItem(icon: IconImages.pocket, label: 'Pocket', onTap: () {}),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickActionItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: SvgPicture.asset(icon, width: 28, height: 28)),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared card wrapper used across home widgets ─────────────────────────────
class _HomeCard extends StatelessWidget {
  final Widget child;

  const _HomeCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
