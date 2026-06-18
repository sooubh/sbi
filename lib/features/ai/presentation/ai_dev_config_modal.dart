import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../data/repositories/state_providers.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/mock/mock_data.dart';
import '../engine/ai_engine.dart';

class AiDevConfigModal extends ConsumerStatefulWidget {
  const AiDevConfigModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AiDevConfigModal(),
    );
  }

  @override
  ConsumerState<AiDevConfigModal> createState() => _AiDevConfigModalState();
}

class _AiDevConfigModalState extends ConsumerState<AiDevConfigModal> {
  late TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    final currentKey = ref.read(geminiApiKeyProvider);
    _apiKeyController = TextEditingController(text: currentKey);
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  void _saveApiKey() {
    final newKey = _apiKeyController.text.trim();
    final box = Hive.box('settings');
    box.put('gemini_api_key', newKey);
    ref.read(geminiApiKeyProvider.notifier).state = newKey;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newKey.isEmpty 
            ? 'API Key cleared. Using offline rules.' 
            : 'Gemini API Key saved successfully!'),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _loadPreset(UserProfile profile) {
    ref.read(userProfileProvider.notifier).loadProfilePreset(profile);

    // Contextually adjust goals, transactions, and recommendations
    if (profile.userId == 'u002') {
      // HNW Priya
      ref.read(goalsProvider.notifier).setGoals(MockData.initialGoals);
      ref.read(transactionsProvider.notifier).setTransactions(MockData.initialTransactions);
      ref.read(recommendationsProvider.notifier).setRecommendations(MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc' || r.id == 'r_upi') {
          return r.copyWith(completed: true);
        }
        return r;
      }).toList());
    } else if (profile.userId == 'u003') {
      // Student Rahul
      ref.read(goalsProvider.notifier).setGoals([]);
      ref.read(transactionsProvider.notifier).setTransactions([
        MockData.initialTransactions.first, // Swiggy
      ]);
      ref.read(recommendationsProvider.notifier).setRecommendations(MockData.initialRecommendations);
    } else if (profile.userId == 'u004') {
      // Senior Amit
      ref.read(goalsProvider.notifier).setGoals([]);
      ref.read(transactionsProvider.notifier).setTransactions(MockData.initialTransactions);
      ref.read(recommendationsProvider.notifier).setRecommendations(MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc') return r.copyWith(completed: true);
        return r;
      }).toList());
    } else if (profile.userId == 'u005') {
      // Salaried Aisha
      ref.read(goalsProvider.notifier).setGoals(MockData.aishaGoals);
      ref.read(transactionsProvider.notifier).setTransactions(MockData.aishaTransactions);
      ref.read(recommendationsProvider.notifier).setRecommendations(MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc' || r.id == 'r_upi') {
          return r.copyWith(completed: true);
        }
        return r;
      }).toList());
    } else if (profile.userId == 'u006') {
      // Freelancer Vikram
      ref.read(goalsProvider.notifier).setGoals(MockData.vikramGoals);
      ref.read(transactionsProvider.notifier).setTransactions(MockData.vikramTransactions);
      ref.read(recommendationsProvider.notifier).setRecommendations(MockData.initialRecommendations.map((r) {
        if (r.id == 'r_kyc') return r.copyWith(completed: true);
        return r;
      }).toList());
    } else {
      // Default Sourabh
      ref.read(goalsProvider.notifier).setGoals(MockData.initialGoals);
      ref.read(transactionsProvider.notifier).setTransactions(MockData.initialTransactions);
      ref.read(recommendationsProvider.notifier).setRecommendations(MockData.initialRecommendations);
    }

    ref.read(engagementProvider.notifier).trackEvent(
      'Loaded Preset: ${profile.name}',
      coins: 20,
      details: 'Switched user profile to ${profile.name} with customized balance and statuses',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile switched to ${profile.name}!'),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final models = ref.watch(localAiProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.82 + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.settings_suggest_rounded, color: AppTheme.aiTeal),
                          const SizedBox(width: 8),
                          Text(
                            'AI & Dev Console',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Gemini Setup
                  Text(
                    'Gemini API Key',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.sbiBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Provide a Gemini API key to query Gemini 2.5 Flash. Empty key falls back to rules.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _apiKeyController,
                          obscureText: true,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: 'AIzaSy...',
                            hintStyle: theme.textTheme.bodyMedium,
                            filled: true,
                            fillColor: AppTheme.cardBg,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: _saveApiKey,
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.aiTeal,
                        ),
                        icon: const Icon(Icons.save_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Section 2: Mock Presets
                  Text(
                    'Load Mock Presets (Hackathon Demo)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.sbiBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Instantly switch profiles to demonstrate how the embedded AI logic adapts to user balance and status context.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.45,
                    children: [
                      _buildPresetCard('Sourabh (Default)', 'Bal: ₹1.24L\nKYC: Pending\nUPI: Inactive', MockData.initialUser),
                      _buildPresetCard('Priya (HNW)', 'Bal: ₹8.50L\nKYC: Complete\nUPI: Active', MockData.presetHnw),
                      _buildPresetCard('Rahul (Student)', 'Bal: ₹1.2K\nKYC: Pending\nUPI: Inactive', MockData.presetStudent),
                      _buildPresetCard('Uncle Amit (Senior)', 'Bal: ₹45K\nKYC: Complete\nUPI: Inactive', MockData.presetSenior),
                      _buildPresetCard('Aisha (Salaried)', 'Bal: ₹75K\nKYC: Complete\nUPI: Active', MockData.presetSalaried),
                      _buildPresetCard('Vikram (Freelancer)', 'Bal: ₹2.40L\nKYC: Complete\nUPI: Inactive', MockData.presetFreelancer),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Section 3: Offline Models
                  Text(
                    'Offline llama.cpp LLMs',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.sbiBlue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Demonstrates on-device offline capability with local models.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: models.map((model) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: SooubhCard(
                          margin: EdgeInsets.zero,
                          hasAiBorder: model.isActive,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.name,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Size: ${model.size}',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              if (model.isActive)
                                const Icon(Icons.check_circle_outline_rounded, color: AppTheme.aiTeal)
                              else if (model.isDownloaded)
                                TextButton(
                                  onPressed: () {
                                    ref.read(localAiProvider.notifier).activateModel(model.id);
                                  },
                                  child: const Text('Use'),
                                )
                              else
                                const Icon(Icons.download_for_offline_outlined, color: AppTheme.sbiBlue),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetCard(String title, String details, UserProfile profile) {
    final theme = Theme.of(context);
    final user = ref.watch(userProfileProvider);
    final isSelected = user.userId == profile.userId;

    return SooubhCard(
      margin: EdgeInsets.zero,
      hasAiBorder: isSelected,
      onTap: () => _loadPreset(profile),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppTheme.aiTeal : AppTheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: AppTheme.aiTeal, size: 16),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            details,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
