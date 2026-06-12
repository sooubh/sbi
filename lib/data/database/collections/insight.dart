import 'package:isar/isar.dart';

part 'insight.g.dart';

@collection
class InsightCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String insightId;

  late String text;
  late String category;
  late double confidenceScore;
  late String reasonText;
  late String suggestedAction;
  late String signalSource;
  late bool isRead;
  late DateTime generatedAt;
}
