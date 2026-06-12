import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weekly_story.dart';

/// The Weekly Story is a projection of providers that already hold only
/// privacy-safe data (score points, progress percentages, badges), so it
/// cannot contain raw financial data by construction.
import '../providers/weekly_story_provider.dart';

final weeklyStoryProvider = FutureProvider<WeeklyStory>((ref) async {
  return ref.watch(weeklyStoryStateProvider.future);
});
