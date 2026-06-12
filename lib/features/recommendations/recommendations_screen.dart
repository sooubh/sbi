import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../models/recommendation.dart';
import '../../services/demo_feed_service.dart';
import '../../widgets/section_header.dart';
import 'widgets/recommendation_card.dart';

/// Recommendations screen (PRD Screen 8): suggestion cards with reason
/// labels and dismiss/save actions; saved items listed separately.
class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final all = ref.watch(recommendationsProvider);
    final active = all.where((r) => r.status == RecommendationStatus.active).toList();
    final saved = all.where((r) => r.status == RecommendationStatus.saved).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Insets.m),
        children: [
          if (active.isEmpty && saved.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: Insets.xl),
              child: Center(
                child: Text('All caught up — no recommendations right now.',
                    style: TextStyle(color: AppColors.slate)),
              ),
            ),
          for (final rec in active) ...[
            RecommendationCard(recommendation: rec),
            const SizedBox(height: Insets.s + 4),
          ],
          if (saved.isNotEmpty) ...[
            const SizedBox(height: Insets.xs),
            const SectionHeader(title: 'Saved'),
            for (final rec in saved) ...[
              RecommendationCard(recommendation: rec, showActions: false),
              const SizedBox(height: Insets.s + 4),
            ],
          ],
        ],
      ),
    );
  }
}
