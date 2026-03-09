import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fintech_app/l10n/generated/app_localizations.dart';
import 'package:fintech_app/core/navigation/app_routes.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.transactions)) return 1;
    if (location.startsWith(AppRoutes.wallet))       return 2;
    if (location.startsWith(AppRoutes.profile))      return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(AppRoutes.home);
      case 1: context.go(AppRoutes.transactions);
      case 2: context.go(AppRoutes.wallet);
      case 3: context.go(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final index = _currentIndex(context);

    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (i) => _onTap(context, i),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: l10n.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.receipt_long_outlined),
          selectedIcon: const Icon(Icons.receipt_long),
          label: l10n.transactions,
        ),
        NavigationDestination(
          icon: const Icon(Icons.account_balance_wallet_outlined),
          selectedIcon: const Icon(Icons.account_balance_wallet),
          label: l10n.wallet,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }
}
