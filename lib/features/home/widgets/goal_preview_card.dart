import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/goal.dart';
import '../../../widgets/app_card.dart';

/// Compact goal progress preview used on the Home Dashboard.
class GoalPreviewCard extends StatelessWidget {
  const GoalPreviewCard({super.key, required this.goal});

  final Goal goal;

  static const _icons = <String, IconData>{
    'emergency': Icons.health_and_safety_rounded,
    'travel': Icons.flight_takeoff_rounded,
    'vehicle': Icons.two_wheeler_rounded,
    'education': Icons.school_rounded,
    'family': Icons.family_restroom_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
            child: Icon(_icons[goal.category] ?? Icons.flag_rounded, size: 20, color: AppColors.deepBlue),
          ),
          const SizedBox(width: Insets.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(goal.name, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Corners.chip),
                  child: LinearProgressIndicator(
                    value: goal.progressPercent / 100,
                    minHeight: 6,
                    backgroundColor: AppColors.divider,
                    valueColor: const AlwaysStoppedAnimation(AppColors.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Insets.m),
          Text('${goal.progressPercent}%',
              style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.deepBlue)),
        ],
      ),
    );
  }
}
