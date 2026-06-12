import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/relative_time.dart';
import '../../models/insight.dart';
import '../../models/life_event.dart';
import '../../models/recommendation.dart';
import '../../services/demo_feed_service.dart';
import '../../widgets/app_card.dart';
import '../../widgets/insight_explanation_sheet.dart';
import '../../widgets/section_header.dart';
import '../chat/chat_screen.dart';
import '../journey/journey_screen.dart';
import '../recommendations/recommendations_screen.dart';
import '../recommendations/widgets/recommendation_card.dart';
import 'life_events_screen.dart';
import 'widgets/health_score_card.dart';

/// Compass Dashboard (PRD Screen 4): health score, journey entry, event
/// highlights, AI insights feed and recommended actions.
class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(healthScoreProvider);
    final insights = ref.watch(insightsFeedProvider);
    final events = ref.watch(lifeEventsProvider);
    final recommendations = ref
        .watch(recommendationsProvider)
        .where((r) => r.status == RecommendationStatus.active)
        .take(2)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass'),
        actions: [
          IconButton(
            tooltip: 'Ask Compass',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            ),
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.deepBlue),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Insets.m),
        children: [
          HealthScoreCard(score: score),
          const SizedBox(height: Insets.s + 4),
          AppCard(
            gradient: const LinearGradient(
              colors: [AppColors.deepBlue, AppColors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const JourneyScreen()),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.route_rounded, size: 20, color: Colors.white),
                ),
                const SizedBox(width: Insets.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your Journey',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(
                        'Milestones, badges and monthly highlights — never transactions.',
                        style: TextStyle(fontSize: 12, height: 1.3, color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: Insets.s),
          SectionHeader(
            title: 'Event highlights',
            actionLabel: 'View all',
            onAction: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LifeEventsScreen()),
            ),
          ),
          if (events.isEmpty)
            const AppCard(
              child: Text(
                'Life event tracking is turned off. Enable it in Profile to see event highlights.',
                style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.slate),
              ),
            )
          else
            SizedBox(
              height: 124,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                separatorBuilder: (_, __) => const SizedBox(width: Insets.s + 4),
                itemBuilder: (_, i) => _EventHighlightCard(event: events[i]),
              ),
            ),
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'Insights feed'),
          for (final insight in insights) ...[
            _FeedInsightCard(insight: insight),
            const SizedBox(height: Insets.s + 4),
          ],
          const SizedBox(height: Insets.xs),
          SectionHeader(
            title: 'Recommended actions',
            actionLabel: 'View all',
            onAction: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RecommendationsScreen()),
            ),
          ),
          for (final rec in recommendations) ...[
            RecommendationCard(recommendation: rec),
            const SizedBox(height: Insets.s + 4),
          ],
        ],
      ),
    );
  }
}

class _EventHighlightCard extends StatelessWidget {
  const _EventHighlightCard({required this.event});

  final LifeEvent event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: AppCard(
        onTap: () => showLifeEventDetail(context, event),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
              child: Icon(lifeEventIcon(event.type), size: 18, color: AppColors.deepBlue),
            ),
            const Spacer(),
            Text(event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.ink)),
            const SizedBox(height: 4),
            Text(relativeTime(event.detectedAt),
                style: const TextStyle(fontSize: 12, color: AppColors.slate)),
          ],
        ),
      ),
    );
  }
}

class _FeedInsightCard extends StatelessWidget {
  const _FeedInsightCard({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => showInsightExplanation(context, insight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
            child: const Icon(Icons.auto_awesome_rounded, size: 18, color: AppColors.deepBlue),
          ),
          const SizedBox(width: Insets.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                const SizedBox(height: 4),
                Text(insight.body,
                    style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.slate)),
                const SizedBox(height: 6),
                const Text('Why this? →',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
