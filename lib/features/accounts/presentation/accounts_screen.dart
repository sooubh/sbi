import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../data/repositories/state_providers.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final goals = ref.watch(goalsProvider);
    final transactions = ref.watch(transactionsProvider);

    // Calculate category spending totals for PieChart
    final Map<String, double> categorySums = {};
    double totalDebit = 0.0;
    
    for (final tx in transactions) {
      if (tx.amount < 0) {
        final amt = tx.amount.abs();
        categorySums[tx.category] = (categorySums[tx.category] ?? 0.0) + amt;
        totalDebit += amt;
      }
    }

    return GradientScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title Header
            Text(
              'Accounts',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Account Summary Card
            SooubhCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Savings Account',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            color: AppTheme.success,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.maskedAccount,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '₹ ${user.balance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Available balance',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Spending Overview (fl_chart)
            Text(
              'Spending Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            SooubhCard(
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                    child: categorySums.isEmpty
                        ? const Center(child: Text('No recent spending found.'))
                        : PieChart(
                            PieChartData(
                              sectionsSpace: 4,
                              centerSpaceRadius: 45,
                              sections: _buildPieChartSections(categorySums, totalDebit),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  // Legends Row
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 8,
                    children: categorySums.keys.map((cat) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(cat),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            cat,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Savings Insight
            SooubhCard(
              hasAiBorder: true,
              child: Row(
                children: [
                  const Icon(Icons.analytics_outlined, color: AppTheme.aiTeal, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Savings Insight',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 13,
                            color: AppTheme.aiTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Food spending is up 8% this week. Consider rounding up spare change via Auto-Save.',
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

            // Active Goal Tracker progress bar
            if (goals.isNotEmpty) ...[
              Text(
                'Active Goal',
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

            // Recent Transactions History list
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            SooubhCard(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(tx.category).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getTransactionIcon(tx.category),
                        color: _getCategoryColor(tx.category),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      tx.merchant,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      tx.date,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Text(
                      '${tx.isCredit ? "+" : "-"} ₹${tx.amount.abs().toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 15,
                        color: tx.isCredit ? AppTheme.success : AppTheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(Map<String, double> categorySums, double totalDebit) {
    if (totalDebit == 0) return [];
    
    return categorySums.entries.map((entry) {
      final percentage = (entry.value / totalDebit) * 100;
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return const Color(0xFF5E35B1); // Indigo
      case 'Bills':
        return AppTheme.error; // Red
      case 'Travel':
        return AppTheme.warning; // Amber
      case 'Savings':
        return AppTheme.aiTeal; // Teal
      default:
        return AppTheme.sbiBlue;
    }
  }

  IconData _getTransactionIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant_rounded;
      case 'Bills':
        return Icons.power_rounded;
      case 'Travel':
        return Icons.directions_car_rounded;
      case 'Savings':
        return Icons.savings_rounded;
      default:
        return Icons.payment_rounded;
    }
  }
}
