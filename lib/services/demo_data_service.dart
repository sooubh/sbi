import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/privacy/privacy_level.dart';
import '../models/goal.dart';
import '../models/insight.dart';
import '../providers/goals_provider.dart';
import 'demo_catalog.dart';
import 'persona.dart';
import 'user_settings.dart';

/// Persona-specific goal sets (PRD section 12 demo user profiles).
List<Goal> goalsForPersona(DemoPersona persona) => switch (persona) {
      DemoPersona.student => const [
        Goal(
          id: 's1',
          name: 'Laptop fund',
          category: 'education',
          progressPercent: 38,
          aiNudge: 'Saving a little from each allowance keeps this on pace for semester end.',
        ),
        Goal(
          id: 's2',
          name: 'Exam fees buffer',
          category: 'education',
          progressPercent: 55,
          aiNudge: 'More than halfway there — one steady month reaches the next milestone.',
        ),
        Goal(
          id: 's3',
          name: 'Trip with friends',
          category: 'travel',
          progressPercent: 22,
          aiNudge: 'A small weekly top-up would build early momentum.',
        ),
      ],
      DemoPersona.salaried => const [
        Goal(
          id: 'e1',
          name: 'Emergency fund',
          category: 'emergency',
          progressPercent: 64,
          aiNudge: 'Consistent salary-day transfers are working — keep the routine.',
        ),
        Goal(
          id: 'e2',
          name: 'Car upgrade',
          category: 'vehicle',
          progressPercent: 30,
          aiNudge: 'Pace is steady; an annual-bonus top-up would jump a milestone.',
        ),
        Goal(
          id: 'e3',
          name: 'Parents support fund',
          category: 'family',
          progressPercent: 48,
          aiNudge: 'Nearly halfway — a small auto-save keeps this stress-free.',
        ),
      ],
      DemoPersona.youngProfessional => DemoCatalog.goals,
      DemoPersona.family => const [
        Goal(
          id: 'f1',
          name: "Children's education",
          category: 'education',
          progressPercent: 58,
          aiNudge: 'On track — review the pace each school term.',
        ),
        Goal(
          id: 'f2',
          name: 'Family emergency fund',
          category: 'emergency',
          progressPercent: 71,
          aiNudge: 'Strong buffer building — the 75% milestone is close.',
        ),
        Goal(
          id: 'f3',
          name: 'Family vacation',
          category: 'travel',
          progressPercent: 26,
          aiNudge: 'A monthly family top-up would keep the holiday on schedule.',
        ),
      ],
    };

/// The hero insight adapts its depth to the chosen privacy level and the
/// insight-detail toggle (Journey 4).
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

/// Goals: persona-aware, hydrates from Firestore for the default persona
/// (whose data is seeded), and persists new goals.

class GoalsNotifier extends Notifier<List<Goal>> {
  @override
  List<Goal> build() {
    return ref.watch(goalListProvider);
  }

  void addGoal({required String name, required String category}) {
    ref.read(goalListProvider.notifier).addGoal(
          name: name,
          category: category,
          targetAmount: 20000.0,
        );
  }
}

final demoGoalsProvider =
    NotifierProvider<GoalsNotifier, List<Goal>>(GoalsNotifier.new);
