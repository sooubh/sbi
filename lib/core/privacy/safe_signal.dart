/// Severity classification of a behavioral signal.
enum SignalSeverity { info, positive, attention }

/// A privacy-safe behavioral signal — the ONLY data shape the AI layer
/// is ever allowed to consume (PRD section 4).
///
/// A [SafeSignal] must never carry amounts, account numbers, merchant
/// names or transaction descriptions. It is a pattern, not a record.
class SafeSignal {
  const SafeSignal({
    required this.type,
    required this.category,
    required this.timestamp,
    this.severity = SignalSeverity.info,
  });

  /// e.g. 'savings_consistency_improved', 'travel_event_detected'.
  final String type;

  /// e.g. 'savings', 'food', 'travel'.
  final String category;

  final SignalSeverity severity;
  final DateTime timestamp;

  /// PRD `financialSignals` document shape (userId added by the repository).
  Map<String, dynamic> toMap() => {
        'signalType': type,
        'category': category,
        'severity': severity.name,
        'timestamp': timestamp,
      };
}
