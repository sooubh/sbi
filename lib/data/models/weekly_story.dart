class WeeklyStory {
  final String weekStart;
  final String weekEnd;
  final double savedThisWeek;
  final int spendChangePercent; // e.g. -8 for -8%
  final int goalProgressChange; // e.g. 5 for +5%
  final int scoreChange;        // e.g. 3 for +3
  final String summaryText;

  const WeeklyStory({
    required this.weekStart,
    required this.weekEnd,
    required this.savedThisWeek,
    required this.spendChangePercent,
    required this.goalProgressChange,
    required this.scoreChange,
    required this.summaryText,
  });
}
