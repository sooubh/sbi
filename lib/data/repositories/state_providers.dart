import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/user_profile.dart';
import '../models/financial_goal.dart';
import '../models/recommendation.dart';
import '../models/weekly_story.dart';
import '../models/service_model.dart';
import '../models/transaction_model.dart';
import '../models/engagement_model.dart';
import '../mock/mock_data.dart';

// Serialization helpers
Map<String, dynamic> userProfileToMap(UserProfile user) {
  return {
    'userId': user.userId,
    'name': user.name,
    'maskedAccount': user.maskedAccount,
    'balance': user.balance,
    'kycComplete': user.kycComplete,
    'upiEnabled': user.upiEnabled,
    'hasGoal': user.hasGoal,
    'goalCount': user.goalCount,
    'financialHealthScore': user.financialHealthScore,
    'lastLogin': user.lastLogin,
    'newUser': user.newUser,
  };
}

UserProfile userProfileFromMap(Map<String, dynamic> map) {
  return UserProfile(
    userId: map['userId'] as String,
    name: map['name'] as String,
    maskedAccount: map['maskedAccount'] as String,
    balance: (map['balance'] as num).toDouble(),
    kycComplete: map['kycComplete'] as bool,
    upiEnabled: map['upiEnabled'] as bool,
    hasGoal: map['hasGoal'] as bool,
    goalCount: map['goalCount'] as int,
    financialHealthScore: map['financialHealthScore'] as int,
    lastLogin: map['lastLogin'] as String,
    newUser: map['newUser'] as bool,
  );
}

Map<String, dynamic> financialGoalToMap(FinancialGoal goal) {
  return {
    'id': goal.id,
    'name': goal.name,
    'targetAmount': goal.targetAmount,
    'savedAmount': goal.savedAmount,
    'monthlyContribution': goal.monthlyContribution,
    'status': goal.status,
  };
}

FinancialGoal financialGoalFromMap(Map<String, dynamic> map) {
  return FinancialGoal(
    id: map['id'] as String,
    name: map['name'] as String,
    targetAmount: (map['targetAmount'] as num).toDouble(),
    savedAmount: (map['savedAmount'] as num).toDouble(),
    monthlyContribution: (map['monthlyContribution'] as num).toDouble(),
    status: map['status'] as String,
  );
}

Map<String, dynamic> transactionToMap(TransactionModel tx) {
  return {
    'id': tx.id,
    'merchant': tx.merchant,
    'category': tx.category,
    'amount': tx.amount,
    'date': tx.date,
  };
}

TransactionModel transactionFromMap(Map<String, dynamic> map) {
  return TransactionModel(
    id: map['id'] as String,
    merchant: map['merchant'] as String,
    category: map['category'] as String,
    amount: (map['amount'] as num).toDouble(),
    date: map['date'] as String,
  );
}

Map<String, dynamic> recommendationToMap(Recommendation rec) {
  return {
    'id': rec.id,
    'type': rec.type,
    'title': rec.title,
    'subtitle': rec.subtitle,
    'actionLabel': rec.actionLabel,
    'priority': rec.priority,
    'completed': rec.completed,
    'actionRoute': rec.actionRoute,
  };
}

Recommendation recommendationFromMap(Map<String, dynamic> map) {
  return Recommendation(
    id: map['id'] as String,
    type: map['type'] as String,
    title: map['title'] as String,
    subtitle: map['subtitle'] as String,
    actionLabel: map['actionLabel'] as String,
    priority: map['priority'] as int,
    completed: map['completed'] as bool,
    actionRoute: map['actionRoute'] as String,
  );
}

Map<String, dynamic> serviceToMap(ServiceModel service) {
  return {
    'id': service.id,
    'name': service.name,
    'category': service.category,
    'isNew': service.isNew,
    'isActivated': service.isActivated,
    'badge': service.badge,
  };
}

ServiceModel serviceFromMap(Map<String, dynamic> map) {
  return ServiceModel(
    id: map['id'] as String,
    name: map['name'] as String,
    category: map['category'] as String,
    isNew: (map['isNew'] as bool?) ?? false,
    isActivated: (map['isActivated'] as bool?) ?? false,
    badge: map['badge'] as String?,
  );
}

// User Profile state management
class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(MockData.initialUser) {
    _loadFromHive();
  }

  void _loadFromHive() {
    final box = Hive.box('settings');
    final userJson = box.get('current_user_profile') as String?;
    if (userJson != null) {
      try {
        final map = jsonDecode(userJson) as Map<String, dynamic>;
        state = userProfileFromMap(map);
      } catch (_) {}
    }
  }

  void _saveToHive() {
    final box = Hive.box('settings');
    box.put('current_user_profile', jsonEncode(userProfileToMap(state)));
  }

  void completeKyc() {
    state = state.copyWith(
      kycComplete: true, 
      financialHealthScore: (state.financialHealthScore + 6).clamp(0, 100),
    );
    _saveToHive();
  }

  void enableUpi() {
    state = state.copyWith(
      upiEnabled: true, 
      financialHealthScore: (state.financialHealthScore + 5).clamp(0, 100),
    );
    _saveToHive();
  }
  
  void updateBalance(double newBalance) {
    state = state.copyWith(balance: newBalance);
    _saveToHive();
  }

  void incrementGoals() {
    state = state.copyWith(
      hasGoal: true, 
      goalCount: state.goalCount + 1,
    );
    _saveToHive();
  }

  void completeOnboarding() {
    state = state.copyWith(newUser: false);
    _saveToHive();
  }

  void loadProfilePreset(UserProfile preset) {
    state = preset;
    _saveToHive();
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});

