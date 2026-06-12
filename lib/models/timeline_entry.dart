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

  /// PRD `timeline` document shape.
  Map<String, dynamic> toMap(String userId) => {
        'userId': userId,
        'eventType': eventType,
        'message': message,
        'explainNote': explainNote,
        'createdAt': createdAt,
      };

  factory TimelineEntry.fromMap(String id, Map<String, dynamic> map) =>
      TimelineEntry(
        id: id,
        eventType: map['eventType'] as String? ?? 'activity',
        message: map['message'] as String? ?? '',
        explainNote: map['explainNote'] as String? ?? '',
        createdAt: map['createdAt'] as DateTime? ?? DateTime.now(),
      );
}
