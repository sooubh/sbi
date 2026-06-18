import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MessageModel {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  MessageModel({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AiChatModal extends StatefulWidget {
  const AiChatModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AiChatModal(),
    );
  }

  @override
  State<AiChatModal> createState() => _AiChatModalState();
}

class _AiChatModalState extends State<AiChatModal> {
  final List<MessageModel> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<String> _suggestedPrompts = [
    'How do I start a Fixed Deposit?',
    'Explain SIP Setup',
    'My Financial Health status',
    'How does Auto-Save work?',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-populate with first welcome message
    _messages.add(
      MessageModel(
        text: 'Hello! I am your Sooubh AI assistant. I can help you search features, open deposits, configure savings goals, or clarify card controls. How can I help you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    
    _textController.clear();
    setState(() {
      _messages.add(
        MessageModel(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate AI reply delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      String responseText = '';
      
      // Intent mapping
      final query = text.toLowerCase();
      if (query.contains('fixed deposit') || query.contains('fd')) {
        responseText = 'Fixed Deposits (FD) let you lock in interest rates up to 7.2% for high-yield returns. You can open an FD instantly in the Accounts grid on the Services tab.';
      } else if (query.contains('sip') || query.contains('setup') || query.contains('invest')) {
        responseText = 'A Systematic Investment Plan (SIP) lets you deposit regular sums into mutual funds automatically. Go to Investments on the Services screen and tap "SIP Setup" to start with ₹500/month.';
      } else if (query.contains('health') || query.contains('score')) {
        responseText = 'Your Wellness Score is 86/100, which is Good! You can increase it to Excellent by completing video KYC, enabling UPI payment channels, or configuring a savings goal.';
      } else if (query.contains('auto-save') || query.contains('round')) {
        responseText = 'Auto-Save automatically rounds up card transactions (e.g. to the nearest ₹10) and sends the difference to your active savings goal. It is a frictionless way to accumulate savings.';
      } else {
        responseText = 'That is a great question! You can explore sbi features directly through the category grid panels. Let me know if you would like me to explain a specific service like FD, SIP, or Auto-Save.';
      }

      setState(() {
        _isTyping = false;
        _messages.add(
          MessageModel(
            text: responseText,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75 + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: [
          // Drag handle and title header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.forum_rounded, color: AppTheme.aiTeal),
                          const SizedBox(width: 8),
                          Text(
                            'Sooubh AI Assistant',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Conversation view
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Suggested chips (show only if AI is not typing)
          if (!_isTyping && _messages.length < 5)
            Container(
              height: 44,
              color: Colors.transparent,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _suggestedPrompts.length,
                itemBuilder: (context, index) {
                  final prompt = _suggestedPrompts[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text(
                        prompt,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.aiTeal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: AppTheme.cardBg,
                      side: BorderSide(color: AppTheme.aiTeal.withValues(alpha: 0.2)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onPressed: () => _handleSubmitted(prompt),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 8),
          
          // Typing indicator
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.aiTeal),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sooubh AI is writing...',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.aiTeal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          // Message input bar
          Container(
            padding: const EdgeInsets.all(12.0),
            color: AppTheme.cardBg,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      hintStyle: theme.textTheme.bodyMedium,
                      filled: true,
                      fillColor: AppTheme.background,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppTheme.aiTeal),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    final isUser = message.isUser;
    
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[
          Container(
            margin: const EdgeInsets.only(right: 8.0, top: 4.0),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppTheme.aiTeal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt_rounded, size: 14, color: Colors.white),
          ),
        ],
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.sbiBlue : AppTheme.cardBg,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0),
                bottomLeft: Radius.circular(isUser ? 16.0 : 4.0),
                bottomRight: Radius.circular(isUser ? 4.0 : 16.0),
              ),
              boxShadow: isUser ? null : AppTheme.softShadow,
            ),
            child: Text(
              message.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isUser ? Colors.white : AppTheme.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
