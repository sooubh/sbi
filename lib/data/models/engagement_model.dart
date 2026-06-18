
class EngagementEvent {
  final String id;
  final String actionName;
  final DateTime timestamp;
  final int coinsEarned;
  final String details;

  const EngagementEvent({
    required this.id,
    required this.actionName,
    required this.timestamp,
    required this.coinsEarned,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'actionName': actionName,
      'timestamp': timestamp.toIso8601String(),
      'coinsEarned': coinsEarned,
      'details': details,
    };
  }

  factory EngagementEvent.fromMap(Map<String, dynamic> map) {
    return EngagementEvent(
      id: map['id'] ?? '',
      actionName: map['actionName'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      coinsEarned: map['coinsEarned'] ?? 0,
      details: map['details'] ?? '',
    );
  }
}

class EngagementState {
  final int sbiCoins;
  final int streakCount;
  final List<String> unlockedAchievements;
  final List<EngagementEvent> trackedEvents;

  const EngagementState({
    required this.sbiCoins,
    required this.streakCount,
    required this.unlockedAchievements,
    required this.trackedEvents,
  });

  EngagementState copyWith({
    int? sbiCoins,
    int? streakCount,
    List<String>? unlockedAchievements,
    List<EngagementEvent>? trackedEvents,
  }) {
    return EngagementState(
      sbiCoins: sbiCoins ?? this.sbiCoins,
      streakCount: streakCount ?? this.streakCount,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      trackedEvents: trackedEvents ?? this.trackedEvents,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sbiCoins': sbiCoins,
      'streakCount': streakCount,
      'unlockedAchievements': unlockedAchievements,
      'trackedEvents': trackedEvents.map((x) => x.toMap()).toList(),
    };
  }
}
