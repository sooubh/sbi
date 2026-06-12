import 'package:isar/isar.dart';

part 'weekly_story.g.dart';

@collection
class WeeklyStoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String storyId;

  late DateTime weekStartDate;
  late String headline;
  late String bodyText;
  late String summary;
  late int healthScoreDelta;
  late String topGoalProgress;
  late String streakInfo;
  String? achievementHighlight;
  late DateTime generatedAt;
}
