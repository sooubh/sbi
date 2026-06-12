import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../data/database/collections/achievement.dart';
import '../data/database/collections/journey_event.dart';
import '../data/database/isar_service.dart';
import '../domain/services/signal_engine.dart';

class AchievementState {
  const AchievementState({
    required this.id,
    required this.key,
    required this.title,
    required this.description,
    required this.iconKey,
    required this.isUnlocked,
    this.unlockedAt,
  });

  final String id;
  final String key;
  final String title;
  final String description;
  final String iconKey;
  final bool isUnlocked;
  final DateTime? unlockedAt;
}

class AchievementsNotifier extends Notifier<List<AchievementState>> {
  @override
  List<AchievementState> build() {
    final isar = ref.watch(isarServiceProvider).db;

    // Load achievements from Isar
    final localBadges = isar.achievementCollections.where().findAllSync();
    if (localBadges.isNotEmpty) {
      return localBadges.map((b) => AchievementState(
        id: b.achievementId,
        key: b.key,
        title: b.title,
        description: b.description,
        iconKey: b.iconKey,
        isUnlocked: b.isUnlocked,
        unlockedAt: b.unlockedAt,
      )).toList();
    }

    // Seed default achievements if empty
    _seedAchievements();
    return [];
  }

  void _seedAchievements() {
    final isar = ref.read(isarServiceProvider).db;
    final defaults = [
      ('consistent_saver', 'Consistent Saver', 'Savings consistency improved', 'savings'),
      ('goal_getter', 'Goal Getter', 'A goal passed 75%', 'goal'),
      ('health_improver', 'Health Improver', 'Health score up 5+ points', 'health'),
      ('explorer', 'Explorer', 'A travel event was detected', 'travel'),
    ];

    isar.writeTxn(() async {
      for (final (key, title, desc, icon) in defaults) {
        final badge = AchievementCollection()
          ..achievementId = 'ach-$key'
          ..type = 'badge'
          ..key = key
          ..title = title
          ..description = desc
          ..iconKey = icon
          ..isUnlocked = key == 'consistent_saver' // Seed first badge as unlocked
          ..unlockedAt = key == 'consistent_saver' ? DateTime.now().subtract(const Duration(days: 5)) : null;
        await isar.achievementCollections.put(badge);
      }
    }).then((_) {
      ref.invalidateSelf();
    });
  }

  /// Evaluates triggers to unlock achievements dynamically.
  Future<void> checkUnlock(SignalType type, {String? category, int? goalProgress}) async {
    final isar = ref.read(isarServiceProvider).db;

    await isar.writeTxn(() async {
      // 1. Goal Getter Check (passes 75%)
      if (type == SignalType.goal_progress && goalProgress != null && goalProgress >= 75) {
        final b = await isar.achievementCollections.filter().keyEqualTo('goal_getter').findFirst();
        if (b != null && !b.isUnlocked) {
          b.isUnlocked = true;
          b.unlockedAt = DateTime.now();
          await isar.achievementCollections.put(b);
          await _addUnlockJourneyEvent(isar, b.title, b.description);
        }
      }

      // 2. Explorer Check (travel event detected)
      if (type == SignalType.travel_event) {
        final b = await isar.achievementCollections.filter().keyEqualTo('explorer').findFirst();
        if (b != null && !b.isUnlocked) {
          b.isUnlocked = true;
          b.unlockedAt = DateTime.now();
          await isar.achievementCollections.put(b);
          await _addUnlockJourneyEvent(isar, b.title, b.description);
        }
      }

      // 3. Health Improver Check
      if (type == SignalType.health_score_changed) {
        final b = await isar.achievementCollections.filter().keyEqualTo('health_improver').findFirst();
        if (b != null && !b.isUnlocked) {
          b.isUnlocked = true;
          b.unlockedAt = DateTime.now();
          await isar.achievementCollections.put(b);
          await _addUnlockJourneyEvent(isar, b.title, b.description);
        }
      }
    });

    ref.invalidateSelf();
  }

  Future<void> _addUnlockJourneyEvent(Isar isar, String title, String desc) async {
    final event = JourneyEventCollection()
      ..eventId = 'ev-ach-${DateTime.now().millisecondsSinceEpoch}'
      ..eventType = 'achievement_unlocked'
      ..title = 'Achievement Earned: $title'
      ..description = desc
      ..iconKey = 'trophy'
      ..timestamp = DateTime.now();
    await isar.journeyEventCollections.put(event);
  }
}

final achievementsStateProvider = NotifierProvider<AchievementsNotifier, List<AchievementState>>(AchievementsNotifier.new);
