import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/circular_score_ring.dart';
import '../../../data/repositories/state_providers.dart';
import '../widgets/weekly_story_modal.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isBalanceVisible = false;

  void _simulateAction(String id, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.aiTeal),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Processing...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: Text(
            'Sooubh AI is configuring your setup for "$title". Please wait.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );

    // Complete the action after 2 seconds
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.of(context).pop(); // Close processing dialog

      // Execute state changes
      if (id == 'r_kyc') {
        ref.read(userProfileProvider.notifier).completeKyc();
      } else if (id == 'r_upi') {
        ref.read(userProfileProvider.notifier).enableUpi();
      }
      
      ref.read(recommendationsProvider.notifier).completeRecommendation(id);

      // Track engagement and award points
      ref.read(engagementProvider.notifier).trackEvent(
        'Completed Recommendation: $title',
        coins: 50,
        details: 'Recommendation completed: $id',
      );

      // Show Success Toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text('Success! "$title" completed.'),
            ],
          ),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProfileProvider);
    final goals = ref.watch(goalsProvider);
    final recommendations = ref.watch(recommendationsProvider);
    final story = ref.watch(weeklyStoryProvider);
    final engagement = ref.watch(engagementProvider);

    // Filter incomplete recommendations
    final activeRecommendations = recommendations
        .where((rec) => !rec.completed)
        .toList()
      ..sort((a, b) => a.priority.compareTo(b.priority));

    return GradientScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning, ${user.name}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sooubh AI Engagement Layer',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications are up to date.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_outlined, color: AppTheme.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Balance Card
            SooubhCard(
              useGradient: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.maskedAccount,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                          ref.read(engagementProvider.notifier).trackEvent(
                            'Toggled Balance Visibility',
                            coins: 5,
                            details: 'Checked balance visibility to ${_isBalanceVisible ? "Visible" : "Hidden"}',
                          );
                        },
                        icon: Icon(
                          _isBalanceVisible 
                              ? Icons.visibility_off_outlined 
                              : Icons.visibility_outlined,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isBalanceVisible 
                        ? '₹ ${user.balance.toStringAsFixed(2)}' 
                        : '₹ ••••••••',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Available Balance · Primary Savings',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickActionButton(
                  icon: Icons.send_rounded,
                  label: 'Send',
                  onTap: () => _showActionAlert('Send Money'),
                ),
                _buildQuickActionButton(
                  icon: Icons.qr_code_scanner_rounded,
                  label: 'Scan',
                  onTap: () => _showActionAlert('Scan & Pay'),
                ),
                _buildQuickActionButton(
                  icon: Icons.receipt_long_rounded,
                  label: 'Pay',
                  onTap: () => _showActionAlert('Pay Bills'),
                ),
                _buildQuickActionButton(
                  icon: Icons.arrow_downward_rounded,
                  label: 'Request',
                  onTap: () => _showActionAlert('Request Money'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Financial Health Section
            Text(
              'Financial Health',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            SooubhCard(
              child: Row(
                children: [
                  CircularScoreRing(score: user.financialHealthScore),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wellness Score',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _getHealthStatus(user.financialHealthScore),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.aiTeal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your score goes up as you set up security alerts, enable UPI, and create targets.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rewards & Streak Card
            Text(
              'YONO Rewards & Achievements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            SooubhCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 28),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${engagement.streakCount}-Day Streak',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Keep logging in daily!',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amber.shade700, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.monetization_on_rounded, color: Colors.amber.shade700, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              '${engagement.sbiCoins}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 16,
                                  color: Colors.amber.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 0.8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Badges',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: engagement.unlockedAchievements.map((badge) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppTheme.aiTeal.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.workspace_premium_rounded, color: AppTheme.aiTeal, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                badge,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.aiTeal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Weekly Story Banner Card
            SooubhCard(
              onTap: () {
                ref.read(engagementProvider.notifier).trackEvent(
                  'Viewed Weekly Story',
                  coins: 15,
                  details: 'Opened weekly story slider',
                );
                WeeklyStoryModal.show(context, story);
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.sbiBlue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_stories_rounded, color: AppTheme.sbiBlue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Story Overview',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tap to view your week summary insights',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sooubh Insight Card (Layer 2)
            SooubhCard(
              hasAiBorder: true,
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline_rounded, color: AppTheme.aiTeal, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sooubh Insight',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 13,
                                color: AppTheme.aiTeal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.aiTeal.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'AI',
                                style: TextStyle(
                                  color: AppTheme.aiTeal,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'You saved ₹1,200 more this week than last week. Great progress!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Goals Progress Card (Active Goal)
            if (goals.isNotEmpty) ...[
              Text(
                'Active Savings Goals',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              SooubhCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '🎯 ${goals.first.name}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${goals.first.progressPercent}% Completed',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.aiTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: goals.first.progress,
                        minHeight: 8,
                        backgroundColor: AppTheme.background,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.aiTeal),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saved: ₹${goals.first.savedAmount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Target: ₹${goals.first.targetAmount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Next Best Actions List (Layer 1 - Rule Engine suggestions)
            Text(
              'Next Best Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            if (activeRecommendations.isEmpty)
              const SooubhCard(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text('All tasks are complete! Your account is fully optimized.'),
                  ),
                ),
              )
            else
              Column(
                children: activeRecommendations.map((rec) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: SooubhCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.aiTeal.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.star_outline_rounded, color: AppTheme.aiTeal, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  rec.title,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            rec.subtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrimaryButton(
                                label: rec.actionLabel,
                                onPressed: () => _simulateAction(rec.id, rec.title),
                                isAiAction: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.sbiBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.sbiBlue, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHealthStatus(int score) {
    if (score >= 90) return 'Excellent (Optimized Setup)';
    if (score >= 80) return 'Good Financial Health';
    if (score >= 50) return 'Moderate Setup';
    return 'Needs Attention';
  }

  void _showActionAlert(String action) {
    ref.read(engagementProvider.notifier).trackEvent(
      'Quick Action: $action',
      coins: 10,
      details: 'User tapped quick action: $action',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quick action "$action" launched.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
