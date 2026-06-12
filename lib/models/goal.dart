/// A user savings goal (PRD Feature 4 — progress only, never amounts).
class Goal {
  const Goal({
    required this.id,
    required this.name,
    required this.category,
    required this.progressPercent,
    this.status = 'active',
  });

  final String id;
  final String name;

  /// e.g. 'emergency', 'travel', 'vehicle', 'education', 'family'.
  final String category;
  final int progressPercent;
  final String status;
}
