/// A user savings goal (PRD Feature 4 — progress only, never amounts).
class Goal {
  const Goal({
    required this.id,
    required this.name,
    required this.category,
    required this.progressPercent,
    this.status = 'active',
    this.aiNudge,
  });

  final String id;
  final String name;

  /// e.g. 'emergency', 'travel', 'vehicle', 'education', 'family'.
  final String category;
  final int progressPercent;
  final String status;

  /// Privacy-safe AI coaching nudge for this goal.
  final String? aiNudge;

  /// Milestone thresholds used for badges.
  static const milestones = [25, 50, 75, 100];

  List<int> get reachedMilestones =>
      milestones.where((m) => progressPercent >= m).toList();

  Goal copyWith({int? progressPercent, String? status, String? aiNudge}) {
    return Goal(
      id: id,
      name: name,
      category: category,
      progressPercent: progressPercent ?? this.progressPercent,
      status: status ?? this.status,
      aiNudge: aiNudge ?? this.aiNudge,
    );
  }
}
