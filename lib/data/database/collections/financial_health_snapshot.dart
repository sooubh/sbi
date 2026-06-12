import 'package:isar/isar.dart';

part 'financial_health_snapshot.g.dart';

@collection
class FinancialHealthSnapshotCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String snapshotId;

  late int score;
  late int savingsSubScore;
  late int consistencySubScore;
  late int goalSubScore;
  late int spendingSubScore;
  late int stabilitySubScore;
  late String aiExplanation;
  late String aiImprovementTip;
  late DateTime recordedAt;
}
