import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/goal_icons.dart';
import '../../../models/goal.dart';
import '../../../services/user_settings.dart';
import '../../../widgets/app_card.dart';

/// Full Goal Coach card (PRD Feature 4): progress, milestone badges and
/// an AI nudge that respects the goal-tracking permission.
class GoalCard extends ConsumerWidget {
  const GoalCard({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalTracking = ref.watch(userSettingsProvider).goalTracking;
    final reached = goal.reachedMilestones;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
                child: Icon(goalIcon(goal.category), size: 20, color: AppColors.deepBlue),
              ),
              const SizedBox(width: Insets.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.name, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                    Text(goal.status == 'active' ? 'Active' : goal.status,
                        style: const TextStyle(fontSize: 12, color: AppColors.slate)),
                  ],
                ),
              ),
              Text('${goal.progressPercent}%',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.deepBlue)),
            ],
          ),
          const SizedBox(height: Insets.m),
          ClipRRect(
            borderRadius: BorderRadius.circular(Corners.chip),
            child: LinearProgressIndicator(
              value: goal.progressPercent / 100,
              minHeight: 8,
              backgroundColor: AppColors.divider,
              valueColor: const AlwaysStoppedAnimation(AppColors.blue),
            ),
          ),
          const SizedBox(height: Insets.m),
          Row(
            children: [
              for (final milestone in Goal.milestones) ...[
                _MilestoneBadge(percent: milestone, reached: reached.contains(milestone)),
                const SizedBox(width: Insets.s),
              ],
            ],
          ),
          if (goalTracking && goal.aiNudge != null) ...[
            const SizedBox(height: Insets.m),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Insets.s + 4),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.deepBlue),
                  const SizedBox(width: Insets.s),
                  Expanded(
                    child: Text(goal.aiNudge!,
                        style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.deepBlue)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MilestoneBadge extends StatelessWidget {
  const _MilestoneBadge({required this.percent, required this.reached});

  final int percent;
  final bool reached;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: reached ? AppColors.successBg : AppColors.background,
        borderRadius: BorderRadius.circular(Corners.chip),
        border: Border.all(color: reached ? AppColors.success : AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            percent == 100 ? Icons.emoji_events_rounded : Icons.check_circle_rounded,
            size: 13,
            color: reached ? AppColors.success : AppColors.slate,
          ),
          const SizedBox(width: 4),
          Text('$percent%',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: reached ? AppColors.success : AppColors.slate,
              )),
        ],
      ),
    );
  }
}
