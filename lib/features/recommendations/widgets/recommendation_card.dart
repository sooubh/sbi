import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/recommendation.dart';
import '../../../services/demo_feed_service.dart';
import '../../../widgets/app_card.dart';

/// Recommendation card (PRD Feature 6) with the mandatory "why this was
/// suggested" reason label and save/dismiss actions.
class RecommendationCard extends ConsumerWidget {
  const RecommendationCard({super.key, required this.recommendation, this.showActions = true});

  final Recommendation recommendation;
  final bool showActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(recommendationsProvider.notifier);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
                child: const Icon(Icons.lightbulb_rounded, size: 18, color: AppColors.deepBlue),
              ),
              const SizedBox(width: Insets.s + 4),
              Expanded(
                child: Text(recommendation.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
              ),
              if (recommendation.status == RecommendationStatus.saved)
                const Icon(Icons.bookmark_rounded, size: 18, color: AppColors.deepBlue),
            ],
          ),
          const SizedBox(height: Insets.s + 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Insets.s + 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Why: ${recommendation.reason}',
              style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.slate),
            ),
          ),
          if (showActions && recommendation.status == RecommendationStatus.active) ...[
            const SizedBox(height: Insets.s),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    notifier.setStatus(recommendation.id, RecommendationStatus.dismissed);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recommendation dismissed.')),
                    );
                  },
                  child: const Text('Dismiss', style: TextStyle(color: AppColors.slate)),
                ),
                const SizedBox(width: Insets.xs),
                FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    backgroundColor: AppColors.lightBlue,
                    foregroundColor: AppColors.deepBlue,
                  ),
                  onPressed: () {
                    notifier.setStatus(recommendation.id, RecommendationStatus.saved);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Saved — ${recommendation.actionLabel}.')),
                    );
                  },
                  child: Text(recommendation.actionLabel),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
