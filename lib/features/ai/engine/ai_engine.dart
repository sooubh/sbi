import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/recommendation.dart';
import '../../../data/models/user_profile.dart';

// Local Model state model
class LocalModel {
  final String id;
  final String name;
  final String size;
  final bool isDownloaded;
  final bool isActive;

  const LocalModel({
    required this.id,
    required this.name,
    required this.size,
    this.isDownloaded = false,
    this.isActive = false,
  });

  LocalModel copyWith({
    String? id,
    String? name,
    String? size,
    bool? isDownloaded,
    bool? isActive,
  }) {
    return LocalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Local AI state provider
class LocalAiNotifier extends StateNotifier<List<LocalModel>> {
  LocalAiNotifier() : super([
    const LocalModel(id: 'tiny_llama', name: 'TinyLlama 1.1B GGUF', size: '640 MB', isDownloaded: true, isActive: true),
    const LocalModel(id: 'gemma_2b', name: 'Gemma 2B Chat GGUF', size: '1.4 GB'),
    const LocalModel(id: 'phi_3', name: 'Phi-3 Mini GGUF', size: '2.2 GB'),
    const LocalModel(id: 'qwen_1_5b', name: 'Qwen 1.5B Instruct GGUF', size: '920 MB'),
  ]);

  void downloadModel(String id) {
    state = [
      for (final model in state)
        if (model.id == id)
          model.copyWith(isDownloaded: true)
        else
          model
    ];
  }

  void activateModel(String id) {
    state = [
      for (final model in state)
        model.copyWith(isActive: model.id == id)
    ];
  }

  void importCustomModel(String name, String size) {
    final custom = LocalModel(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      size: size,
      isDownloaded: true,
      isActive: true,
    );
    // Deactivate others
    state = [
      for (final model in state)
        model.copyWith(isActive: false),
      custom
    ];
  }
}

final localAiProvider = StateNotifierProvider<LocalAiNotifier, List<LocalModel>>((ref) {
  return LocalAiNotifier();
});

// Layer 1 — Rule Engine Logic helper
class RuleEngine {
  static List<Recommendation> evaluateRules(UserProfile user) {
    final List<Recommendation> recs = [];
    
    if (!user.kycComplete) {
      recs.add(const Recommendation(
        id: 'r_kyc',
        type: 'next_best_action',
        title: 'Complete KYC',
        subtitle: 'Complete video KYC to unlock high transfer limits.',
        actionLabel: 'Verify Now',
        priority: 1,
        completed: false,
        actionRoute: '/onboarding/kyc',
      ));
    }
    
    if (!user.upiEnabled) {
      recs.add(const Recommendation(
        id: 'r_upi',
        type: 'next_best_action',
        title: 'Enable UPI',
        subtitle: 'Activate UPI to send payments directly to phone numbers.',
        actionLabel: 'Set Up UPI',
        priority: 2,
        completed: false,
        actionRoute: '/onboarding/upi',
      ));
    }
    
    if (!user.hasGoal) {
      recs.add(const Recommendation(
        id: 'r_goal',
        type: 'next_best_action',
        title: 'Create Savings Goal',
        subtitle: 'Users with visual goals save 3x faster. Set one up.',
        actionLabel: 'Create Goal',
        priority: 3,
        completed: false,
        actionRoute: '/goals/create',
      ));
    }
    
    // Add default cross-sell if primary onboarding steps are done
    recs.add(const Recommendation(
      id: 'r_fd',
      type: 'next_best_action',
      title: 'Start Fixed Deposit',
      subtitle: 'Earn up to 7.2% interest on your idle savings.',
      actionLabel: 'Open FD',
      priority: 4,
      completed: false,
      actionRoute: '/services/fd',
    ));

    return recs;
  }
}

// Layer 2 — Insight Engine Helper
class InsightEngine {
  static String generateInsight(UserProfile user) {
    if (user.financialHealthScore < 70) {
      return 'Action required: Complete onboarding setups to increase safety and digital health.';
    }
    if (!user.upiEnabled) {
      return 'Insight: Setting up UPI speeds up utility bill payments and peer transfers.';
    }
    if (user.goalCount == 0) {
      return 'Insight: Setting up a Goal is proven to keep your savings consistent.';
    }
    return 'You saved ₹1,200 more this week than last week. Great progress!';
  }
}
