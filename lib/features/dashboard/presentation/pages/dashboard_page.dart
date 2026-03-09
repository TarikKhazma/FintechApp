import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/core/constants/app_colors.dart';
import 'package:fintech_app/core/constants/app_text_styles.dart';
import 'package:fintech_app/core/theme/theme_cubit.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintech_app/l10n/generated/app_localizations.dart';
import 'package:fintech_app/shared/widgets/app_bottom_nav.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/transaction_tile.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoints
        if (constraints.maxWidth >= 900) {
          return _LargeLayout(maxWidth: constraints.maxWidth);
        }
        return const _MobileLayout();
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile layout (< 900px)
// ─────────────────────────────────────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _HeaderSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(
              child: BalanceCard(balance: 12480.50),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
            const SliverToBoxAdapter(child: QuickActionsRow()),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
            SliverToBoxAdapter(child: _SectionHeader()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => TransactionTile(
                    item: sampleTransactions[i],
                    onTap: () {},
                  ),
                  childCount: sampleTransactions.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Large layout (>= 900px) — sidebar navigation
// ─────────────────────────────────────────────────────────────────────────────
class _LargeLayout extends StatelessWidget {
  final double maxWidth;
  const _LargeLayout({required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sidebarBg = isDark ? AppColorsDark.surface : AppColors.surface;

    return Scaffold(
      body: Row(
        children: [
          // ── Sidebar ──────────────────────────────────────────────────
          Container(
            width: 220,
            color: sidebarBg,
            child: const _Sidebar(),
          ),
          // ── Main content ─────────────────────────────────────────────
          Expanded(
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _HeaderSection()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  // 2-column grid on large screens
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.8,
                      ),
                      delegate: SliverChildListDelegate([
                        const BalanceCard(balance: 12480.50),
                        const _StatsCard(),
                      ]),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 28)),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: QuickActionsRow(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 28)),
                  SliverToBoxAdapter(child: _SectionHeader()),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => TransactionTile(
                          item: sampleTransactions[i],
                          onTap: () {},
                        ),
                        childCount: sampleTransactions.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared section widgets
// ─────────────────────────────────────────────────────────────────────────────
class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = context.watch<AuthBloc>().state.user;
    final name = user?.fullName ?? user?.email.split('@').first ?? 'User';
    final greeting = _greeting(l10n);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: AppTextStyles.heading2.copyWith(
                  color: isDark
                      ? AppColorsDark.textPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),

          // Action buttons
          Row(
            children: [
              // Dark mode toggle
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, mode) => IconButton(
                  onPressed: context.read<ThemeCubit>().toggle,
                  icon: Icon(
                    mode == ThemeMode.dark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: isDark
                        ? AppColorsDark.textPrimary
                        : AppColors.textPrimary,
                  ),
                  tooltip: l10n.darkMode,
                ),
              ),
              // Notifications
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColors.textPrimary,
                    ),
                    tooltip: l10n.notifications,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              // Avatar
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryBg,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }
}

class _SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.recentTransactions,
            style: AppTextStyles.heading3.copyWith(
              color:
                  isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              l10n.seeAll,
              style: AppTextStyles.body.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Stats summary card used only on the large (tablet/desktop) layout.
class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor =
        isDark ? AppColorsDark.surface : AppColors.surface;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Monthly Summary',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark
                  ? AppColorsDark.textSecondary
                  : AppColors.textSecondary,
            ),
          ),
          Row(
            children: [
              _StatBadge(
                label: 'Income',
                amount: '+\$5,200',
                color: AppColors.success,
                icon: Icons.arrow_downward_rounded,
              ),
              const SizedBox(width: 16),
              _StatBadge(
                label: 'Expense',
                amount: '-\$1,240',
                color: AppColors.error,
                icon: Icons.arrow_upward_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;
  final IconData icon;

  const _StatBadge({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withAlpha(31),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary)),
            Text(amount,
                style: AppTextStyles.bodySmall.copyWith(
                    color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sidebar for large layout
// ─────────────────────────────────────────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navItems = [
      _SidebarItem(icon: Icons.home_rounded, label: l10n.home, active: true),
      _SidebarItem(icon: Icons.receipt_long_rounded, label: l10n.transactions),
      _SidebarItem(icon: Icons.account_balance_wallet_rounded, label: l10n.wallet),
      _SidebarItem(icon: Icons.person_rounded, label: l10n.profile),
      _SidebarItem(icon: Icons.settings_rounded, label: l10n.settings),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet,
                      color: AppColors.primary, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    l10n.appTitle,
                    style: AppTextStyles.heading3.copyWith(
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Nav items
            ...navItems.map((item) => _SidebarNavItem(item: item)),

            const Spacer(),

            // Theme toggle
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) {
                return _SidebarNavItem(
                  item: _SidebarItem(
                    icon: mode == ThemeMode.dark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    label: l10n.darkMode,
                  ),
                  onTap: context.read<ThemeCubit>().toggle,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem {
  final IconData icon;
  final String label;
  final bool active;
  const _SidebarItem({
    required this.icon,
    required this.label,
    this.active = false,
  });
}

class _SidebarNavItem extends StatelessWidget {
  final _SidebarItem item;
  final VoidCallback? onTap;

  const _SidebarNavItem({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = AppColors.primary;
    final inactiveColor = isDark
        ? AppColorsDark.textSecondary
        : AppColors.textSecondary;
    final activeBg = isDark
        ? AppColorsDark.primaryBg
        : AppColors.primaryBg;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: item.active ? activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 20,
                color: item.active ? activeColor : inactiveColor,
              ),
              const SizedBox(width: 12),
              Text(
                item.label,
                style: AppTextStyles.body.copyWith(
                  color: item.active ? activeColor : inactiveColor,
                  fontWeight:
                      item.active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
