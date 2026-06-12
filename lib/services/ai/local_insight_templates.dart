import '../../core/privacy/safe_signal.dart';
import '../../models/insight.dart';

/// Client-side mirror of the Cloud Function insight templates, used when
/// generating insights locally in demo mode (parity with functions/src/gemini.ts).
Insight localInsightFor(SafeSignal signal) {
  final id = 'gen-${DateTime.now().millisecondsSinceEpoch}';
  return switch (signal.type) {
    'savings_consistency_improved' => Insight(
        id: id,
        title: 'Savings consistency improved',
        body: 'Your savings consistency has improved recently. Nice momentum!',
        recommendation: 'Consider a small increase to your monthly auto-save.',
        reason: 'Derived from the savings_consistency_improved signal only.',
        confidence: 0.86,
        signalType: signal.type,
      ),
    'spending_up_in_food_category' => Insight(
        id: id,
        title: 'Food spending is trending up',
        body: 'Food-related spending is higher than usual this month.',
        recommendation: 'Set a weekly spending limit for the food category.',
        reason: 'Only the category trend was analyzed — no amounts or merchants.',
        confidence: 0.84,
        signalType: signal.type,
      ),
    'travel_event_detected' => Insight(
        id: id,
        title: 'A travel-related event was detected',
        body: 'Recent activity suggests an upcoming trip.',
        recommendation: 'Consider setting a short-term trip budget.',
        reason: 'A behavioral pattern only — no booking details were read.',
        confidence: 0.78,
        signalType: signal.type,
      ),
    'bill_due_soon' => Insight(
        id: id,
        title: 'A bill is due soon',
        body: 'An upcoming bill pattern was detected for this week.',
        recommendation: 'Enable a bill reminder so it is never missed.',
        reason: 'The biller name and amount were never shared with the AI.',
        confidence: 0.91,
        signalType: signal.type,
      ),
    'income_pattern_detected' => Insight(
        id: id,
        title: 'Income pattern detected',
        body: 'A recurring income pattern was identified.',
        recommendation: 'Automate a savings transfer right after income arrives.',
        reason: 'Recognized from timing patterns alone — the value stays private.',
        confidence: 0.88,
        signalType: signal.type,
      ),
    'goal_progress_slow' => Insight(
        id: id,
        title: 'Goal progress is slowing',
        body: 'One of your goals is progressing slower than its usual pace.',
        recommendation: 'A small weekly top-up would bring it back on schedule.',
        reason: 'Only progress percentages were analyzed — never amounts.',
        confidence: 0.8,
        signalType: signal.type,
      ),
    _ => Insight(
        id: id,
        title: 'Positive trend detected',
        body: 'A positive trend was detected in your financial behavior.',
        recommendation: 'Keep your current routine going.',
        reason: 'Derived from a generic wellness trend signal.',
        confidence: 0.75,
        signalType: signal.type,
      ),
  };
}
