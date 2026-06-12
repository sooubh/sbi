import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/privacy/privacy_sanitizer.dart';
import '../../core/privacy/safe_signal.dart';
import '../../models/insight.dart';
import '../../models/timeline_entry.dart';
import '../demo_feed_service.dart';
import '../firebase/firestore_repository.dart';
import '../user_settings.dart';
import 'local_insight_templates.dart';

/// Client-side mirror of the PRD section 15 pipeline. The signal is also
/// logged to Firestore, where the generateInsightOnSignal Cloud Function
/// runs the same flow with Gemini when deployed.
class SignalPipeline {
  SignalPipeline(this._ref);

  final Ref _ref;

  Future<({Map<String, Object> payload, Insight insight})> fire(
      SafeSignal signal) async {
    final level = _ref.read(userSettingsProvider).privacyLevel;
    // The chokepoint — throws if anything unsafe slips through.
    final payload = PrivacySanitizer.buildAiPayload(signal: signal, level: level);

    _ref.read(firestoreRepositoryProvider)?.logSignal(signal).ignore();

    // Simulated generation latency for a believable live demo.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final insight = localInsightFor(signal);

    _ref.read(insightsFeedProvider.notifier).addInsight(insight);
    _ref.read(timelineProvider.notifier).addEntry(TimelineEntry(
          id: 'tl-${DateTime.now().millisecondsSinceEpoch}',
          eventType: 'ai_insight',
          message: 'Insight generated from a safe signal',
          explainNote: insight.reason,
          createdAt: DateTime.now(),
        ));

    return (payload: payload, insight: insight);
  }
}

final signalPipelineProvider = Provider<SignalPipeline>(SignalPipeline.new);
