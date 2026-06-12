import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/goal.dart';
import '../models/health_score.dart';
import '../models/journey.dart';
import '../models/life_event.dart';
import '../models/recommendation.dart';
import 'demo_data_service.dart';
import 'demo_feed_service.dart';

/// The Compass Journey is a privacy-safe *projection* of data the app
/// already holds (goals, score history, life events, recommendations).
/// Because every source passed the privacy chokepoint upstream, the
/// journey can never contain raw financial data by construction.
final journeyProvider = FutureProvider<JourneyData>((ref) async {
  final goals = ref.watch(demoGoalsProvider);
  final score = ref.watch(healthScoreProvider);
  final events = ref.watch(lifeEventsProvider);
  final recommendations = ref.watch(recommendationsProvider);
  // Brief assembly delay so the screen shows a smooth loading state.
  await Future<void>.delayed(const Duration(milliseconds: 250));
  return buildJourney(
    goals: goals,
    score: score,
    events: events,
    recommendations: recommendations,
    now: DateTime.now(),
  );
});

/// Pure assembly function — deterministic and easily testable.
JourneyData buildJourney({
  required List<Goal> goals,
  required HealthScore score,
  required List<LifeEvent> events,
  required List<Recommendation> recommendations,
  required DateTime now,
}) {
  final moments = <JourneyMoment>[];

  // Goal milestones (progress percentages only).
  var goalOffset = 3;
  for (final goal in goals) {
    final reached = goal.reachedMilestones;
    if (reached.isEmpty) continue;
    final top = reached.last;
    moments.add(JourneyMoment(
      id: 'jm-goal-${goal.id}-$top',
      type: JourneyMomentType.goalMilestone,
      title: 'Reached $top% of "${goal.name}"',
      descriptionSafe:
          'Milestone unlocked from progress percentage only — never amounts.',
      timestamp: now.subtract(Duration(days: goalOffset)),
    ));
    goalOffset += 11;
  }

  // Month-over-month health score changes.
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
      descriptionSafe:
          '${delta > 0 ? '+' : ''}$delta points — calculated from behavioral patterns only.',
      timestamp: DateTime(now.year, now.month - monthsAgo, 8),
    ));
  }

  // Life-event detections (already pattern-level).
  for (final event in events) {
    moments.add(JourneyMoment(
      id: 'jm-ev-${event.id}',
      type: JourneyMomentType.lifeEvent,
      title: event.title,
      descriptionSafe: event.descriptionSafe,
      timestamp: event.detectedAt,
    ));
  }

  // Recommendations the AI prepared.
  var recOffset = 2;
  for (final rec in recommendations.take(3)) {
    moments.add(JourneyMoment(
      id: 'jm-rec-${rec.id}',
      type: JourneyMomentType.recommendation,
      title: 'Suggestion prepared: ${rec.title}',
      descriptionSafe: rec.reason,
      timestamp: now.subtract(Duration(days: recOffset)),
    ));
    recOffset += 9;
  }

  // Savings consistency streak.
  moments.add(JourneyMoment(
    id: 'jm-streak',
    type: JourneyMomentType.savingsStreak,
    title: '3-month savings consistency streak',
    descriptionSafe:
        'Detected from the savings_consistency_improved signal — no amounts read.',
    timestamp: now.subtract(const Duration(days: 5)),
  ));

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
        summary: _summarize(entry.value),
        moments: entry.value,
      ),
  ];

  final badges = [
    const JourneyBadge(
      id: 'consistent_saver',
      label: 'Consistent Saver',
      description: 'Savings consistency improved',
      earned: true,
    ),
    JourneyBadge(
      id: 'goal_getter',
      label: 'Goal Getter',
      description: 'A goal passed 75%',
      earned: goals.any((g) => g.progressPercent >= 75),
    ),
    JourneyBadge(
      id: 'health_improver',
      label: 'Health Improver',
      description: 'Score up 5+ points over 6 months',
      earned: history.length >= 2 && history.last - history.first >= 5,
    ),
    JourneyBadge(
      id: 'explorer',
      label: 'Explorer',
      description: 'A travel event was detected',
      earned: events.any((e) => e.type == 'travel'),
    ),
  ];

  return JourneyData(badges: badges, months: months);
}

String _summarize(List<JourneyMoment> moments) {
  final milestones =
      moments.where((m) => m.type == JourneyMomentType.goalMilestone).length;
  if (milestones > 0) {
    return '${moments.length} highlights · $milestones goal milestone${milestones == 1 ? '' : 's'}';
  }
  return '${moments.length} highlight${moments.length == 1 ? '' : 's'}';
}
