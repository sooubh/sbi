import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class GoalCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String goalId;

  late String name;
  late String category;
  late double targetAmount;
  late double currentProgress;
  late List<int> milestonePercentages;
  late List<int> milestonesReached;
  late bool isCompleted;
  late bool isPrimary;
  late DateTime createdAt;
  DateTime? completedAt;
  String? aiLastCoachMessage;
}
