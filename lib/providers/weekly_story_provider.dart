import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';

import '../data/database/collections/weekly_story.dart';
import '../data/database/collections/safe_signal.dart';
import '../data/database/isar_service.dart';
import '../domain/models/weekly_story.dart';
import '../domain/services/ai_service.dart';
import '../services/persona.dart';
import 'goals_provider.dart';
import 'health_score_provider.dart';

final weeklyStoryStateProvider = FutureProvider<WeeklyStory>((ref) async {
  final isar = ref.watch(isarServiceProvider).db;
  final goals = ref.watch(goalListProvider);
  final persona = ref.watch(personaProvider);
  final aiService = ref.watch(aiServiceProvider);
  
  // Wait for health score to be computed
  final healthScore = await ref.watch(healthScoreStateProvider.future);

  final now = DateTime.now();
  final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));
  final fmt = DateFormat('d MMM');
  final weekLabel = '${fmt.format(startOfWeek)} – ${fmt.format(endOfWeek)}';

  // 1. Check if story already exists in Isar
  var story = await isar.weeklyStoryCollections
      .filter()
      .weekStartDateEqualTo(startOfWeek)
      .findFirst();

  if (story == null) {
    // 2. Load recent signals from Isar (last 7 days)
    final lastWeekSignals = await isar.safeSignalCollections
        .filter()
        .timestampGreaterThan(now.subtract(const Duration(days: 7)))
        .findAll();

    final hasSavingsStreak = lastWeekSignals.any((s) => s.type == 'savings_consistency_improved');
    final topGoal = goals.isNotEmpty 
        ? goals.reduce((a, b) => a.progressPercent >= b.progressPercent ? a : b)
        : null;

    final topGoalName = topGoal?.name ?? 'Emergency Fund';
    final topGoalProgress = topGoal?.progressPercent ?? 0;

    // 3. Generate narrative using local AI
    final bodyText = await aiService.generateWeeklyStoryNarrative(
      firstName: persona.firstName,
      healthDelta: healthScore.trendDelta,
      finalScore: healthScore.total,
      topGoalName: topGoalName,
      topGoalProgress: topGoalProgress,
      hasSavingsStreak: hasSavingsStreak,
      streakDays: 14, // Hackathon default streak info
    );

    final headline = '${persona.firstName}\'s Weekly Recap';
    final summary = 'Your health score is at ${healthScore.total}. Emergency Fund is on pace.';

    // 4. Save to Isar
    story = WeeklyStoryCollection()
      ..storyId = 'story-${startOfWeek.millisecondsSinceEpoch}'
      ..weekStartDate = startOfWeek
      ..headline = headline
      ..bodyText = bodyText
      ..summary = summary
      ..healthScoreDelta = healthScore.trendDelta
      ..topGoalProgress = '$topGoalProgress%'
      ..streakInfo = '14-day streak'
      ..generatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.weeklyStoryCollections.put(story!);
    });
  }

  // 5. Build presentation slides
  return WeeklyStory(
    weekLabel: weekLabel,
    slides: [
      StorySlide(
        kicker: 'YOUR WEEK IN REVIEW',
        headline: story.headline,
        detail: story.summary,
      ),
      StorySlide(
        kicker: 'FINANCIAL HEALTH',
        statValue: story.healthScoreDelta >= 0 ? '+${story.healthScoreDelta}' : '${story.healthScoreDelta}',
        headline: 'Your health score is ${healthScore.total}',
        detail: 'Savings consistency and goal progress pushed your score up this month.',
        signal: 'health_score_changed',
      ),
      StorySlide(
        kicker: 'GOAL COACH',
        statValue: story.topGoalProgress,
        headline: 'Emergency Fund is ahead of pace',
        detail: story.bodyText,
        signal: 'goal_progress',
      ),
      StorySlide(
        kicker: 'SAVINGS STREAK',
        statValue: '14 Days',
        headline: story.streakInfo,
        detail: 'You kept your savings streak alive. Real habits build real wealth!',
        signal: 'streak_created',
      ),
      const StorySlide(
        kicker: 'PRIVACY TRANSPARENCY',
        headline: '100% Private & Local',
        detail: 'None of this recap required sharing your transactions or balances. All inference runs offline.',
      ),
    ],
  );
});
