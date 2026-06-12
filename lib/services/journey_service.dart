import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/models/journey.dart';
import '../providers/achievements_provider.dart';
import '../providers/goals_provider.dart';
import '../providers/journey_events_provider.dart';
import 'demo_feed_service.dart';

final journeyProvider = FutureProvider<JourneyData>((ref) async {
  final goals = ref.watch(goalListProvider);
  final score = ref.watch(healthScoreProvider);
  final events = ref.watch(journeyEventsProvider);
  final achievements = ref.watch(achievementsStateProvider);

  await Future<void>.delayed(const Duration(milliseconds: 100));

  final moments = <JourneyMoment>[];

  // 1. Goal milestones (progress percentages only).
  for (final goal in goals) {
    final reached = goal.reachedMilestones;
    if (reached.isEmpty) continue;
    final top = reached.last;
    moments.add(JourneyMoment(
      id: 'jm-goal-${goal.id}-$top',
      type: JourneyMomentType.goalMilestone,
      title: 'Reached $top% of "${goal.name}"',
      descriptionSafe: 'Milestone unlocked from progress percentage only — never amounts.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ));
  }

  // 2. Journey events from Isar
  for (final event in events) {
    moments.add(JourneyMoment(
      id: 'jm-ev-${event.id}',
      type: event.eventType == 'goal_created' 
          ? JourneyMomentType.goalMilestone 
          : event.eventType == 'achievement_unlocked' 
              ? JourneyMomentType.savingsStreak 
              : JourneyMomentType.lifeEvent,
      title: event.title,
      descriptionSafe: event.description,
      timestamp: event.timestamp,
    ));
  }

  // 3. Month-over-month health score changes.
  final history = score.history;
  for (var i = history.length - 1; i >= 1; i--) {
    final delta = history[i] - history[i - 1];
    if (delta == 0) continue;
    final monthsAgo = history.length - 1 - i;
    moments.add(JourneyMoment(
      id: 'jm-score-$i',
      type: JourneyMomentType.scoreChange,
      title: delta > 0
          ? 'Health score rose to ${history[i]}'
          : 'Health score dipped to ${history[i]}',
      descriptionSafe: '${delta > 0 ? '+' : ''}$delta points — calculated from behavioral patterns only.',
      timestamp: DateTime.now().subtract(Duration(days: monthsAgo * 30 + 8)),
    ));
  }

  moments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

  // Group into months, newest first, each with a summary line.
  final formatter = DateFormat('MMMM yyyy');
  final grouped = <String, List<JourneyMoment>>{};
  for (final moment in moments) {
    grouped.putIfAbsent(formatter.format(moment.timestamp), () => []).add(moment);
  }
  
  final months = [
    for (final entry in grouped.entries)
      JourneyMonth(
        label: entry.key,
        summary: '${entry.value.length} highlights',
        moments: entry.value,
      ),
  ];

  final badges = achievements.map((a) => JourneyBadge(
    id: a.key,
    label: a.title,
    description: a.description,
    earned: a.isUnlocked,
  )).toList();

  return JourneyData(badges: badges, months: months);
});
