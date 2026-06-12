/// Types of privacy-safe moments on the Compass Journey.
enum JourneyMomentType {
  goalMilestone,
  scoreChange,
  lifeEvent,
  recommendation,
  savingsStreak,
}

/// One behavioral milestone in the user's financial story. Carries only
/// pattern-level information — never transactions, balances or amounts.
class JourneyMoment {
  const JourneyMoment({
    required this.id,
    required this.type,
    required this.title,
    required this.descriptionSafe,
    required this.timestamp,
  });

  final String id;
  final JourneyMomentType type;
  final String title;
  final String descriptionSafe;
  final DateTime timestamp;
}

/// An achievement badge derived from safe behavioral signals.
class JourneyBadge {
  const JourneyBadge({
    required this.id,
    required this.label,
    required this.description,
    required this.earned,
  });

  final String id;
  final String label;
  final String description;
  final bool earned;
}

/// Moments grouped under a month with a short summary line.
class JourneyMonth {
  const JourneyMonth({
    required this.label,
    required this.summary,
    required this.moments,
  });

  final String label;
  final String summary;
  final List<JourneyMoment> moments;
}

/// The assembled journey shown on the Compass Journey screen.
class JourneyData {
  const JourneyData({required this.badges, required this.months});

  final List<JourneyBadge> badges;
  final List<JourneyMonth> months;

  int get earnedBadges => badges.where((b) => b.earned).length;
  bool get isEmpty => months.isEmpty;
}
