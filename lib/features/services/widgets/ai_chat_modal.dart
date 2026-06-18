import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/state_providers.dart';
import '../../../data/models/financial_goal.dart';
import '../../ai/engine/ai_engine.dart';

class MessageModel {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final Widget? actionWidget;
  final String? engineSource;

  MessageModel({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.actionWidget,
    this.engineSource,
  });
}

class AiChatModal extends ConsumerStatefulWidget {
  /// Optional: pre-populate a message from the proactive AI banner into chat
  final String? initialMessage;

  const AiChatModal({super.key, this.initialMessage});

  static void show(BuildContext context, {String? initialMessage}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AiChatModal(initialMessage: initialMessage),
    );
  }

  @override
  ConsumerState<AiChatModal> createState() => _AiChatModalState();
}

class _AiChatModalState extends ConsumerState<AiChatModal> {
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
    // If launched from proactive banner, show the AI's proactive message first
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      _messages.add(
        MessageModel(
          text: widget.initialMessage!,
          isUser: false,
          timestamp: DateTime.now(),
          engineSource: 'Gemini Live',
        ),
      );
    } else {
      _messages.add(
        MessageModel(
          text: 'Hello! I am your Sooubh AI assistant. I can help you search features, open deposits, configure savings goals, or clarify card controls. How can I help you today?',
          isUser: false,
          timestamp: DateTime.now(),
          engineSource: 'Sooubh AI',
        ),
      );
    }
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

  void _handleSubmitted(String text) async {
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

    // Track chat prompt event
    ref.read(engagementProvider.notifier).trackEvent(
      'Sent Chat Query',
      coins: 5,
      details: 'User asked: "$text"',
    );

    final apiKey = ref.read(geminiApiKeyProvider);
    final userProfile = ref.read(userProfileProvider);
    final transactions = ref.read(transactionsProvider);
    final goals = ref.read(goalsProvider);
    final recommendations = ref.read(recommendationsProvider);
    final services = ref.read(servicesProvider);
    final models = ref.read(localAiProvider);
    final activeModel = models.firstWhere((m) => m.isActive, orElse: () => models.first);

    // Call unified AIEngineCoordinator
    final result = await AIEngineCoordinator.processQuery(
      prompt: text,
      apiKey: apiKey,
      userProfile: userProfile,
      transactions: transactions,
      goals: goals,
      recommendations: recommendations,
      services: services,
      activeModel: activeModel,
    );

    if (!mounted) return;

    // Dynamically build interactive action widgets based on routing
    Widget? actionWidget;
    final lowerText = text.toLowerCase();
    
    if (result.actionRoute != null && result.actionRoute!.startsWith('/send-money')) {
      final uri = Uri.tryParse(result.actionRoute!);
      final recipient = uri?.queryParameters['recipient'] ?? 'priya@sbi';
      final amount = uri?.queryParameters['amount'] ?? '500';

      actionWidget = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.send_rounded, size: 16),
          label: Text('Send ₹$amount to $recipient', style: const TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.sbiBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close chat modal
            Navigator.of(context).pushNamed(
              '/send-money',
              arguments: {
                'recipient': recipient,
                'amount': amount,
              },
            );
          },
        ),
      );
    } else if (result.actionRoute == '/card-control') {
      bool isCardLocked = false;
      actionWidget = StatefulBuilder(
        builder: (context, setBubbleState) {
          return Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCardLocked ? Colors.red.shade50 : AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isCardLocked ? Colors.red.shade200 : AppTheme.aiTeal.withValues(alpha: 0.3)),
              boxShadow: AppTheme.softShadow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isCardLocked ? Icons.lock_rounded : Icons.credit_card_rounded,
                      color: isCardLocked ? Colors.red : AppTheme.sbiBlue,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCardLocked ? 'Card Status: LOCKED' : 'Card Status: ACTIVE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: isCardLocked ? Colors.red : AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          isCardLocked ? 'Tap toggle to re-activate card' : 'Tap toggle to temporarily freeze card',
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Switch.adaptive(
                  value: !isCardLocked,
                  activeTrackColor: AppTheme.aiTeal,
                  onChanged: (value) {
                    setBubbleState(() {
                      isCardLocked = !value;
                    });
                    ref.read(engagementProvider.notifier).trackEvent(
                      isCardLocked ? 'Locked Debit Card' : 'Unlocked Debit Card',
                      coins: 15,
                      details: isCardLocked ? 'Card frozen for safety via chat coordinator' : 'Card unfrozen via chat coordinator',
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isCardLocked ? '🔒 SBI Debit Card has been temporarily LOCKED.' : '✅ SBI Debit Card is now ACTIVE.'),
                        backgroundColor: isCardLocked ? Colors.red : AppTheme.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    } else if (result.actionRoute == '/services/fd') {
      actionWidget = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.account_balance_wallet_rounded, size: 16),
          label: const Text('Open ₹10,000 FD', style: TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.sbiBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            final newGoal = FinancialGoal(
              id: 'g_fd_${DateTime.now().millisecondsSinceEpoch}',
              name: 'Fixed Deposit (7.2%)',
              targetAmount: 10000,
              savedAmount: 10000,
              monthlyContribution: 0.0,
              status: 'active',
            );
            ref.read(goalsProvider.notifier).addGoal(newGoal);
            ref.read(userProfileProvider.notifier).incrementGoals();
            ref.read(engagementProvider.notifier).trackEvent(
              'Created Fixed Deposit',
              coins: 60,
              details: 'Opened new Fixed Deposit goal via chat agent',
            );
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎉 Fixed Deposit Created successfully! +60 SBI Coins Earned.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      );
    } else if (result.actionRoute == '/services/sip') {
      actionWidget = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.trending_up_rounded, size: 16),
          label: const Text('Start ₹1,000 SIP', style: TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.sbiBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            final newGoal = FinancialGoal(
              id: 'g_sip_${DateTime.now().millisecondsSinceEpoch}',
              name: 'Wealth Creator Mutual Fund SIP',
              targetAmount: 12000,
              savedAmount: 1000,
              monthlyContribution: 1000.0,
              status: 'active',
            );
            ref.read(goalsProvider.notifier).addGoal(newGoal);
            ref.read(userProfileProvider.notifier).incrementGoals();
            ref.read(engagementProvider.notifier).trackEvent(
              'Setup Mutual Fund SIP',
              coins: 50,
              details: 'Created SIP investment goal via conversational agent',
            );
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('📈 Mutual Fund SIP Setup completed! +50 SBI Coins Earned.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      );
    } else if (result.actionRoute == '/onboarding/kyc') {
      actionWidget = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.video_call_rounded, size: 16),
          label: const Text('Complete Video KYC Now', style: TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.aiTeal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            ref.read(userProfileProvider.notifier).completeKyc();
            ref.read(recommendationsProvider.notifier).completeRecommendation('r_kyc');
            ref.read(engagementProvider.notifier).trackEvent(
              'Completed Video KYC from Chat',
              coins: 30,
              details: 'Completed onboarding verification',
            );
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Video KYC Completed! +30 SBI Coins Earned.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      );
    } else if (result.actionRoute == '/onboarding/upi') {
      actionWidget = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_scanner_rounded, size: 16),
          label: const Text('Register UPI Handle', style: TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.sbiBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            ref.read(userProfileProvider.notifier).enableUpi();
            ref.read(recommendationsProvider.notifier).completeRecommendation('r_upi');
            ref.read(engagementProvider.notifier).trackEvent(
              'Setup UPI from Chat',
              coins: 25,
              details: 'Activated UPI handle',
            );
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⚡ UPI Handle Set Up! +25 SBI Coins Earned.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      );
    } else if (lowerText.contains('auto-save') || lowerText.contains('round')) {
      final autoSaveActive = services.any((s) => s.id == 's_autosave' && s.isActivated);
      actionWidget = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton.icon(
          icon: Icon(autoSaveActive ? Icons.check_circle_rounded : Icons.flash_on_rounded, size: 16),
          label: Text(autoSaveActive ? 'Auto-Save is Enabled' : 'Enable Auto-Save', style: const TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: autoSaveActive ? Colors.grey : AppTheme.aiTeal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: autoSaveActive ? null : () {
            ref.read(servicesProvider.notifier).activateService('s_autosave');
            ref.read(engagementProvider.notifier).trackEvent(
              'Activated Auto-Save from Chat',
              coins: 40,
              details: 'Enabled Auto-Save via conversational helper dialog',
            );
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⚡ Auto-Save Enabled! +40 SBI Coins Earned.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      );
    }

    setState(() {
      _isTyping = false;
      _messages.add(
        MessageModel(
          text: result.text,
          isUser: false,
          timestamp: DateTime.now(),
          actionWidget: actionWidget,
          engineSource: result.engineSource,
        ),
      );
    });
    _scrollToBottom();
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

          // Suggested chips
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
          child: Column(
            crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
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
              if (!isUser && message.engineSource != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.aiTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      message.engineSource!,
                      style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.aiTeal),
                    ),
                  ),
                ),
              ],
              if (message.actionWidget != null) message.actionWidget!,
            ],
          ),
        ),
      ],
    );
  }
}
