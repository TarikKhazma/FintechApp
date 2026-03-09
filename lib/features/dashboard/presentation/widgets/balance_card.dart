import 'package:flutter/material.dart';
import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/l10n/generated/app_localizations.dart';

class BalanceCard extends StatefulWidget {
  final double balance;
  final String currency;
  final String maskedCard;
  final double monthlySpending;
  final double spendingLimit;

  const BalanceCard({
    super.key,
    required this.balance,
    this.currency = 'USD',
    this.maskedCard = '**** **** **** 4291',
    this.monthlySpending = 1240,
    this.spendingLimit = 5000,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _balanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? AppColorsDark.balanceGradient
        : AppColors.balanceGradient;
    final progress = (widget.monthlySpending / widget.spendingLimit).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(77),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.totalBalance,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      _balanceVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _balanceVisible = !_balanceVisible),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ── Balance amount ────────────────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _balanceVisible
                    ? Text(
                        key: const ValueKey('visible'),
                        '${widget.currency} ${_formatAmount(widget.balance)}',
                        style: AppTextStyles.heading1.copyWith(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    : Text(
                        key: const ValueKey('hidden'),
                        '${widget.currency} ••••••',
                        style: AppTextStyles.heading1.copyWith(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // ── Spending progress ─────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.monthlySpending,
                    style: AppTextStyles.caption.copyWith(color: Colors.white70),
                  ),
                  Text(
                    '${widget.currency} ${_formatAmount(widget.monthlySpending)} / ${_formatAmount(widget.spendingLimit)}',
                    style: AppTextStyles.caption.copyWith(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress > 0.8 ? Colors.orangeAccent : Colors.white,
                  ),
                  minHeight: 6,
                ),
              ),

              const SizedBox(height: 20),

              // ── Card number row ───────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.maskedCard,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                  const Icon(Icons.credit_card, color: Colors.white54, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(2);
  }
}
