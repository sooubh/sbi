import '../core/privacy/safe_signal.dart';
import '../models/goal.dart';
import '../models/life_event.dart';
import '../models/recommendation.dart';
import '../models/timeline_entry.dart';

/// Demo identity shown across the app — single source of truth.
abstract final class DemoProfile {
  static const fullName = 'Aarav Rao';
  static const firstName = 'Aarav';
  static const initials = 'AR';
  static const persona = 'Demo profile — young professional';
}

/// Single source of truth for demo scenarios (PRD section 12). Used to
/// seed Firestore and as the offline fallback for every provider.
abstract final class DemoCatalog {
  static const goals = [
    Goal(
      id: 'g1',
      name: 'Emergency fund',
      category: 'emergency',
      progressPercent: 72,
      aiNudge: 'You are ahead of pace. One more steady month reaches the 75% milestone.',
    ),
    Goal(
      id: 'g2',
      name: 'Goa trip fund',
      category: 'travel',
      progressPercent: 45,
      aiNudge: 'Progress slowed slightly. A small weekly top-up keeps the trip on schedule.',
    ),
    Goal(
      id: 'g3',
      name: 'New bike',
      category: 'vehicle',
      progressPercent: 18,
      aiNudge: 'A recurring auto-save would build early momentum for this goal.',
    ),
  ];

  static List<LifeEvent> events(DateTime now) => [
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

  static const recommendations = [
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

  static List<TimelineEntry> timeline(DateTime now) => [
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

  /// The six PRD demo signals — the only inputs the AI layer ever sees.
  static List<SafeSignal> signals(DateTime now) => [
        SafeSignal(type: 'income_pattern_detected', category: 'income', severity: SignalSeverity.positive, timestamp: now.subtract(const Duration(days: 6))),
        SafeSignal(type: 'travel_event_detected', category: 'travel', severity: SignalSeverity.info, timestamp: now.subtract(const Duration(days: 2))),
        SafeSignal(type: 'spending_up_in_food_category', category: 'food', severity: SignalSeverity.attention, timestamp: now.subtract(const Duration(days: 1))),
        SafeSignal(type: 'goal_progress_slow', category: 'goals', severity: SignalSeverity.attention, timestamp: now.subtract(const Duration(days: 3))),
        SafeSignal(type: 'bill_due_soon', category: 'bills', severity: SignalSeverity.attention, timestamp: now.subtract(const Duration(hours: 12))),
        SafeSignal(type: 'savings_consistency_improved', category: 'savings', severity: SignalSeverity.positive, timestamp: now.subtract(const Duration(hours: 3))),
      ];
}
