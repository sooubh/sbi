import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/greeting.dart';
import '../../services/demo_data_service.dart';
import '../../services/persona.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../shell/main_shell.dart';
import '../story/weekly_story_screen.dart';
import 'widgets/account_summary_card.dart';
import 'widgets/compass_insight_card.dart';
import 'widgets/goal_preview_card.dart';
import 'widgets/quick_actions_row.dart';

/// Home Dashboard (PRD Screen 3): account summary, Compass Insight Card,
/// weekly story entry, quick actions and goal progress preview.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(demoGoalsProvider);
    final persona = ref.watch(personaProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Insets.m),
          children: [
            _GreetingHeader(
              persona: persona,
              onBellTap: () => ref.read(shellIndexProvider.notifier).state =
                  ShellTab.timeline.index,
            ),
            const SizedBox(height: Insets.m),
            const AccountSummaryCard(),
            const SizedBox(height: Insets.m),
            const CompassInsightCard(),
            const SizedBox(height: Insets.s + 4),
            AppCard(
              color: AppColors.lightBlue,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const WeeklyStoryScreen(),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: AppColors.deepBlue, shape: BoxShape.circle),
                    child: const Icon(Icons.auto_stories_rounded, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: Insets.m),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Weekly Story is ready',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.deepBlue)),
                        SizedBox(height: 2),
                        Text('Score, goals and streaks — a 30-second recap.',
                            style: TextStyle(fontSize: 12, color: AppColors.slate)),
                      ],
                    ),
                  ),
                  const Icon(Icons.play_arrow_rounded, color: AppColors.deepBlue),
                ],
              ),
            ),
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
  const _GreetingHeader({required this.persona, required this.onBellTap});

  final DemoPersona persona;
  final VoidCallback onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.lightBlue,
          child: Text(persona.initials,
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.deepBlue)),
        ),
        const SizedBox(width: Insets.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greetingForNow(),
                  style: const TextStyle(fontSize: 13, color: AppColors.slate)),
              Text(persona.firstName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink)),
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