// Goals state management with User ID dependency & Persistence
class GoalsNotifier extends StateNotifier<List<FinancialGoal>> {
  final Ref ref;
  GoalsNotifier(this.ref) : super([]) {
    _loadFromHive();
  }

  void _loadFromHive() {
    final user = ref.read(userProfileProvider);
    final box = Hive.box('settings');
    final goalsJson = box.get('goals_${user.userId}') as String?;
    if (goalsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(goalsJson);
        state = decoded.map((m) => financialGoalFromMap(m as Map<String, dynamic>)).toList();
      } catch (_) {
        state = _getDefaultGoalsForUser(user.userId);
      }
    } else {
      state = _getDefaultGoalsForUser(user.userId);
    }
  }

  List<FinancialGoal> _getDefaultGoalsForUser(String userId) {
    if (userId == 'u005') return MockData.aishaGoals;
    if (userId == 'u006') return MockData.vikramGoals;
    if (userId == 'u003' || userId == 'u004') return [];
    return MockData.initialGoals;
  }

  void _saveToHive() {
    final user = ref.read(userProfileProvider);
    final box = Hive.box('settings');
    final listMap = state.map((g) => financialGoalToMap(g)).toList();
    box.put('goals_${user.userId}', jsonEncode(listMap));
  }

  void addGoal(FinancialGoal goal) {
    state = [...state, goal];
    _saveToHive();
  }

  void setGoals(List<FinancialGoal> goals) {
    state = goals;
    _saveToHive();
  }

  void saveToGoal(String id, double amount) {
    state = [
      for (final goal in state)
        if (goal.id == id)
          goal.copyWith(savedAmount: goal.savedAmount + amount)
        else
          goal
    ];
    _saveToHive();
  }
}

final goalsProvider = StateNotifierProvider<GoalsNotifier, List<FinancialGoal>>((ref) {
  ref.watch(userProfileProvider.select((u) => u.userId));
  return GoalsNotifier(ref);
});

// Recommendations state management with User ID dependency & Persistence
class RecommendationsNotifier extends StateNotifier<List<Recommendation>> {
  final Ref ref;
  RecommendationsNotifier(this.ref) : super([]) {
    _loadFromHive();
  }

  void _loadFromHive() {
    final user = ref.read(userProfileProvider);
    final box = Hive.box('settings');
    final recsJson = box.get('recommendations_${user.userId}') as String?;
    if (recsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(recsJson);
        state = decoded.map((m) => recommendationFromMap(m as Map<String, dynamic>)).toList();
      } catch (_) {
        state = _getDefaultRecsForUser(user.userId);
      }
    } else {
      state = _getDefaultRecsForUser(user.userId);
    }
  }

  List<Recommendation> _getDefaultRecsForUser(String userId) {
    if (userId == 'u002') {
      return MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc' || r.id == 'r_upi') {
          return r.copyWith(completed: true);
        }
        return r;
      }).toList();
    }
    if (userId == 'u004') {
      return MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc') return r.copyWith(completed: true);
        return r;
      }).toList();
    }
    if (userId == 'u005') {
      return MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc' || r.id == 'r_upi') {
          return r.copyWith(completed: true);
        }
        return r;
      }).toList();
    }
    if (userId == 'u006') {
      return MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc') return r.copyWith(completed: true);
        return r;
      }).toList();
    }
    return MockData.initialRecommendations;
  }

  void _saveToHive() {
    final user = ref.read(userProfileProvider);
    final box = Hive.box('settings');
    final listMap = state.map((r) => recommendationToMap(r)).toList();
    box.put('recommendations_${user.userId}', jsonEncode(listMap));
  }

  void completeRecommendation(String id) {
    state = [
      for (final rec in state)
        if (rec.id == id)
          rec.copyWith(completed: true)
        else
          rec
    ];
    _saveToHive();
  }

  void setRecommendations(List<Recommendation> recs) {
    state = recs;
    _saveToHive();
  }
}

final recommendationsProvider = StateNotifierProvider<RecommendationsNotifier, List<Recommendation>>((ref) {
  ref.watch(userProfileProvider.select((u) => u.userId));
  return RecommendationsNotifier(ref);
});

// Weekly Story provider (static mapping)
final weeklyStoryProvider = Provider<WeeklyStory>((ref) {
  return MockData.mockStory;
});

// Services state management
class ServicesNotifier extends StateNotifier<List<ServiceModel>> {
  ServicesNotifier() : super(MockData.initialServices) {
    _loadFromHive();
  }

