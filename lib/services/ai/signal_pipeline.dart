import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/privacy/privacy_sanitizer.dart';
import '../../core/privacy/safe_signal.dart';
import '../../data/database/collections/journey_event.dart';
import '../../data/database/isar_service.dart';
import '../../domain/services/signal_engine.dart';
import '../../models/insight.dart';
import '../../models/timeline_entry.dart';
import '../../providers/journey_events_provider.dart';
import '../demo_feed_service.dart';
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

    // Parse string to SignalType enum and emit
    final type = SignalType.values.firstWhere(
      (e) => e.name == signal.type,
      orElse: () => SignalType.income_pattern,
    );
    await _ref.read(signalEngineProvider).emit(
      type: type,
      category: signal.category,
      severity: signal.severity,
    );

    // Simulated generation latency for a believable live demo.
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final insight = localInsightFor(signal);

    _ref.read(insightsFeedProvider.notifier).addInsight(insight);

    // Save journey event to Isar
    final isar = _ref.read(isarServiceProvider).db;
    final journeyEvent = JourneyEventCollection()
      ..eventId = 'ev-ins-${DateTime.now().millisecondsSinceEpoch}'
      ..eventType = signal.type
      ..title = insight.title
      ..description = insight.body
      ..iconKey = signal.category
      ..timestamp = DateTime.now();

    await isar.writeTxn(() async {
      await isar.journeyEventCollections.put(journeyEvent);
    });

    _ref.invalidate(journeyEventsProvider);

    _ref.read(timelineProvider.notifier).addEntry(TimelineEntry(
          id: 'tl-${DateTime.now().millisecondsSinceEpoch}',
          eventType: 'ai_insight',
          message: insight.title,
          explainNote: insight.reason,
          createdAt: DateTime.now(),
        ));

    return (payload: payload, insight: insight);
  }
}

final signalPipelineProvider = Provider<SignalPipeline>(SignalPipeline.new);
