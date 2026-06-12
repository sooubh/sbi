/// A life event detected from privacy-safe behavioral patterns
/// (PRD Feature 3). Carries no transaction details by design.
class LifeEvent {
  const LifeEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.descriptionSafe,
    required this.nextAction,
    required this.detectedAt,
  });

  final String id;

  /// e.g. 'travel', 'salary', 'overspending', 'goal_progress'.
  final String type;
  final String title;

  /// Pattern-level description — never names merchants or amounts.
  final String descriptionSafe;

  /// Recommended next step shown in the detail view.
  final String nextAction;
  final DateTime detectedAt;

  /// PRD `events` document shape.
  Map<String, dynamic> toMap(String userId) => {
        'userId': userId,
        'eventType': type,
        'title': title,
        'descriptionSafe': descriptionSafe,
        'nextAction': nextAction,
        'timestamp': detectedAt,
      };

  factory LifeEvent.fromMap(String id, Map<String, dynamic> map) => LifeEvent(
        id: id,
        type: map['eventType'] as String? ?? 'event',
        title: map['title'] as String? ?? 'Event detected',
        descriptionSafe: map['descriptionSafe'] as String? ?? '',
        nextAction: map['nextAction'] as String? ?? '',
        detectedAt: map['timestamp'] as DateTime? ?? DateTime.now(),
      );
}
