import 'package:flutter/material.dart';
import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/l10n/generated/app_localizations.dart';

class QuickActionsRow extends StatelessWidget {
  final void Function(String action)? onActionTap;

  const QuickActionsRow({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final actions = [
      _QuickAction(
        key: 'send',
        icon: Icons.arrow_upward_rounded,
        label: l10n.send,
        color: AppColors.primary,
      ),
      _QuickAction(
        key: 'receive',
        icon: Icons.arrow_downward_rounded,
        label: l10n.receive,
        color: AppColors.success,
      ),
      _QuickAction(
        key: 'topup',
        icon: Icons.add_rounded,
        label: l10n.topUp,
        color: AppColors.warning,
      ),
      _QuickAction(
        key: 'pay',
        icon: Icons.qr_code_scanner_rounded,
        label: l10n.pay,
        color: const Color(0xff722ED1),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // On tablets (> 600px) show as 2-row grid, on mobile as single row
          final isTablet = constraints.maxWidth > 560;

          if (isTablet) {
            return GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              children: actions
                  .map((a) => _ActionButton(action: a, isDark: isDark,
                        onTap: () => onActionTap?.call(a.key)))
                  .toList(),
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions
                .map((a) => _ActionButton(
                      action: a,
                      isDark: isDark,
                      onTap: () => onActionTap?.call(a.key),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final _QuickAction action;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionButton({
    required this.action,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark
        ? action.color.withAlpha(31)
        : action.color.withAlpha(26);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(action.icon, color: action.color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            action.label,
            style: AppTextStyles.caption.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final String key;
  final IconData icon;
  final String label;
  final Color color;

  const _QuickAction({
    required this.key,
    required this.icon,
    required this.label,
    required this.color,
  });
}
