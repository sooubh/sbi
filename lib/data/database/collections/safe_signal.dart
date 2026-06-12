import 'package:isar/isar.dart';

part 'safe_signal.g.dart';

@collection
class SafeSignalCollection {
  Id id = Isar.autoIncrement;

  late String type;
  late String category;
  late String severity;
  late DateTime timestamp;
}
