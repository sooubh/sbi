import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/recommendation.dart';
import '../demo_data_service.dart';
import '../demo_feed_service.dart';
import '../firebase/firestore_repository.dart';
import '../user_settings.dart';

/// The only question types the explain chat accepts (PRD Feature 7).
enum ExplainTopic { insight, score, goal, recommendation }

extension ExplainTopicPrompt on ExplainTopic {
  String get prompt => switch (this) {
        ExplainTopic.insight => 'Why am I seeing this?',
        ExplainTopic.score => 'How is my score calculated?',
        ExplainTopic.goal => 'How can I improve this goal?',
        ExplainTopic.recommendation => 'Why was this recommendation shown?',
      };
}

/// Explainable AI service: Gemini via the explainChat Cloud Function when
/// deployed, local explainable templates otherwise. Every exchange is
/// logged to `aiSessions` per the PRD schema.
class AiExplainService {
  AiExplainService(this._ref);

  final Ref _ref;

  Future<String> explain(ExplainTopic topic) async {
    final settings = _ref.read(userSettingsProvider);
    final repo = _ref.read(firestoreRepositoryProvider);

    String? remote;
    if (repo != null) {
      try {
        final result = await FirebaseFunctions.instance
            .httpsCallable('explainChat')
            .call<Map<dynamic, dynamic>>({
          'promptType': topic.name,
          'privacyLevel': settings.privacyLevel.name,
        });
        remote = result.data['explanation'] as String?;
      } catch (_) {
        // Function not deployed or offline — use local templates.
      }
    }

    final answer = remote ?? _local(topic);
    repo
        ?.logAiSession(
          promptType: topic.name,
          responseType: remote != null ? 'gemini' : 'local_template',
          privacyLevel: settings.privacyLevel.name,
        )
        .ignore();
    return answer;
  }

  /// Local explanations built from real app state — still fully
  /// privacy-safe because the underlying providers only hold safe signals.
  String _local(ExplainTopic topic) {
    switch (topic) {
      case ExplainTopic.insight:
        return _ref.read(heroInsightProvider).reason;
      case ExplainTopic.score:
        return _ref.read(healthScoreProvider).aiExplanation;
      case ExplainTopic.goal:
        final goals = _ref.read(demoGoalsProvider);
        if (goals.isEmpty) {
          return 'You have no goals yet. Create one and Compass will track its pace from progress percentages only.';
        }
        final slowest = goals.reduce(
            (a, b) => a.progressPercent <= b.progressPercent ? a : b);
        return 'Your goal that needs the most attention is "${slowest.name}" at '
            '${slowest.progressPercent}%. '
            '${slowest.aiNudge ?? 'A small recurring auto-save keeps it on pace.'} '
            'Only progress percentages are analyzed — never amounts.';
      case ExplainTopic.recommendation:
        final recs = _ref
            .read(recommendationsProvider)
            .where((r) => r.status == RecommendationStatus.active)
            .toList();
        if (recs.isEmpty) {
          return 'You have no active recommendations right now. New ones appear when safe behavioral signals suggest a helpful action.';
        }
        final top = recs.first;
        return '"${top.title}" was suggested because: ${top.reason} '
            'Recommendations are derived from safe behavioral signals only.';
    }
  }
}

final aiExplainServiceProvider = Provider<AiExplainService>(AiExplainService.new);
