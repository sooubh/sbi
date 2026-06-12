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

  /// `insights` document shape written by the generateInsightOnSignal
  /// Cloud Function.
  factory Insight.fromMap(String id, Map<String, dynamic> map) => Insight(
        id: id,
        title: map['title'] as String? ?? 'Compass insight',
        body: map['body'] as String? ?? '',
        recommendation: map['recommendation'] as String? ?? '',
        reason: map['reason'] as String? ?? '',
        confidence: (map['confidence'] as num?)?.toDouble() ?? 0.8,
        signalType: map['signalType'] as String? ?? 'signal',
      );
}
