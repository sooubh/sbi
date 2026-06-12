import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/greeting.dart';
import '../../services/demo_catalog.dart';
import '../../services/demo_data_service.dart';
import '../../widgets/section_header.dart';
import '../shell/main_shell.dart';
import 'widgets/account_summary_card.dart';
import 'widgets/compass_insight_card.dart';
import 'widgets/goal_preview_card.dart';
import 'widgets/quick_actions_row.dart';

/// Home Dashboard (PRD Screen 3): account summary, Compass Insight Card,
/// quick actions and goal progress preview.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(demoGoalsProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Insets.m),
          children: [
            _GreetingHeader(
              onBellTap: () => ref.read(shellIndexProvider.notifier).state =
                  ShellTab.timeline.index,
            ),
            const SizedBox(height: Insets.m),
            const AccountSummaryCard(),
            const SizedBox(height: Insets.m),
            const CompassInsightCard(),
            const SizedBox(height: Insets.s),
            const SectionHeader(title: 'Quick actions'),
            const QuickActionsRow(),
            const SizedBox(height: Insets.m),
            SectionHeader(
              title: 'Goal progress',
              actionLabel: 'View all',
              onAction: () => ref.read(shellIndexProvider.notifier).state =
                  ShellTab.goals.index,
            ),
            for (final goal in goals.take(2)) ...[
              GoalPreviewCard(goal: goal),
              const SizedBox(height: Insets.s + 4),
            ],
          ],
        ),
      ),
    );
  }
}

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader({required this.onBellTap});

  final VoidCallback onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.lightBlue,
          child: Text(DemoProfile.initials,
              style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.deepBlue)),
        ),
        const SizedBox(width: Insets.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greetingForNow(),
                  style: const TextStyle(fontSize: 13, color: AppColors.slate)),
              const Text(DemoProfile.firstName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink)),
            ],
          ),
        ),
        IconButton(
          tooltip: 'AI activity',
          onPressed: onBellTap,
          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.ink),
        ),
      ],
    );
  }
}
