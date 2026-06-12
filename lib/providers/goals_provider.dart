import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../core/privacy/safe_signal.dart';
import '../data/database/collections/goal.dart';
import '../data/database/isar_service.dart';
import '../domain/models/goal.dart';
import '../domain/services/ai_service.dart';
import '../domain/services/signal_engine.dart';
import '../services/persona.dart';

class GoalListNotifier extends Notifier<List<Goal>> {
  @override
  List<Goal> build() {
    final isar = ref.watch(isarServiceProvider).db;
    
    // Load from Isar
    final localGoals = isar.goalCollections.where().findAllSync();
    if (localGoals.isNotEmpty) {
      return localGoals.map((g) => Goal(
        id: g.goalId,
        name: g.name,
        category: g.category,
        progressPercent: (g.currentProgress / g.targetAmount * 100).toInt().clamp(0, 100),
        status: g.isCompleted ? 'completed' : 'active',
        aiNudge: g.aiLastCoachMessage,
      )).toList();
    }
    
    // Seed default goals for the persona if Isar is empty
    final persona = ref.read(personaProvider);
    _seedPersonaGoals(persona);
    return [];
  }

  void _seedPersonaGoals(DemoPersona persona) {
    final isar = ref.read(isarServiceProvider).db;
    final defaultGoals = switch (persona) {
      DemoPersona.student => [
        ('Laptop fund', 'education', 15000.0, 5700.0),
        ('Exam fees buffer', 'education', 5000.0, 2750.0),
        ('Trip with friends', 'travel', 10000.0, 2200.0),
      ],
      DemoPersona.salaried => [
        ('Emergency fund', 'emergency', 100000.0, 64000.0),
        ('Car upgrade', 'vehicle', 500000.0, 150000.0),
        ('Parents support fund', 'family', 30000.0, 14400.0),
      ],
      DemoPersona.youngProfessional => [
        ('Emergency fund', 'emergency', 50000.0, 36000.0),
        ('Goa trip fund', 'travel', 20000.0, 9000.0),
        ('New bike', 'vehicle', 120000.0, 21600.0),
      ],
      DemoPersona.family => [
        ("Children's education", 'education', 200000.0, 116000.0),
        ('Family emergency fund', 'emergency', 150000.0, 106500.0),
        ('Family vacation', 'travel', 80000.0, 20800.0),
      ]
    };

    isar.writeTxn(() async {
      for (final (name, cat, target, current) in defaultGoals) {
        final g = GoalCollection()
          ..goalId = 'g-${name.hashCode}-${DateTime.now().millisecondsSinceEpoch}'
          ..name = name
          ..category = cat
          ..targetAmount = target
          ..currentProgress = current
          ..milestonePercentages = [25, 50, 75, 100]
          ..milestonesReached = _calculateMilestones(current / target * 100)
          ..isCompleted = current >= target
          ..isPrimary = name == 'Emergency fund'
          ..createdAt = DateTime.now().subtract(const Duration(days: 30))
          ..aiLastCoachMessage = 'Welcome to your YONO Goal Coach.';
        await isar.goalCollections.put(g);
      }
    }).then((_) {
      ref.invalidateSelf();
    });
  }

  List<int> _calculateMilestones(double percent) {
    return [25, 50, 75, 100].where((m) => percent >= m).toList();
  }

  Future<void> addGoal({required String name, required String category, required double targetAmount}) async {
    final isar = ref.read(isarServiceProvider).db;
    final goalId = 'g-${DateTime.now().millisecondsSinceEpoch}';
    final g = GoalCollection()
      ..goalId = goalId
      ..name = name
      ..category = category
      ..targetAmount = targetAmount
      ..currentProgress = 0
      ..milestonePercentages = [25, 50, 75, 100]
      ..milestonesReached = []
      ..isCompleted = false
      ..isPrimary = false
      ..createdAt = DateTime.now()
      ..aiLastCoachMessage = 'Welcome to your new goal! I will coach you on your pace.';

    await isar.writeTxn(() async {
      await isar.goalCollections.put(g);
    });

    final signalEngine = ref.read(signalEngineProvider);
    await signalEngine.emit(
      type: SignalType.goal_progress,
      category: category,
      severity: SignalSeverity.positive,
      goalProgressPercent: 0,
    );

    ref.invalidateSelf();
  }

  Future<void> updateProgress(String goalId, double addAmount) async {
    final isar = ref.read(isarServiceProvider).db;
    
    await isar.writeTxn(() async {
      final g = await isar.goalCollections.filter().goalIdEqualTo(goalId).findFirst();
      if (g != null) {
        g.currentProgress = (g.currentProgress + addAmount).clamp(0.0, g.targetAmount);
        
        final double newPercent = g.currentProgress / g.targetAmount * 100;
        
        final newMilestones = _calculateMilestones(newPercent);
        final newlyReached = newMilestones.where((m) => !g.milestonesReached.contains(m)).toList();
        
        g.milestonesReached = newMilestones;
        if (g.currentProgress >= g.targetAmount) {
          g.isCompleted = true;
          g.completedAt = DateTime.now();
        }

        final aiService = ref.read(aiServiceProvider);
        final persona = ref.read(personaProvider);
        
        String milestoneContext = 'Progress updated.';
        if (g.isCompleted) {
          milestoneContext = 'Goal completed!';
        } else if (newlyReached.isNotEmpty) {
          milestoneContext = 'Reached milestone ${newlyReached.last}%!';
        } else if (addAmount < 0) {
          milestoneContext = 'Progress setback.';
        }

        final coachMessage = await aiService.generateGoalCoaching(
          firstName: persona.firstName,
          goalName: g.name,
          category: g.category,
          progressPercent: newPercent.toInt(),
          milestoneContext: milestoneContext,
        );
        g.aiLastCoachMessage = coachMessage;

        await isar.goalCollections.put(g);

        final signalEngine = ref.read(signalEngineProvider);
        if (g.isCompleted) {
          await signalEngine.emit(
            type: SignalType.goal_completed,
            category: g.category,
            severity: SignalSeverity.positive,
            goalProgressPercent: 100,
          );
        } else if (newlyReached.isNotEmpty) {
          await signalEngine.emit(
            type: SignalType.goal_progress,
            category: g.category,
            severity: SignalSeverity.positive,
            goalProgressPercent: newPercent.toInt(),
          );
        }
      }
    });

    ref.invalidateSelf();
  }
}

final goalListProvider = NotifierProvider<GoalListNotifier, List<Goal>>(GoalListNotifier.new);
