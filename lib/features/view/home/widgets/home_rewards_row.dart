import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeRewardsRow extends StatelessWidget {
  const HomeRewardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _RewardCard(
              icon: IconImages.rewards,
              text: 'Share a meal with your friends only for today!',
              badge: '20%',
              badgeColor: AppColors.warning,
              gradient: const [Color(0xff1677FF), Color(0xff0050CC)],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RewardCard(
              icon: IconImages.cup,
              text: 'Get rewards of up to 200 points with every new friend you invite!',
              badge: 'CVR2242',
              badgeColor: const Color(0xffEA4E0D),
              gradient: const [Color(0xffEA4E0D), Color(0xffFD9A16)],
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final String icon;
  final String text;
  final String badge;
  final Color badgeColor;
  final List<Color> gradient;

  const _RewardCard({
    required this.icon,
    required this.text,
    required this.badge,
    required this.badgeColor,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const Spacer(),
                Text(
                  text,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badge,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
