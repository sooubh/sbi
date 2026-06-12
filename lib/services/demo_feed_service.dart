import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/health_score.dart';
import '../models/insight.dart';
import '../models/life_event.dart';
import '../models/recommendation.dart';
import '../models/timeline_entry.dart';
import 'user_settings.dart';

/// Demo feeds for Phase 2 screens (PRD section 12). Provider shapes match
/// the Firestore documents that replace them in Phase 3.

final healthScoreProvider = Provider<HealthScore>((ref) {
  return const HealthScore(
    total: 84,
    trendDelta: 5,
    sections: [
      HealthScoreSection(name: 'Savings', score: 88),
      HealthScoreSection(name: 'Spending', score: 76),
      HealthScoreSection(name: 'Goals', score: 81),
      HealthScoreSection(name: 'Consistency', score: 90),
      HealthScoreSection(name: 'Stability', score: 85),
    ],
    aiExplanation:
        'Your score improved because savings consistency and goal progress '
        'trended up this month, while spending stayed within its usual range. '
        'This score is calculated only from behavioral patterns — never from '
        'raw amounts or transactions.',
  );
});

final insightsFeedProvider = Provider<List<Insight>>((ref) {
  return const [
    Insight(
      id: 'feed-1',
      title: 'Food spending is trending up',
      body: 'Food-related spending is higher than usual this month.',
      recommendation: 'Set a weekly spending limit for the food category.',
      reason:
          'Generated from the spending_up_in_food_category signal — only the '
          'category trend was shared, no amounts or merchants.',
      confidence: 0.84,
      signalType: 'spending_up_in_food_category',
    ),
    Insight(
      id: 'feed-2',
      title: 'A bill is due soon',
      body: 'An upcoming bill pattern was detected for this week.',
      recommendation: 'Enable a bill reminder so it is never missed.',
      reason:
          'Generated from the bill_due_soon signal. The biller name and '
          'amount were never shared with the AI.',
      confidence: 0.91,
      signalType: 'bill_due_soon',
    ),
    Insight(
      id: 'feed-3',
      title: 'A travel-related event was detected',
      body: 'Recent activity suggests an upcoming trip.',
      recommendation: 'Consider setting a short-term trip budget.',
      reason:
          'Generated from the travel_event_detected signal — a behavioral '
          'pattern only, with no booking details.',
      confidence: 0.78,
      signalType: 'travel_event_detected',
    ),
  ];
});

/// Life events respect the user's event-tracking permission (Feature 8).
final lifeEventsProvider = Provider<List<LifeEvent>>((ref) {
  if (!ref.watch(userSettingsProvider).eventTracking) return const [];
  final now = DateTime.now();
  return [
    LifeEvent(
      id: 'ev-1',
      type: 'travel',
      title: 'Travel event detected',
      descriptionSafe:
          'A travel-related spending pattern was detected. No booking details, '
          'destinations or amounts were read.',
      nextAction: 'Set up a short-term trip budget to keep goals on track.',
      detectedAt: now.subtract(const Duration(days: 2)),
    ),
    LifeEvent(
      id: 'ev-2',
      type: 'salary',
      title: 'Income pattern detected',
      descriptionSafe:
          'A recurring income-type pattern was identified. The exact value is '
          'never shared with the AI.',
      nextAction: 'Consider automating a savings transfer right after income arrives.',
      detectedAt: now.subtract(const Duration(days: 6)),
    ),
    LifeEvent(
      id: 'ev-3',
      type: 'overspending',
      title: 'Spending pattern changed',
      descriptionSafe:
          'Spending in the food category rose above its usual range this month.',
      nextAction: 'Review the food category and set a weekly limit.',
      detectedAt: now.subtract(const Duration(days: 9)),
    ),
  ];
});

class RecommendationsNotifier extends Notifier<List<Recommendation>> {
  @override
  List<Recommendation> build() => const [
        Recommendation(
          id: 'rec-1',
          title: 'Build your emergency fund',
          reason: 'Your savings consistency improved — a good moment to grow your buffer.',
          actionLabel: 'Boost fund',
        ),
        Recommendation(
          id: 'rec-2',
          title: 'Reduce spending in the food category',
          reason: 'Food spending trended above its usual range this month.',
          actionLabel: 'Set limit',
        ),
        Recommendation(
          id: 'rec-3',
          title: 'Set up bill reminders',
          reason: 'A bill-due-soon pattern was detected for this week.',
          actionLabel: 'Enable reminders',
        ),
        Recommendation(
          id: 'rec-4',
          title: 'Increase your monthly savings target',
          reason: 'You have beaten your current target three months in a row.',
          actionLabel: 'Raise target',
        ),
        Recommendation(
          id: 'rec-5',
          title: 'Review unused subscriptions',
          reason: 'A recurring low-engagement subscription pattern was detected.',
          actionLabel: 'Review now',
        ),
      ];

  void setStatus(String id, RecommendationStatus status) {
    state = [
      for (final rec in state)
        if (rec.id == id) rec.copyWith(status: status) else rec,
    ];
  }
}

final recommendationsProvider =
    NotifierProvider<RecommendationsNotifier, List<Recommendation>>(
  RecommendationsNotifier.new,
);

final timelineProvider = Provider<List<TimelineEntry>>((ref) {
  final now = DateTime.now();
  return [
    TimelineEntry(
      id: 't-1',
      eventType: 'goal_review',
      message: 'Goal review completed',
      explainNote:
          'All active goals were reviewed against their expected pace. Two are '
          'on track; one received a nudge. Only progress percentages were analyzed.',
      createdAt: now.subtract(const Duration(hours: 3)),
    ),
    TimelineEntry(
      id: 't-2',
      eventType: 'budget_recommendation',
      message: 'Budget recommendation prepared',
      explainNote:
          'A weekly food-category limit was suggested after the category trend '
          'rose above its usual range. No amounts or merchants were read.',
      createdAt: now.subtract(const Duration(days: 1)),
    ),
    TimelineEntry(
      id: 't-3',
      eventType: 'travel_event',
      message: 'Travel event identified',
      explainNote:
          'A travel-related behavioral pattern was classified from safe signals. '
          'Booking details were never accessed.',
      createdAt: now.subtract(const Duration(days: 2)),
    ),
    TimelineEntry(
      id: 't-4',
      eventType: 'savings_suggestion',
      message: 'Savings suggestion generated',
      explainNote:
          'Because savings consistency improved, a small auto-save increase was '
          'suggested. Derived from the savings_consistency_improved signal.',
      createdAt: now.subtract(const Duration(days: 4)),
    ),
    TimelineEntry(
      id: 't-5',
      eventType: 'bill_reminder',
      message: 'Bill reminder noted',
      explainNote:
          'A bill-due-soon pattern was detected and queued as a reminder. The '
          'biller and amount stayed private.',
      createdAt: now.subtract(const Duration(days: 5)),
    ),
    TimelineEntry(
      id: 't-6',
      eventType: 'income_pattern',
      message: 'Income pattern detected',
      explainNote:
          'A recurring income-type event was recognized from timing patterns '
          'alone. The exact value was never shared with the AI.',
      createdAt: now.subtract(const Duration(days: 6)),
    ),
  ];
});
