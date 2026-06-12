import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../data/database/collections/financial_health_snapshot.dart';
import '../data/database/collections/safe_signal.dart';
import '../data/database/isar_service.dart';
import '../domain/models/health_score.dart';
import '../domain/services/ai_service.dart';
import '../services/persona.dart';
import 'goals_provider.dart';

final healthScoreStateProvider = FutureProvider<HealthScore>((ref) async {
  final isar = ref.watch(isarServiceProvider).db;
  final goals = ref.watch(goalListProvider);
  final persona = ref.watch(personaProvider);
  final aiService = ref.watch(aiServiceProvider);

  // 1. Fetch recent signals from Isar
  final signals = await isar.safeSignalCollections.where().findAll();

  // 2. Compute dynamic subscores
  // Savings: 15pts base + 5pts per savings signal (up to 25)
  final savingsCount = signals.where((s) => s.category == 'savings').length;
  final savingsSub = (15 + savingsCount * 5).clamp(0, 25);

  // Consistency: based on savings streak (or savings improved signals)
  final consistencyCount = signals.where((s) => s.type == 'savings_consistency_improved').length;
  final consistencySub = (10 + consistencyCount * 5).clamp(0, 20);

  // Goal Progress: average progress of all goals, scaled to 25
  int goalSub = 15;
  if (goals.isNotEmpty) {
    final avgProgress = goals.map((g) => g.progressPercent).reduce((a, b) => a + b) / goals.length;
    goalSub = (avgProgress / 100 * 25).toInt().clamp(0, 25);
  }

  // Spending Control: starts at 15, decreases by 5 per spending spike (down to 5)
  final spendingSpikes = signals.where((s) => s.type == 'spending_up_in_food_category').length;
  final spendingSub = (15 - spendingSpikes * 5).clamp(5, 15);

  // Stability: starts at 15, decreases by 3 per bill due soon (down to 5)
  final billDues = signals.where((s) => s.type == 'bill_due_soon').length;
  final stabilitySub = (15 - billDues * 3).clamp(5, 15);

  final totalScore = savingsSub + consistencySub + goalSub + spendingSub + stabilitySub;

  // 3. Score explanation from AI Service
  final explanation = await aiService.generateHealthScoreExplanation(
    firstName: persona.firstName,
    score: totalScore,
    savings: (savingsSub / 25 * 100).toInt(),
    consistency: (consistencySub / 20 * 100).toInt(),
    goals: (goalSub / 25 * 100).toInt(),
    spending: (spendingSub / 15 * 100).toInt(),
    stability: (stabilitySub / 15 * 100).toInt(),
  );

  // 4. Save snapshot to database
  final snapshot = FinancialHealthSnapshotCollection()
    ..snapshotId = 'snap-${DateTime.now().millisecondsSinceEpoch}'
    ..score = totalScore
    ..savingsSubScore = savingsSub
    ..consistencySubScore = consistencySub
    ..goalSubScore = goalSub
    ..spendingSubScore = spendingSub
    ..stabilitySubScore = stabilitySub
    ..aiExplanation = explanation
    ..aiImprovementTip = 'Focus on increasing savings consistency.'
    ..recordedAt = DateTime.now();

  await isar.writeTxn(() async {
    await isar.financialHealthSnapshotCollections.put(snapshot);
  });

  // 5. Gather history from Isar
  final allSnaps = await isar.financialHealthSnapshotCollections.where().sortByRecordedAt().findAll();
  final List<int> scoreHistory = allSnaps.map((s) => s.score).toList();
  if (scoreHistory.isEmpty) {
    scoreHistory.addAll([72, 75, 74, 78, 79, totalScore]);
  } else if (scoreHistory.length < 5) {
    scoreHistory.insertAll(0, [72, 75, 74].take(5 - scoreHistory.length));
  }

  final trendDelta = scoreHistory.length >= 2 
      ? scoreHistory.last - scoreHistory[scoreHistory.length - 2]
      : 3;

  return HealthScore(
    total: totalScore,
    trendDelta: trendDelta,
    history: scoreHistory,
    sections: [
      HealthScoreSection(name: 'Savings', score: (savingsSub / 25 * 100).toInt()),
      HealthScoreSection(name: 'Consistency', score: (consistencySub / 20 * 100).toInt()),
      HealthScoreSection(name: 'Goals', score: (goalSub / 25 * 100).toInt()),
      HealthScoreSection(name: 'Spending', score: (spendingSub / 15 * 100).toInt()),
      HealthScoreSection(name: 'Stability', score: (stabilitySub / 15 * 100).toInt()),
    ],
    aiExplanation: explanation,
  );
});
