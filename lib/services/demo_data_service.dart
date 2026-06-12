import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/privacy/privacy_level.dart';
import '../models/goal.dart';
import '../models/insight.dart';
import 'demo_catalog.dart';
import 'firebase/firestore_repository.dart';
import 'user_settings.dart';

/// The hero insight adapts its depth to the chosen privacy level and the
/// insight-detail toggle (Journey 4). Phase 4 replaces the static text
/// with Gemini output fetched from Firestore.
final heroInsightProvider = Provider<Insight>((ref) {
  final settings = ref.watch(userSettingsProvider);
  final level =
      settings.detailedInsights ? settings.privacyLevel : PrivacyLevel.minimal;
  switch (level) {
    case PrivacyLevel.minimal:
      return const Insight(
        id: 'ins-1',
        title: 'Positive trend detected',
        body: 'Your overall financial wellness trend is improving this month.',
        recommendation: 'Keep your current routine going.',
        reason:
            'Generated from a generic wellness trend signal. At Minimal level, '
            'no category detail is shared with the AI.',
        confidence: 0.81,
        signalType: 'wellness_trend_positive',
      );
    case PrivacyLevel.standard:
      return const Insight(
        id: 'ins-2',
        title: 'Savings consistency improved',
        body: 'Your savings consistency has improved recently. Nice momentum!',
        recommendation: 'Consider a small increase to your monthly auto-save.',
        reason:
            'Generated from the savings_consistency_improved signal. Only the '
            'category pattern was shared — no amounts or transactions.',
        confidence: 0.86,
        signalType: 'savings_consistency_improved',
      );
    case PrivacyLevel.personalized:
      return const Insight(
        id: 'ins-3',
        title: 'Steady progress toward your trip goal',
        body:
            'Savings consistency is up, and your travel goal is on pace for '
            'its next milestone.',
        recommendation: 'A small weekly top-up would reach the milestone sooner.',
        reason:
            'Generated from savings_consistency_improved plus goal progress '
            'percentage. No balances, amounts or transactions were shared.',
        confidence: 0.89,
        signalType: 'goal_progress_increasing',
      );
  }
});

/// Goals: starts with the demo catalog, hydrates from Firestore when
/// available, and persists new goals.
class GoalsNotifier extends Notifier<List<Goal>> {
  @override
  List<Goal> build() {
    final repo = ref.watch(firestoreRepositoryProvider);
    if (repo != null) {
      Future(() async {
        final goals = await repo.fetchGoals();
        if (goals.isNotEmpty) state = goals;
      });
    }
    return DemoCatalog.goals;
  }

  void addGoal({required String name, required String category}) {
    final goal = Goal(
      id: 'g-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      category: category,
      progressPercent: 0,
      aiNudge: 'New goal created. Set a recurring auto-save to build momentum.',
    );
    state = [...state, goal];
    ref.read(firestoreRepositoryProvider)?.addGoal(goal).ignore();
  }
}

final demoGoalsProvider =
    NotifierProvider<GoalsNotifier, List<Goal>>(GoalsNotifier.new);
