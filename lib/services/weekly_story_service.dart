import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/weekly_story.dart';
import 'demo_data_service.dart';
import 'demo_feed_service.dart';
import 'journey_service.dart';
import 'persona.dart';

/// The Weekly Story is a projection of providers that already hold only
/// privacy-safe data (score points, progress percentages, badges), so it
/// cannot contain raw financial data by construction.
final weeklyStoryProvider = FutureProvider<WeeklyStory>((ref) async {
  final score = ref.watch(healthScoreProvider);
  final goals = ref.watch(demoGoalsProvider);
  final persona = ref.watch(personaProvider);
  final journey = await ref.watch(journeyProvider.future);
  await Future<void>.delayed(const Duration(milliseconds: 200));

  final now = DateTime.now();
  final start = now.subtract(Duration(days: now.weekday - 1));
  final end = start.add(const Duration(days: 6));
  final fmt = DateFormat('d MMM');
  final weekLabel = '${fmt.format(start)} – ${fmt.format(end)}';

  final top = goals.isEmpty
      ? null
      : goals.reduce((a, b) => a.progressPercent >= b.progressPercent ? a : b);
  final earned = journey.badges.where((b) => b.earned).toList();

  return WeeklyStory(
    weekLabel: weekLabel,
    slides: [
      StorySlide(
        kicker: 'YOUR WEEK WITH COMPASS',
        headline: "Here's your week, ${persona.firstName}",
        detail:
            'A 30-second story of your financial behavior — told from safe signals only.',
      ),
      StorySlide(
        kicker: 'FINANCIAL HEALTH',
        statValue: '+${score.trendDelta}',
        headline: 'Your health score climbed to ${score.total}',
        detail:
            'Savings consistency and goal progress pushed your score up this month.',
        signal: 'score_trend_positive',
      ),
      if (top != null)
        StorySlide(
          kicker: 'GOALS',
          statValue: '${top.progressPercent}%',
          headline: '"${top.name}" is your front-runner',
          detail: top.aiNudge ?? 'Steady pace — keep the routine going.',
          signal: 'goal_progress',
        ),
      const StorySlide(
        kicker: 'CONSISTENCY',
        statValue: '3',
        headline: 'Months of savings consistency',
        detail:
            'Your savings rhythm held for a third straight month. Quiet wins compound.',
        signal: 'savings_consistency_improved',
      ),
      StorySlide(
        kicker: 'ACHIEVEMENTS',
        statValue: '${earned.length}',
        headline: 'Badges in your collection',
        detail: earned.isEmpty
            ? 'Your first badge is close — keep going.'
            : earned.map((b) => b.label).join(' · '),
      ),
      const StorySlide(
        kicker: 'PRIVACY',
        headline: 'All of this, without reading your transactions',
        detail:
            'Compass saw only behavioral signals this week. Your balances, accounts and transactions stayed private.',
      ),
    ],
  );
});
