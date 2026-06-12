import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/relative_time.dart';
import '../../models/life_event.dart';
import '../../services/demo_feed_service.dart';
import '../../widgets/app_card.dart';

/// Icon for a life-event type — shared by event surfaces.
IconData lifeEventIcon(String type) => switch (type) {
      'travel' => Icons.flight_takeoff_rounded,
      'salary' => Icons.payments_rounded,
      'overspending' => Icons.trending_up_rounded,
      'marriage' => Icons.favorite_rounded,
      'home' => Icons.home_work_rounded,
      'baby' => Icons.child_friendly_rounded,
      'education' => Icons.school_rounded,
      'goal_progress' => Icons.flag_rounded,
      _ => Icons.bolt_rounded,
    };

/// Life Events screen (PRD Screen 5): event cards with detail view and a
/// recommended next action. Everything shown is pattern-level only.
class LifeEventsScreen extends ConsumerWidget {
  const LifeEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(lifeEventsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Life events', style: TextStyle(fontWeight: FontWeight.w800))),
      body: events.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(Insets.l),
                child: Text(
                  'Life event tracking is turned off.\nEnable it in Profile to see detected events.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5, color: AppColors.slate),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(Insets.m),
              itemCount: events.length,
              separatorBuilder: (_, __) => const SizedBox(height: Insets.s + 4),
              itemBuilder: (context, i) {
                final event = events[i];
                return AppCard(
                  onTap: () => showLifeEventDetail(context, event),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
                        child: Icon(lifeEventIcon(event.type), size: 20, color: AppColors.deepBlue),
                      ),
                      const SizedBox(width: Insets.m),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.title,
                                style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                            const SizedBox(height: 2),
                            Text('Detected ${relativeTime(event.detectedAt).toLowerCase()}',
                                style: const TextStyle(fontSize: 12, color: AppColors.slate)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: AppColors.slate),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

/// Detail sheet with the privacy-safe description and next action.
Future<void> showLifeEventDetail(BuildContext context, LifeEvent event) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Corners.sheet)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(Insets.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(lifeEventIcon(event.type), color: AppColors.deepBlue),
              const SizedBox(width: Insets.s),
              Expanded(
                child: Text(event.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
              ),
            ],
          ),
          const SizedBox(height: Insets.m),
          Text(event.descriptionSafe, style: const TextStyle(height: 1.5, color: AppColors.slate)),
          const SizedBox(height: Insets.m),
          const Text('Recommended next step',
              style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 4),
          Text(event.nextAction, style: const TextStyle(height: 1.5, color: AppColors.slate)),
          const SizedBox(height: Insets.m),
          const Row(
            children: [
              Icon(Icons.lock_rounded, size: 13, color: AppColors.slate),
              SizedBox(width: 4),
              Text('Detected from behavioral patterns only',
                  style: TextStyle(fontSize: 12, color: AppColors.slate)),
            ],
          ),
          const SizedBox(height: Insets.l),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    ),
  );
}
