import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HubItem {
  final String icon;
  final String label;
  final VoidCallback? onTap;

  const HubItem(this.icon, this.label, {this.onTap});
}

final financialHubItems = [
  HubItem(IconImages.cardrepay, 'Card Repay', onTap: () {}),
  HubItem(IconImages.saving, 'Savings', onTap: () {}),
  HubItem(IconImages.invest, 'Invest', onTap: () {}),
  HubItem(IconImages.exchange, 'Exchange', onTap: () {}),
];

final convenientHubItems = [
  HubItem(IconImages.travel, 'Travel', onTap: () {}),
  HubItem(IconImages.topup, 'Top Up', onTap: () {}),
  HubItem(IconImages.utilities, 'Utilities', onTap: () {}),
  HubItem(IconImages.cityservices, 'City Services', onTap: () {}),
  HubItem(IconImages.rewards, 'Rewards', onTap: () {}),
  HubItem(IconImages.familycenter, 'Family Center', onTap: () {}),
  HubItem(IconImages.creditlife, 'Credit Life', onTap: () {}),
  HubItem(IconImages.more, 'More', onTap: () {}),
];

class HomeHubCard extends StatelessWidget {
  final List<HubItem> items;
  const HomeHubCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.85,
        children: items.map((item) => _HubGridItem(item: item)).toList(),
      ),
    );
  }
}

class _HubGridItem extends StatelessWidget {
  final HubItem item;
  const _HubGridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(item.icon, width: 36, height: 36),
            const SizedBox(height: 6),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textPrimary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
