import 'package:flutter/material.dart';

import '../widgets/home_hub_card.dart';
import '../widgets/home_insurance_banner.dart';
import '../widgets/home_notifications_card.dart';
import '../widgets/home_quick_actions.dart';
import '../widgets/home_rewards_row.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_section_label.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: HomeSearchBar()),
            const SliverToBoxAdapter(child: HomeQuickActions()),
            const SliverToBoxAdapter(child: HomeSectionLabel('Financial Hub')),
            SliverToBoxAdapter(child: HomeHubCard(items: financialHubItems)),
            const SliverToBoxAdapter(child: HomeSectionLabel('Convenient Hub')),
            SliverToBoxAdapter(child: HomeHubCard(items: convenientHubItems)),
            const SliverToBoxAdapter(child: HomeSectionLabel('Service Hub')),
            const SliverToBoxAdapter(child: HomeNotificationsCard()),
            const SliverToBoxAdapter(child: HomeInsuranceBanner()),
            const SliverToBoxAdapter(child: HomeSectionLabel('Rewards Hub')),
            const SliverToBoxAdapter(child: HomeRewardsRow()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
