/// One scored dimension of financial health.
class HealthScoreSection {
  const HealthScoreSection({required this.name, required this.score});

  final String name;
  final int score; // 0–100
}

/// Financial Health Score (PRD Feature 2) — derived from behavioral
/// patterns only, never from raw amounts.
class HealthScore {
  const HealthScore({
    required this.total,
    required this.trendDelta,
    required this.sections,
    required this.aiExplanation,
  });

  final int total; // 0–100
  final int trendDelta; // points vs last month
  final List<HealthScoreSection> sections;

  /// Plain-language explanation of the score (explainability requirement).
  final String aiExplanation;
}
