import 'package:flutter/material.dart';
import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';

enum TransactionType { income, expense, transfer }

class TransactionItem {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final IconData icon;
  final Color iconColor;

  const TransactionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.date,
    required this.icon,
    required this.iconColor,
  });
}

class TransactionTile extends StatelessWidget {
  final TransactionItem item;
  final VoidCallback? onTap;

  const TransactionTile({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColorsDark.surface : AppColors.surface;
    final bgColor = item.iconColor.withAlpha(26);
    final isIncome = item.type == TransactionType.income;
    final amountColor = isIncome ? AppColors.success : AppColors.error;
    final amountSign = isIncome ? '+' : '-';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 22),
            ),
            const SizedBox(width: 14),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$amountSign\$${item.amount.toStringAsFixed(2)}',
                  style: AppTextStyles.body.copyWith(
                    color: amountColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(item.date),
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColorsDark.textSecondary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Sample data used by the dashboard in development.
List<TransactionItem> get sampleTransactions => [
      TransactionItem(
        id: '1',
        title: 'Salary Deposit',
        subtitle: 'Monthly income',
        amount: 3500.00,
        type: TransactionType.income,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        icon: Icons.business_center_rounded,
        iconColor: AppColors.success,
      ),
      TransactionItem(
        id: '2',
        title: 'Netflix',
        subtitle: 'Entertainment',
        amount: 15.99,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 1)),
        icon: Icons.movie_filter_rounded,
        iconColor: Colors.red,
      ),
      TransactionItem(
        id: '3',
        title: 'Transfer to John',
        subtitle: 'Personal transfer',
        amount: 200.00,
        type: TransactionType.transfer,
        date: DateTime.now().subtract(const Duration(days: 2)),
        icon: Icons.swap_horiz_rounded,
        iconColor: AppColors.primary,
      ),
      TransactionItem(
        id: '4',
        title: 'Grocery Store',
        subtitle: 'Daily shopping',
        amount: 78.50,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 3)),
        icon: Icons.shopping_basket_rounded,
        iconColor: Colors.orange,
      ),
      TransactionItem(
        id: '5',
        title: 'Freelance Payment',
        subtitle: 'Client project',
        amount: 850.00,
        type: TransactionType.income,
        date: DateTime.now().subtract(const Duration(days: 4)),
        icon: Icons.laptop_rounded,
        iconColor: Colors.teal,
      ),
    ];
