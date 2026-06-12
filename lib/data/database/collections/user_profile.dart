import 'package:isar/isar.dart';
import '../../../../core/privacy/privacy_level.dart';

part 'user_profile.g.dart';

@collection
class UserProfileCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String userId;

  late String name;
  String? avatarPath;

  @enumerated
  late PrivacyLevel privacyLevel;

  late bool cloudEnhancementEnabled;
  late bool onboardingComplete;
  late DateTime createdAt;
}
