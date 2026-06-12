/// An AI-generated, privacy-safe insight (PRD section 11 output format).
class Insight {
  const Insight({
    required this.id,
    required this.title,
    required this.body,
    required this.recommendation,
    required this.reason,
    required this.confidence,
    required this.signalType,
  });

  final String id;
  final String title;
  final String body;
  final String recommendation;

  /// Plain-language "why this was shown" — explainability requirement.
  final String reason;
  final double confidence;

  /// The safe signal that produced this insight.
  final String signalType;
}
