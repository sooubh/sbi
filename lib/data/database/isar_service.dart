import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collections/achievement.dart';
import 'collections/financial_health_snapshot.dart';
import 'collections/goal.dart';
import 'collections/insight.dart';
import 'collections/journey_event.dart';
import 'collections/safe_signal.dart';
import 'collections/user_profile.dart';
import 'collections/weekly_story.dart';

class IsarService {
  IsarService(this._isar);

  final Isar _isar;

  Isar get db => _isar;

  static Future<IsarService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        UserProfileCollectionSchema,
        GoalCollectionSchema,
        JourneyEventCollectionSchema,
        InsightCollectionSchema,
        WeeklyStoryCollectionSchema,
        AchievementCollectionSchema,
        FinancialHealthSnapshotCollectionSchema,
        SafeSignalCollectionSchema,
      ],
      directory: dir.path,
    );
    return IsarService(isar);
  }
}

final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError('isarServiceProvider must be overridden in main()');
});
