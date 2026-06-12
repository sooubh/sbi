import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/privacy/privacy_level.dart';
import '../models/goal.dart';
import '../models/insight.dart';
import 'user_settings.dart';

/// Demo data layer (PRD section 12). Replaced by Firestore in Phase 3 —
/// providers keep the same shape so screens won't change.

/// The hero insight adapts its depth to the chosen privacy level,
/// demonstrating Journey 4 (privacy settings change AI response depth).
final heroInsightProvider = Provider<Insight>((ref) {
  final level = ref.watch(userSettingsProvider).privacyLevel;
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

final demoGoalsProvider = Provider<List<Goal>>((ref) {
  return const [
    Goal(id: 'g1', name: 'Emergency fund', category: 'emergency', progressPercent: 72),
    Goal(id: 'g2', name: 'Goa trip fund', category: 'travel', progressPercent: 45),
    Goal(id: 'g3', name: 'New bike', category: 'vehicle', progressPercent: 18),
  ];
});
