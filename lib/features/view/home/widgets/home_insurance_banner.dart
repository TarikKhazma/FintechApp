import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeInsuranceBanner extends StatelessWidget {
  const HomeInsuranceBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grab your Insurance Offer Today!',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        children: const [
                          TextSpan(text: 'Get 25% off your next '),
                          TextSpan(
                            text: 'health insurance',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: ' renewals with us and '),
                          TextSpan(
                            text: 'protect your family!!',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(IconImages.baohusan, width: 56, height: 56),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _BannerDot(active: true),
              SizedBox(width: 4),
              _BannerDot(active: false),
              SizedBox(width: 4),
              _BannerDot(active: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _BannerDot extends StatelessWidget {
  final bool active;
  const _BannerDot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
