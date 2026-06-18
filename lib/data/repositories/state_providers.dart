import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../models/financial_goal.dart';
import '../models/recommendation.dart';
import '../models/weekly_story.dart';
import '../models/service_model.dart';
import '../models/transaction_model.dart';
import '../mock/mock_data.dart';

// User Profile state management
class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(MockData.initialUser);

  void completeKyc() {
    state = state.copyWith(
      kycComplete: true, 
      financialHealthScore: (state.financialHealthScore + 6).clamp(0, 100),
    );
  }

  void enableUpi() {
    state = state.copyWith(
      upiEnabled: true, 
      financialHealthScore: (state.financialHealthScore + 5).clamp(0, 100),
    );
  }
  
  void updateBalance(double newBalance) {
    state = state.copyWith(balance: newBalance);
  }

  void incrementGoals() {
    state = state.copyWith(
      hasGoal: true, 
      goalCount: state.goalCount + 1,
    );
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});

// Goals state management
class GoalsNotifier extends StateNotifier<List<FinancialGoal>> {
  GoalsNotifier() : super(MockData.initialGoals);

  void addGoal(FinancialGoal goal) {
    state = [...state, goal];
  }

  void saveToGoal(String id, double amount) {
    state = [
      for (final goal in state)
        if (goal.id == id)
          goal.copyWith(savedAmount: goal.savedAmount + amount)
        else
          goal
    ];
  }
}

final goalsProvider = StateNotifierProvider<GoalsNotifier, List<FinancialGoal>>((ref) {
  return GoalsNotifier();
});

// Recommendations (Next Best Actions) state management
class RecommendationsNotifier extends StateNotifier<List<Recommendation>> {
  RecommendationsNotifier() : super(MockData.initialRecommendations);

  void completeRecommendation(String id) {
    state = [
      for (final rec in state)
        if (rec.id == id)
          rec.copyWith(completed: true)
        else
          rec
    ];
  }
}

final recommendationsProvider = StateNotifierProvider<RecommendationsNotifier, List<Recommendation>>((ref) {
  return RecommendationsNotifier();
});

// Weekly Story provider (static mapping)
final weeklyStoryProvider = Provider<WeeklyStory>((ref) {
  return MockData.mockStory;
});

// Services state management
class ServicesNotifier extends StateNotifier<List<ServiceModel>> {
  ServicesNotifier() : super(MockData.initialServices);

  void activateService(String id) {
    state = [
      for (final service in state)
        if (service.id == id)
          service.copyWith(isActivated: true)
        else
          service
    ];
  }
}

final servicesProvider = StateNotifierProvider<ServicesNotifier, List<ServiceModel>>((ref) {
  return ServicesNotifier();
});

// Transactions state management
class TransactionsNotifier extends StateNotifier<List<TransactionModel>> {
  TransactionsNotifier() : super(MockData.initialTransactions);

  void addTransaction(TransactionModel tx) {
    state = [tx, ...state];
  }
}

final transactionsProvider = StateNotifierProvider<TransactionsNotifier, List<TransactionModel>>((ref) {
  return TransactionsNotifier();
});
