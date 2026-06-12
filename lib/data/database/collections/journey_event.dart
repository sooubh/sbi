import 'package:isar/isar.dart';

part 'journey_event.g.dart';

@collection
class JourneyEventCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String eventId;

  late String eventType;
  late String title;
  late String description;
  late String iconKey;
  late DateTime timestamp;
  String? relatedGoalId;
}