  void _loadFromHive() {
    final box = Hive.box('settings');
    final servicesJson = box.get('services') as String?;
    if (servicesJson == null) return;
    try {
      final List<dynamic> decoded = jsonDecode(servicesJson);
      state = decoded.map((m) => serviceFromMap(m as Map<String, dynamic>)).toList();
    } catch (_) {
      state = MockData.initialServices;
    }
  }

  void _saveToHive() {
    final box = Hive.box('settings');
    final listMap = state.map((s) => serviceToMap(s)).toList();
    box.put('services', jsonEncode(listMap));
  }

  void activateService(String id) {
    final exists = state.any((service) => service.id == id);
    if (!exists && id == 's_autosave') {
      state = [
        ...state,
        const ServiceModel(
          id: 's_autosave',
          name: 'Auto-Save Round Up',
          category: 'Accounts',
          isActivated: true,
          isNew: true,
          badge: 'Smart',
        ),
      ];
      _saveToHive();
      return;
    }

    state = [
      for (final service in state)
        if (service.id == id)
          service.copyWith(isActivated: true)
        else
          service
    ];
    _saveToHive();
  }
}

final servicesProvider = StateNotifierProvider<ServicesNotifier, List<ServiceModel>>((ref) {
  return ServicesNotifier();
});

// Transactions state management with User ID dependency & Persistence
class TransactionsNotifier extends StateNotifier<List<TransactionModel>> {
  final Ref ref;
  TransactionsNotifier(this.ref) : super([]) {
    _loadFromHive();
  }

  void _loadFromHive() {
    final user = ref.read(userProfileProvider);
    final box = Hive.box('settings');
    final txsJson = box.get('transactions_${user.userId}') as String?;
    if (txsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(txsJson);
        state = decoded.map((m) => transactionFromMap(m as Map<String, dynamic>)).toList();
      } catch (_) {
        state = _getDefaultTxsForUser(user.userId);
      }
    } else {
      state = _getDefaultTxsForUser(user.userId);
    }
  }

  List<TransactionModel> _getDefaultTxsForUser(String userId) {
    if (userId == 'u003') {
      return [MockData.initialTransactions.first]; // Swiggy food only
    }
    if (userId == 'u005') {
      return MockData.aishaTransactions;
    }
    if (userId == 'u006') {
      return MockData.vikramTransactions;
    }
    return MockData.initialTransactions;
  }

  void _saveToHive() {
    final user = ref.read(userProfileProvider);
    final box = Hive.box('settings');
    final listMap = state.map((t) => transactionToMap(t)).toList();
    box.put('transactions_${user.userId}', jsonEncode(listMap));
  }

  void addTransaction(TransactionModel tx) {
    state = [tx, ...state];
    _saveToHive();
  }

  void setTransactions(List<TransactionModel> txs) {
    state = txs;
    _saveToHive();
  }
}

final transactionsProvider = StateNotifierProvider<TransactionsNotifier, List<TransactionModel>>((ref) {
  ref.watch(userProfileProvider.select((u) => u.userId));
  return TransactionsNotifier(ref);
});

// Engagement Tracking and Gamification state management
class EngagementNotifier extends StateNotifier<EngagementState> {
  EngagementNotifier()
      : super(const EngagementState(
          sbiCoins: 120,
          streakCount: 3,
          unlockedAchievements: ['YONO Explorer'],
          trackedEvents: [],
        ));

  void setEngagement(EngagementState engagement) {
    state = engagement;
  }

  void trackEvent(String actionName, {int coins = 15, String details = ''}) {
    final newEvent = EngagementEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      actionName: actionName,
      timestamp: DateTime.now(),
      coinsEarned: coins,
      details: details,
    );

    final updatedEvents = [newEvent, ...state.trackedEvents];
    final updatedCoins = state.sbiCoins + coins;
    final achievements = List<String>.from(state.unlockedAchievements);

    // Dynamic achievement unlocks
    if (updatedEvents.length >= 5 && !achievements.contains('Power User')) {
      achievements.add('Power User');
    }
    if (actionName.contains('Savings Goal') && !achievements.contains('Savings Starter')) {
      achievements.add('Savings Starter');
    }
    if (actionName.contains('Auto-Save') && !achievements.contains('Smart Saver')) {
      achievements.add('Smart Saver');
    }
    if (actionName.contains('KYC') && !achievements.contains('KYC Verified')) {
      achievements.add('KYC Verified');
    }

    state = state.copyWith(
      trackedEvents: updatedEvents,
      sbiCoins: updatedCoins,
      unlockedAchievements: achievements,
      streakCount: state.streakCount + (actionName.contains('Daily Login') ? 1 : 0),
    );
  }
}

final engagementProvider = StateNotifierProvider<EngagementNotifier, EngagementState>((ref) {
  return EngagementNotifier();
});

// Gemini Configuration API Key Provider
final geminiApiKeyProvider = StateProvider<String>((ref) {
  final box = Hive.box('settings');
  return box.get('gemini_api_key', defaultValue: '') as String;
});
