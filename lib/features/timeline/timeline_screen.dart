import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/relative_time.dart';
import '../../models/timeline_entry.dart';
import '../../services/demo_feed_service.dart';
import '../../widgets/app_card.dart';

/// Agent Timeline (PRD Screen 7): chronological feed of what the AI
/// noticed and did, with expandable explainable notes.
class TimelineScreen extends ConsumerWidget {
  const TimelineScreen({super.key});

  static IconData _icon(String eventType) => switch (eventType) {
        'income_pattern' => Icons.payments_rounded,
        'savings_suggestion' => Icons.savings_rounded,
        'travel_event' => Icons.flight_takeoff_rounded,
        'budget_recommendation' => Icons.pie_chart_rounded,
        'goal_review' => Icons.flag_rounded,
        'bill_reminder' => Icons.receipt_long_rounded,
        _ => Icons.bolt_rounded,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(timelineProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Timeline', style: TextStyle(fontWeight: FontWeight.w800))),
      body: ListView.separated(
        padding: const EdgeInsets.all(Insets.m),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const SizedBox(height: Insets.s + 4),
        itemBuilder: (_, i) => _TimelineCard(entry: entries[i], icon: _icon(entries[i].eventType)),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.entry, required this.icon});

  final TimelineEntry entry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.xs),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: Insets.m),
          leading: Container(
            padding: const EdgeInsets.all(9),
            decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: AppColors.deepBlue),
          ),
          title: Text(entry.message,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
          subtitle: Text(relativeTime(entry.createdAt),
              style: const TextStyle(fontSize: 12, color: AppColors.slate)),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(entry.explainNote,
                  style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.slate)),
            ),
            const SizedBox(height: Insets.s),
            const Row(
              children: [
                Icon(Icons.lock_rounded, size: 13, color: AppColors.slate),
                SizedBox(width: 4),
                Text('Based on privacy-safe signals only',
                    style: TextStyle(fontSize: 12, color: AppColors.slate)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
