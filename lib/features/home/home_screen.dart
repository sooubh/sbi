import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/greeting.dart';
import '../../core/utils/goal_icons.dart';
import '../../domain/models/goal.dart';
import '../../providers/goals_provider.dart';
import '../../providers/health_score_provider.dart';
import '../../providers/achievements_provider.dart';
import '../../providers/journey_events_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/staggered_item.dart';
import '../../services/persona.dart';
import '../story/weekly_story_screen.dart';
import 'widgets/account_summary_card.dart';
import 'widgets/compass_insight_card.dart';
import 'widgets/quick_actions_row.dart';

/// Home Dashboard (PRD Screen 3 & Section 8.3 layout):
/// 1. Greeting
/// 2. Primary Goal Card (progress + AI coaching message)
/// 3. Compass Insight Card (today's AI insight)
/// 4. Weekly Story Banner (tap to read)
/// 5. Financial Health Score (compact view)
/// 6. Quick Actions Row
/// 7. Recent Achievements
/// 8. Recent Journey Events (last 3)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalListProvider);
    final persona = ref.watch(personaProvider);
    final healthAsync = ref.watch(healthScoreStateProvider);
    final achievements = ref.watch(achievementsStateProvider);
    final journeyEvents = ref.watch(journeyEventsProvider);

    // Find primary goal, or first active goal, or fallback to first goal
    final primaryGoal = goals.isNotEmpty 
        ? (goals.firstWhere((g) => g.status == 'active', orElse: () => goals.first))
        : null;

    final unlockedAchievements = achievements.where((a) => a.isUnlocked).toList();
    final recentEvents = journeyEvents.take(3).toList();

    var stagger = 0;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Insets.m),
          children: [
            StaggeredItem(
              index: stagger++,
              child: _GreetingHeader(
                persona: persona,
                onBellTap: () {
                  // Switch to Timeline Tab
                  context.go('/timeline');
                },
              ),
            ),
            const SizedBox(height: Insets.m),

            // 1. Account Summary Card (Legacy support)
            StaggeredItem(
              index: stagger++,
              child: const AccountSummaryCard(),
            ),
            const SizedBox(height: Insets.m),

            // 2. Primary Goal Card
            if (primaryGoal != null) ...[
              StaggeredItem(
                index: stagger++,
                child: _PrimaryGoalCard(goal: primaryGoal),
              ),
              const SizedBox(height: Insets.m),
            ],

            // 3. Compass Insight Card
            StaggeredItem(
              index: stagger++,
              child: const CompassInsightCard(),
            ),
            const SizedBox(height: Insets.m),

            // 4. Weekly Story Banner
            StaggeredItem(
              index: stagger++,
              child: AppCard(
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
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
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
            ),
            const SizedBox(height: Insets.m),

            // 5. Financial Health Score (Compact View)
            StaggeredItem(
              index: stagger++,
              child: healthAsync.when(
                loading: () => const AppCard(child: Center(child: CircularProgressIndicator())),
                error: (_, __) => const AppCard(child: Text('Error loading health score')),
                data: (health) => AppCard(
                  onTap: () {
                    // Navigate to Compass screen (branch 1)
                    context.go('/compass');
                  },
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Financial Health',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.slate)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('${health.total}',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.ink)),
                              const Text(' / 100',
                                  style: TextStyle(fontSize: 14, color: AppColors.slate)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: health.trendDelta >= 0 ? AppColors.successBg : AppColors.warningBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              health.trendDelta >= 0 ? '▲ +${health.trendDelta} This Month' : '▼ ${health.trendDelta} This Month',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: health.trendDelta >= 0 ? AppColors.success : AppColors.warning,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Good Standing',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.success)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: Insets.m),

            // 6. Quick Actions Row
            StaggeredItem(
              index: stagger++,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Quick actions'),
                  QuickActionsRow(),
                ],
              ),
            ),
            const SizedBox(height: Insets.m),

            // 7. Recent Achievements
            if (unlockedAchievements.isNotEmpty) ...[
              StaggeredItem(
                index: stagger++,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: 'Recent Achievements'),
                    SizedBox(
                      height: 52,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: unlockedAchievements.length,
                        separatorBuilder: (_, __) => const SizedBox(width: Insets.s),
                        itemBuilder: (context, index) {
                          final badge = unlockedAchievements[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.successBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.success),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.emoji_events_rounded, size: 16, color: AppColors.success),
                                const SizedBox(width: 6),
                                Text(badge.title,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.success)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Insets.m),
            ],

            // 8. Recent Journey Events
            if (recentEvents.isNotEmpty) ...[
              StaggeredItem(
                index: stagger++,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Recent Highlights',
                      actionLabel: 'View Journey',
                      onAction: () {
                        // Switch to Journey (branch 3 or timeline)
                        context.go('/timeline');
                      },
                    ),
                    for (final event in recentEvents) ...[
                      AppCard(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.lightBlue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                event.eventType.contains('travel')
                                    ? Icons.flight_takeoff_rounded
                                    : event.eventType.contains('income')
                                        ? Icons.payments_rounded
                                        : Icons.explore_rounded,
                                size: 18,
                                color: AppColors.deepBlue,
                              ),
                            ),
                            const SizedBox(width: Insets.m),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event.title,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.ink)),
                                  const SizedBox(height: 2),
                                  Text(event.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12, color: AppColors.slate)),
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('d MMM').format(event.timestamp),
                              style: const TextStyle(fontSize: 11, color: AppColors.slate),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Insets.s),
                    ],
                  ],
                ),
              ),
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
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.blue)),
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

class _PrimaryGoalCard extends StatelessWidget {
  const _PrimaryGoalCard({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(goalIcon(goal.category), size: 18, color: AppColors.blue),
              const SizedBox(width: Insets.s),
              Expanded(
                child: Text('Primary Goal: ${goal.name}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)),
              ),
              Text('${goal.progressPercent}%',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.blue)),
            ],
          ),
          const SizedBox(height: Insets.s + 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: goal.progressPercent / 100,
              minHeight: 6,
              backgroundColor: AppColors.lightBlue,
              color: AppColors.blue,
            ),
          ),
          if (goal.aiNudge != null) ...[
            const SizedBox(height: Insets.m),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.auto_awesome_rounded, size: 14, color: AppColors.blue),
                const SizedBox(width: Insets.s),
                Expanded(
                  child: Text(
                    goal.aiNudge!,
                    style: const TextStyle(fontSize: 12.5, height: 1.4, color: AppColors.slate, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
