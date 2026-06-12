import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../models/chat_message.dart';
import '../../services/ai/ai_explain_service.dart';
import '../../services/user_settings.dart';
import 'chat_controller.dart';

/// Explainable AI Chat (PRD Screen 9): a limited Q&A surface for
/// clarification only — not a general chatbot.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    _inputController.clear();
    ref.read(chatControllerProvider.notifier).ask(text);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatEnabled =
        ref.watch(userSettingsProvider.select((s) => s.chatExplanations));
    final messages = ref.watch(chatControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Compass', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: !chatEnabled
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(Insets.l),
                child: Text(
                  'Chat explanation mode is turned off.\nEnable it in the Privacy Control Center.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5, color: AppColors.slate),
                ),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(Insets.m),
                    padding: const EdgeInsets.all(Insets.s + 4),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.shield_rounded, size: 16, color: AppColors.deepBlue),
                        SizedBox(width: Insets.s),
                        Expanded(
                          child: Text(
                            'Explain-only mode — answers come from privacy-safe signals, never raw data.',
                            style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.deepBlue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: Insets.m),
                      itemCount: messages.length,
                      itemBuilder: (_, i) => _ChatBubble(message: messages[i]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.s),
                    child: Wrap(
                      spacing: Insets.s,
                      runSpacing: Insets.s,
                      children: [
                        for (final topic in ExplainTopic.values)
                          ActionChip(
                            label: Text(topic.prompt, style: const TextStyle(fontSize: 12)),
                            backgroundColor: AppColors.surface,
                            side: const BorderSide(color: AppColors.divider),
                            onPressed: () => _send(topic.prompt),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, Insets.m),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _inputController,
                            textInputAction: TextInputAction.send,
                            onSubmitted: _send,
                            decoration: InputDecoration(
                              hintText: 'Ask about an insight, score, goal…',
                              filled: true,
                              fillColor: AppColors.surface,
                              contentPadding: const EdgeInsets.symmetric(horizontal: Insets.m),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: AppColors.divider),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: AppColors.divider),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Insets.s),
                        IconButton.filled(
                          style: IconButton.styleFrom(backgroundColor: AppColors.deepBlue),
                          onPressed: () => _send(_inputController.text),
                          icon: const Icon(Icons.send_rounded, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final fromUser = message.fromUser;
    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Insets.xs),
        padding: const EdgeInsets.all(Insets.s + 4),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: fromUser ? AppColors.deepBlue : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(fromUser ? 16 : 4),
            bottomRight: Radius.circular(fromUser ? 4 : 16),
          ),
          border: fromUser ? null : Border.all(color: AppColors.divider),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: fromUser ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}
