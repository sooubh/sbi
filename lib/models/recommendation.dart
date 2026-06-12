enum RecommendationStatus { active, saved, dismissed }

/// An AI-generated suggestion with a mandatory "why" reason
/// (PRD Feature 6).
class Recommendation {
  const Recommendation({
    required this.id,
    required this.title,
    required this.reason,
    required this.actionLabel,
    this.status = RecommendationStatus.active,
  });

  final String id;
  final String title;

  /// Short "why this was suggested" note — required by the PRD.
  final String reason;
  final String actionLabel;
  final RecommendationStatus status;

  Recommendation copyWith({RecommendationStatus? status}) {
    return Recommendation(
      id: id,
      title: title,
      reason: reason,
      actionLabel: actionLabel,
      status: status ?? this.status,
    );
  }

  /// PRD `recommendations` document shape.
  Map<String, dynamic> toMap(String userId) => {
        'userId': userId,
        'title': title,
        'reason': reason,
        'actionLabel': actionLabel,
        'status': status.name,
      };

  factory Recommendation.fromMap(String id, Map<String, dynamic> map) {
    final statusName = map['status'] as String? ?? 'active';
    return Recommendation(
      id: id,
      title: map['title'] as String? ?? '',
      reason: map['reason'] as String? ?? '',
      actionLabel: map['actionLabel'] as String? ?? 'View',
      status: RecommendationStatus.values
          .firstWhere((s) => s.name == statusName, orElse: () => RecommendationStatus.active),
    );
  }
}
