import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../data/database/collections/journey_event.dart';
import '../data/database/isar_service.dart';

class JourneyEventState {
  const JourneyEventState({
    required this.id,
    required this.eventType,
    required this.title,
    required this.description,
    required this.iconKey,
    required this.timestamp,
    this.relatedGoalId,
  });

  final String id;
  final String eventType;
  final String title;
  final String description;
  final String iconKey;
  final DateTime timestamp;
  final String? relatedGoalId;
}

class JourneyEventsNotifier extends Notifier<List<JourneyEventState>> {
  @override
  List<JourneyEventState> build() {
    final isar = ref.watch(isarServiceProvider).db;

    // Load journey events from Isar
    final localEvents = isar.journeyEventCollections.where().sortByTimestampDesc().findAllSync();
    if (localEvents.isNotEmpty) {
      return localEvents.map((e) => JourneyEventState(
        id: e.eventId,
        eventType: e.eventType,
        title: e.title,
        description: e.description,
        iconKey: e.iconKey,
        timestamp: e.timestamp,
        relatedGoalId: e.relatedGoalId,
      )).toList();
    }

    // Seed default journey events if empty
    _seedJourneyEvents();
    return [];
  }

  void _seedJourneyEvents() {
    final isar = ref.read(isarServiceProvider).db;
    final now = DateTime.now();

    final defaults = [
      ('ev-1', 'travel_event', 'Travel Journey Planned', 'A travel-related spending pattern was detected from safe signals.', 'travel', now.subtract(const Duration(days: 2))),
      ('ev-2', 'income_pattern', 'New Income Pattern', 'A regular monthly salary pattern was identified by timing details.', 'income', now.subtract(const Duration(days: 6))),
      ('ev-3', 'goal_created', 'New Goal: Emergency Fund', 'You initiated your primary Emergency Fund goal.', 'goal', now.subtract(const Duration(days: 10))),
    ];

    isar.writeTxn(() async {
      for (final (id, type, title, desc, icon, time) in defaults) {
        final event = JourneyEventCollection()
          ..eventId = id
          ..eventType = type
          ..title = title
          ..description = desc
          ..iconKey = icon
          ..timestamp = time;
        await isar.journeyEventCollections.put(event);
      }
    }).then((_) {
      ref.invalidateSelf();
    });
  }

  Future<void> addEvent({
    required String type,
    required String title,
    required String description,
    required String iconKey,
    String? relatedGoalId,
  }) async {
    final isar = ref.read(isarServiceProvider).db;
    final event = JourneyEventCollection()
      ..eventId = 'ev-${DateTime.now().millisecondsSinceEpoch}'
      ..eventType = type
      ..title = title
      ..description = description
      ..iconKey = iconKey
      ..timestamp = DateTime.now()
      ..relatedGoalId = relatedGoalId;

    await isar.writeTxn(() async {
      await isar.journeyEventCollections.put(event);
    });

    ref.invalidateSelf();
  }
}

final journeyEventsProvider = NotifierProvider<JourneyEventsNotifier, List<JourneyEventState>>(JourneyEventsNotifier.new);
