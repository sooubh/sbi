// ignore_for_file: constant_identifier_names
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/privacy/privacy_sanitizer.dart';
import '../../core/privacy/safe_signal.dart';
import '../../data/database/collections/safe_signal.dart';
import '../../data/database/isar_service.dart';
import '../../providers/achievements_provider.dart';
import '../../providers/health_score_provider.dart';
import '../../services/firebase/firestore_repository.dart';
import '../../services/user_settings.dart';

/// Supported Signal Types as defined in PRD Section 6.3.
enum SignalType {
  income_pattern,          // Regular income behavior detected
  goal_progress,           // A goal has made measurable progress
  goal_completed,          // A goal has reached 100%
  travel_event,            // Travel-related spending pattern detected
  education_event,         // Education-related payment detected
  housing_event,           // Housing/rent-related payment detected
  savings_improved,        // Month-over-month savings increased
  spending_increased,      // Spending trend is rising
  spending_decreased,      // Spending trend is falling
  health_score_changed,    // Financial health score moved significantly
  streak_created,          // User has started a new behavioral streak
  streak_broken,           // An existing streak was interrupted
  bill_due,                // A recurring bill is approaching due date
  achievement_unlocked,    // User earned a new badge or milestone
}

class SignalEngine {
  SignalEngine(this._ref);

  final Ref _ref;

  /// Emits a signal, processes privacy abstraction, saves to local database (Isar),
  /// logs to Firestore (if available), and triggers downstream intelligence pipelines.
  Future<void> emit({
    required SignalType type,
    required String category,
    required SignalSeverity severity,
    int? goalProgressPercent,
  }) async {
    final settings = _ref.read(userSettingsProvider);
    
    // Abstract the signal
    final safeSignal = SafeSignal(
      type: type.name,
      category: category,
      severity: severity,
      timestamp: DateTime.now(),
    );

    // Run privacy chokepoint before doing anything with AI or storage
    PrivacySanitizer.buildAiPayload(
      signal: safeSignal,
      level: settings.privacyLevel,
      goalProgressPercent: goalProgressPercent,
    );

    // Save to local Isar database (Offline-first requirement)
    final isarService = _ref.read(isarServiceProvider);
    final localSignal = SafeSignalCollection()
      ..type = safeSignal.type
      ..category = safeSignal.category
      ..severity = safeSignal.severity.name
      ..timestamp = safeSignal.timestamp;

    await isarService.db.writeTxn(() async {
      await isarService.db.safeSignalCollections.put(localSignal);
    });

    // Downstream triggers: check achievements & refresh health score
    await _ref.read(achievementsStateProvider.notifier).checkUnlock(
      type,
      category: category,
      goalProgress: goalProgressPercent,
    );
    _ref.invalidate(healthScoreStateProvider);

    // Optionally log to Firestore repository
    final firestoreRepo = _ref.read(firestoreRepositoryProvider);
    if (firestoreRepo != null) {
      firestoreRepo.logSignal(safeSignal).ignore();
    }
  }
}

final signalEngineProvider = Provider<SignalEngine>(SignalEngine.new);
