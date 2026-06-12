import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/privacy/privacy_sanitizer.dart';
import '../../models/chat_message.dart';
import '../../services/ai/ai_explain_service.dart';

/// Controller for the explain-only chat (PRD Feature 7). Refuses sensitive
/// account queries and anything outside the allowed explanation topics.
class ChatController extends Notifier<List<ChatMessage>> {
  bool _busy = false;

  @override
  List<ChatMessage> build() => const [
        ChatMessage(
          fromUser: false,
          text: 'Hi! I can explain your insights, health score, goals and '
              'recommendations. Pick a question below or type your own.',
        ),
      ];

  static final _sensitive = RegExp(
    r'\b(balance|account\s*number|card|cvv|pin|otp|password|transfer|send\s*money|statement|upi)\b',
    caseSensitive: false,
  );

  ExplainTopic? _classify(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('score')) return ExplainTopic.score;
    if (lower.contains('goal')) return ExplainTopic.goal;
    if (lower.contains('recommend') || lower.contains('suggest')) {
      return ExplainTopic.recommendation;
    }
    if (lower.contains('why') || lower.contains('insight') || lower.contains('seeing')) {
      return ExplainTopic.insight;
    }
    return null;
  }

  Future<void> ask(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _busy) return;
    state = [...state, ChatMessage(fromUser: true, text: trimmed)];

    // Refuse sensitive account queries — PRD "Not Allowed" list.
    if (_sensitive.hasMatch(trimmed) || !PrivacySanitizer.isSafe(trimmed)) {
      state = [
        ...state,
        const ChatMessage(
          fromUser: false,
          text: 'I cannot help with account, card or transaction details. '
              'This chat only explains insights, your score, goals and '
              'recommendations — your raw banking data stays private.',
        ),
      ];
      return;
    }

    final topic = _classify(trimmed);
    if (topic == null) {
      state = [
        ...state,
        const ChatMessage(
          fromUser: false,
          text: 'I am an explain-only assistant. Try one of the suggested '
              'questions about your insights, score, goals or recommendations.',
        ),
      ];
      return;
    }

    _busy = true;
    try {
      final answer = await ref.read(aiExplainServiceProvider).explain(topic);
      state = [...state, ChatMessage(fromUser: false, text: answer)];
    } finally {
      _busy = false;
    }
  }
}

final chatControllerProvider =
    NotifierProvider<ChatController, List<ChatMessage>>(ChatController.new);
