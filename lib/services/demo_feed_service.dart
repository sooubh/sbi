import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/health_score.dart';
import '../models/insight.dart';
import '../models/life_event.dart';
import '../models/recommendation.dart';
import '../models/timeline_entry.dart';
import 'demo_catalog.dart';
import 'firebase/firestore_repository.dart';
import 'user_settings.dart';

/// Feed providers: demo catalog first, hydrated from Firestore when
/// available. Shapes match the PRD section 10 documents.

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

/// AI-generated insights: hydrates from Firestore (written by the
/// generateInsightOnSignal Cloud Function) with static demo fallback.
class InsightsFeedNotifier extends Notifier<List<Insight>> {
  @override
  List<Insight> build() {
    final repo = ref.watch(firestoreRepositoryProvider);
    if (repo != null) {
      Future(() async {
        final insights = await repo.fetchAiInsights();
        if (insights.isNotEmpty) state = insights;
      });
    }
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
  }
}

final insightsFeedProvider =
    NotifierProvider<InsightsFeedNotifier, List<Insight>>(InsightsFeedNotifier.new);

/// Life events respect the event-tracking permission (Feature 8).
class LifeEventsNotifier extends Notifier<List<LifeEvent>> {
  @override
  List<LifeEvent> build() {
    final tracking =
        ref.watch(userSettingsProvider.select((s) => s.eventTracking));
    if (!tracking) return const [];
    final repo = ref.watch(firestoreRepositoryProvider);
    if (repo != null) {
      Future(() async {
        final events = await repo.fetchEvents();
        if (events.isNotEmpty) state = events;
      });
    }
    return DemoCatalog.events(DateTime.now());
  }
}

final lifeEventsProvider =
    NotifierProvider<LifeEventsNotifier, List<LifeEvent>>(LifeEventsNotifier.new);

class RecommendationsNotifier extends Notifier<List<Recommendation>> {
  @override
  List<Recommendation> build() {
    final repo = ref.watch(firestoreRepositoryProvider);
    if (repo != null) {
      Future(() async {
        final recs = await repo.fetchRecommendations();
        if (recs.isNotEmpty) state = recs;
      });
    }
    return DemoCatalog.recommendations;
  }

  void setStatus(String id, RecommendationStatus status) {
    state = [
      for (final rec in state)
        if (rec.id == id) rec.copyWith(status: status) else rec,
    ];
    ref.read(firestoreRepositoryProvider)?.setRecommendationStatus(id, status).ignore();
  }
}

final recommendationsProvider =
    NotifierProvider<RecommendationsNotifier, List<Recommendation>>(
  RecommendationsNotifier.new,
);

class TimelineNotifier extends Notifier<List<TimelineEntry>> {
  @override
  List<TimelineEntry> build() {
    final repo = ref.watch(firestoreRepositoryProvider);
    if (repo != null) {
      Future(() async {
        final entries = await repo.fetchTimeline();
        if (entries.isNotEmpty) state = entries;
      });
    }
    return DemoCatalog.timeline(DateTime.now());
  }
}

final timelineProvider =
    NotifierProvider<TimelineNotifier, List<TimelineEntry>>(TimelineNotifier.new);
