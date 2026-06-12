/// One entry in the Agent Timeline (PRD Feature 5) — a record of what
/// the AI noticed or did, with an explainable note.
class TimelineEntry {
  const TimelineEntry({
    required this.id,
    required this.eventType,
    required this.message,
    required this.explainNote,
    required this.createdAt,
  });

  final String id;

  /// e.g. 'income_pattern', 'savings_suggestion', 'travel_event',
  /// 'budget_recommendation', 'goal_review', 'bill_reminder'.
  final String eventType;
  final String message;

  /// Expanded explainable-AI note shown when the card is opened.
  final String explainNote;
  final DateTime createdAt;
}
