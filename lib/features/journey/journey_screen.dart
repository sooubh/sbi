import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../models/journey.dart';
import '../../services/journey_service.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/staggered_item.dart';

/// Compass Journey: the user's financial story told through privacy-safe
/// behavioral milestones — never raw transaction history.
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journey = ref.watch(journeyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Journey')),
      body: journey.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.deepBlue),
        ),
        error: (_, __) => _ErrorState(onRetry: () => ref.invalidate(journeyProvider)),
        data: (data) =>
            data.isEmpty ? const _EmptyState() : _JourneyList(journey: data),
      ),
    );
  }
}

class _JourneyList extends StatelessWidget {
  const _JourneyList({required this.journey});

  final JourneyData journey;

  @override
  Widget build(BuildContext context) {
    var stagger = 0;
    return ListView(
      padding: const EdgeInsets.all(Insets.m),
      children: [
        StaggeredItem(index: stagger++, child: _JourneyHero(journey: journey)),
        const SizedBox(height: Insets.s),
        const SectionHeader(title: 'Achievements'),
        StaggeredItem(
          index: stagger++,
          child: Wrap(
            spacing: Insets.s,
            runSpacing: Insets.s,
            children: [for (final badge in journey.badges) _BadgeChip(badge: badge)],
          ),
        ),
        const SizedBox(height: Insets.m),
        for (final month in journey.months) ...[
          StaggeredItem(
            index: stagger++,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Insets.s),
              child: Row(
                children: [
                  Text(month.label,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
                  const Spacer(),
                  Text(month.summary,
                      style: const TextStyle(fontSize: 12, color: AppColors.slate)),
                ],
              ),
            ),
          ),
          for (var i = 0; i < month.moments.length; i++)
            StaggeredItem(
              index: stagger++,
              child: _MomentRow(
                moment: month.moments[i],
                isLast: i == month.moments.length - 1,
              ),
            ),
          const SizedBox(height: Insets.s),
        ],
      ],
    );
  }
}

class _JourneyHero extends StatelessWidget {
  const _JourneyHero({required this.journey});

  final JourneyData journey;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      gradient: const LinearGradient(
        colors: [AppColors.deepBlue, AppColors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your financial journey',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 4),
          Text(
            'Behavioral milestones and highlights — never transactions, balances or account numbers.',
            style: TextStyle(fontSize: 13, height: 1.4, color: Colors.white.withValues(alpha: 0.9)),
          ),
          const SizedBox(height: Insets.m),
          Row(
            children: [
              _Stat(value: '${journey.months.length}', label: 'Months'),
              _Stat(value: '${journey.earnedBadges}/${journey.badges.length}', label: 'Badges'),
              _Stat(
                value: '${journey.months.fold<int>(0, (sum, m) => sum + m.moments.length)}',
                label: 'Milestones',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
          Text(label,
              style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8))),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final JourneyBadge badge;

  static const _icons = <String, IconData>{
    'consistent_saver': Icons.savings_rounded,
    'goal_getter': Icons.flag_rounded,
    'health_improver': Icons.monitor_heart_rounded,
    'explorer': Icons.flight_takeoff_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final earned = badge.earned;
    final fg = earned ? AppColors.success : AppColors.slate;
    return Tooltip(
      message: badge.description,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: earned ? AppColors.successBg : AppColors.background,
          borderRadius: BorderRadius.circular(Corners.chip),
          border: Border.all(color: earned ? AppColors.success : AppColors.divider),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(earned ? _icons[badge.id] ?? Icons.emoji_events_rounded : Icons.lock_rounded,
                size: 15, color: fg),
            const SizedBox(width: 6),
            Text(badge.label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg)),
          ],
        ),
      ),
    );
  }
}

class _MomentRow extends StatelessWidget {
  const _MomentRow({required this.moment, required this.isLast});

  final JourneyMoment moment;
  final bool isLast;

  static (Color, Color, IconData) _style(JourneyMomentType type) => switch (type) {
        JourneyMomentType.goalMilestone =>
          (AppColors.successBg, AppColors.success, Icons.flag_rounded),
        JourneyMomentType.scoreChange =>
          (AppColors.lightBlue, AppColors.deepBlue, Icons.monitor_heart_rounded),
        JourneyMomentType.lifeEvent =>
          (AppColors.warningBg, AppColors.warning, Icons.bolt_rounded),
        JourneyMomentType.recommendation =>
          (AppColors.lightBlue, AppColors.deepBlue, Icons.lightbulb_rounded),
        JourneyMomentType.savingsStreak =>
          (AppColors.successBg, AppColors.success, Icons.savings_rounded),
      };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, icon) = _style(moment.type);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 18),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: AppColors.deepBlue, shape: BoxShape.circle),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: AppColors.divider),
                  ),
              ],
            ),
          ),
          const SizedBox(width: Insets.s),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: Insets.s + 4),
              child: AppCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                      child: Icon(icon, size: 18, color: fg),
                    ),
                    const SizedBox(width: Insets.m),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(moment.title,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)),
                          const SizedBox(height: 3),
                          Text(moment.descriptionSafe,
                              style: const TextStyle(fontSize: 12.5, height: 1.4, color: AppColors.slate)),
                          const SizedBox(height: 5),
                          Text(DateFormat('d MMM').format(moment.timestamp),
                              style: const TextStyle(fontSize: 11, color: AppColors.slate)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(Insets.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.route_rounded, size: 44, color: AppColors.slate),
            SizedBox(height: Insets.m),
            Text('Your journey starts here',
                style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
            SizedBox(height: Insets.xs),
            Text(
              'As Compass notices safe behavioral milestones, they will appear in your story.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.slate),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Insets.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 44, color: AppColors.warning),
            const SizedBox(height: Insets.m),
            const Text('Could not load your journey',
                style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
            const SizedBox(height: Insets.m),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(160, 44)),
              onPressed: onRetry,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
