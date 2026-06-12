import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/demo_data_service.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/insight_explanation_sheet.dart';

/// Hero AI insight card (PRD Feature 1). Tapping reveals the shared
/// explainable "why am I seeing this" sheet — Journey 1.
class CompassInsightCard extends ConsumerWidget {
  const CompassInsightCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insight = ref.watch(heroInsightProvider);

    return AppCard(
      gradient: const LinearGradient(
        colors: [AppColors.deepBlue, AppColors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      onTap: () => showInsightExplanation(context, insight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.explore_rounded, size: 18, color: Colors.white),
              ),
              const SizedBox(width: Insets.s),
              Text(
                'COMPASS INSIGHT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(Corners.chip),
                ),
                child: Text(
                  '${(insight.confidence * 100).round()}% confidence',
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.m),
          Text(
            insight.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            insight.body,
            style: TextStyle(fontSize: 14, height: 1.4, color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: Insets.m),
          Row(
            children: [
              Text(
                'Why am I seeing this?',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.95)),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward_rounded, size: 15, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
