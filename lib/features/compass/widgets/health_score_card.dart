import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/health_score.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/score_trend_chart.dart';
import '../../../widgets/trend_chip.dart';

/// Financial Health Score card (PRD Feature 2): gauge, trend, section
/// breakdown, 6-month history chart and an expandable AI explanation.
class HealthScoreCard extends StatelessWidget {
  const HealthScoreCard({super.key, required this.score});

  final HealthScore score;

  @override
  Widget build(BuildContext context) {
    final delta = score.history.length < 2
        ? 0
        : score.history.last - score.history.first;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 92,
                height: 92,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: score.total / 100,
                      strokeWidth: 8,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.divider,
                      valueColor: const AlwaysStoppedAnimation(AppColors.blue),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${score.total}',
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.ink)),
                          const Text('/100', style: TextStyle(fontSize: 11, color: AppColors.slate)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Insets.l),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Financial Health',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink)),
                    const SizedBox(height: 6),
                    TrendChip(
                      label: '${score.trendDelta >= 0 ? '+' : ''}${score.trendDelta} this month',
                      direction: score.trendDelta >= 0 ? TrendDirection.up : TrendDirection.down,
                    ),
                    const SizedBox(height: 6),
                    const Text('Good standing', style: TextStyle(fontSize: 13, color: AppColors.slate)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.m),
          const Divider(height: 1),
          const SizedBox(height: Insets.m),
          for (final section in score.sections) ...[
            Row(
              children: [
                SizedBox(
                  width: 96,
                  child: Text(section.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink)),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Corners.chip),
                    child: LinearProgressIndicator(
                      value: section.score / 100,
                      minHeight: 6,
                      backgroundColor: AppColors.divider,
                      valueColor: const AlwaysStoppedAnimation(AppColors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: Insets.s),
                SizedBox(
                  width: 28,
                  child: Text('${section.score}',
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.deepBlue)),
                ),
              ],
            ),
            const SizedBox(height: Insets.s + 2),
          ],
          const Divider(height: 1),
          const SizedBox(height: Insets.m),
          Row(
            children: [
              const Text('6-month trend',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.ink)),
              const Spacer(),
              Text(
                '${delta >= 0 ? '+' : ''}$delta pts',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: delta >= 0 ? AppColors.success : AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.s),
          ScoreTrendChart(history: score.history),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: Insets.s),
              leading: const Icon(Icons.auto_awesome_rounded, size: 18, color: AppColors.deepBlue),
              title: const Text('How is this calculated?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.deepBlue)),
              children: [
                Text(score.aiExplanation,
                    style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.slate)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
