import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeNotificationsCard extends StatelessWidget {
  const HomeNotificationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NotifRow(text: 'Yay! You have a new message.', time: '2 hours ago'),
                SizedBox(height: 8),
                _NotifRow(text: 'Congratulations! new year offers.', time: '2 hours ago'),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _NotifRow extends StatelessWidget {
  final String text;
  final String time;
  const _NotifRow({required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          time,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
