import 'package:isar/isar.dart';

part 'achievement.g.dart';

@collection
class AchievementCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String achievementId;

  late String type;
  late String key;
  late String title;
  late String description;
  late String iconKey;
  late bool isUnlocked;
  DateTime? unlockedAt;
}
