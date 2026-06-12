import 'privacy_level.dart';
import 'safe_signal.dart';

/// The single enforced chokepoint between financial data and the AI layer.
///
/// No payload may be dispatched to an AI model unless it was produced by
/// [buildAiPayload], which accepts only pre-classified [SafeSignal]s and
/// verifies that no raw financial values leak through.
class PrivacySanitizer {
  PrivacySanitizer._();

  /// Patterns that indicate raw sensitive data (PRD non-negotiable rules).
  static final List<RegExp> _forbidden = [
    RegExp(r'\d{9,18}'), // account-number-like sequences
    RegExp(r'(?:₹|rs\.?|inr)\s*\d', caseSensitive: false), // currency amounts
    RegExp(r'\b\d{4}[-\s]?\d{4}[-\s]?\d{4}(?:[-\s]?\d{4})?\b'), // card numbers
    RegExp(r'\b(cvv|pin|otp|password)\b', caseSensitive: false), // secrets
  ];

  /// Whether [text] is free of raw sensitive financial data.
  static bool isSafe(String text) => _forbidden.every((p) => !p.hasMatch(text));

  /// Builds the only payload shape permitted to reach the AI layer.
  ///
  /// At [PrivacyLevel.minimal] the category is stripped, leaving only the
  /// generic signal type. Throws [StateError] if any value fails the
  /// safety check — failing closed is intentional.
  static Map<String, Object> buildAiPayload({
    required SafeSignal signal,
    required PrivacyLevel level,
    int? goalProgressPercent,
  }) {
    final payload = <String, Object>{
      'signal': signal.type,
      if (level != PrivacyLevel.minimal) 'category': signal.category,
      'severity': signal.severity.name,
      'privacyLevel': level.name,
      if (goalProgressPercent != null)
        'goalProgress': goalProgressPercent.clamp(0, 100),
    };

    for (final value in payload.values.whereType<String>()) {
      if (!isSafe(value)) {
        throw StateError(
          'PrivacySanitizer blocked an unsafe value before AI dispatch.',
        );
      }
    }
    return payload;
  }
}
