import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/state_providers.dart';
import '../engine/gemini_live_service.dart';
import '../../services/widgets/ai_chat_modal.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Provider: tracks whether the proactive banner has been dismissed
// ─────────────────────────────────────────────────────────────────────────────

final proactiveBannerDismissedProvider = StateProvider<bool>((ref) => false);
final proactiveLiveTypingProvider = StateProvider<String>((ref) => '');

// ─────────────────────────────────────────────────────────────────────────────
// Proactive AI Banner — top of home screen, speaks first, streams via Live API
// ─────────────────────────────────────────────────────────────────────────────

class ProactiveAIBanner extends ConsumerStatefulWidget {
  const ProactiveAIBanner({super.key});

  @override
  ConsumerState<ProactiveAIBanner> createState() => _ProactiveAIBannerState();
}

class _ProactiveAIBannerState extends ConsumerState<ProactiveAIBanner> {
  GeminiLiveService? _liveService;
  ProactiveSuggestion? _suggestion;
  String _displayText = '';
  bool _isStreaming = false;
  bool _isLiveConnected = false;
  Timer? _typingTimer;
  int _charIndex = 0;
  final Set<String> _boostedGoalIds = {};

  @override
  void initState() {
    super.initState();
    // Delay to let providers settle before reading state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initProactiveAI();
    });
  }

  Future<void> _initProactiveAI() async {
    if (!mounted) return;

    final user = ref.read(userProfileProvider);
    final transactions = ref.read(transactionsProvider);
    final apiKey = ref.read(geminiApiKeyProvider);

    // Generate context-aware suggestion (rule-based, instant, no API call)
    final suggestion = ProactiveAdvisor.generateSuggestion(
      userName: user.name,
      kycComplete: user.kycComplete,
      upiEnabled: user.upiEnabled,
      goalCount: user.goalCount,
      balance: user.balance,
      healthScore: user.financialHealthScore,
      recentTransactions: transactions
          .take(3)
          .map((t) => {'merchant': t.merchant, 'amount': t.amount.toString()})
          .toList(),
    );

    setState(() {
      _suggestion = suggestion;
    });

    // Try to start Gemini Live WebSocket for enriched streaming suggestion
    if (apiKey.isNotEmpty) {
      _tryGeminiLiveStream(apiKey, user, suggestion);
    } else {
      // Fallback: type out the rule-based suggestion with a typewriter effect
      _startTypewriterEffect(suggestion.message);
    }
  }

  Future<void> _tryGeminiLiveStream(
    String apiKey,
    dynamic user,
    ProactiveSuggestion suggestion,
  ) async {
    _boostedGoalIds.clear();
    final goals = ref.read(goalsProvider);
    final transactions = ref.read(transactionsProvider);
    final recommendations = ref.read(recommendationsProvider);
    final services = ref.read(servicesProvider);
    final signals = ref.read(financialSignalsProvider);

    final systemPrompt = '''
You are Sooubh AI, the proactive banking assistant for YONO SBI.
You auto-greet the user with one actionable, personalized message (max 2 sentences) when they open the app.
You MUST reference their real account data.

User: ${user.name} | Balance: ₹${user.balance.toStringAsFixed(2)} | KYC: ${user.kycComplete} | UPI: ${user.upiEnabled} | Goals: ${goals.length} | Health Score: ${user.financialHealthScore}/100 | Onboarding: ${user.newUser ? 'New User (needs Onboarding)' : 'Existing User'}
Pending Recs: ${recommendations.where((r) => !r.completed).map((r) => r.title).join(', ')}
Recent Transactions: ${transactions.take(2).map((t) => '${t.merchant} ₹${t.amount}').join(', ')}
Active Services: ${services.where((s) => s.isActivated).map((s) => s.name).join(', ')}

Financial Patterns & Signals:
${signals.summaryForAgent}

Onboarding Context:
If user is a New User (Onboarding):
- You are speaking to a new/prospective customer of SBI.
- Greet them warmly and call `qualify_lead` early (1-2 replies) to understand their profile.
- Guide them step-by-step: first KYC (PAN & Aadhaar scan, then Video KYC), then UPI activation.
- Call `initiate_kyc_step` (with step: 'pan', 'aadhaar', or 'video') ONLY after the user verbally confirms they are ready.
- Once both KYC scanning and Video KYC are done, call `activate_upi`.
- After UPI is activated, call `suggest_first_action` to recommend a first action ('r_goal' or 'r_fd') based on lead details.
- Keep the conversation extremely natural, warm, and in Hinglish (Hindi-English mix).
- You must always include the 'reason' or other arguments required by the tools.

Instructions:
- Be warm, human, and concise (≤ 2 sentences, no lists).
- Prioritize what the user MUST do or would benefit from most right now.
- End with a soft call-to-action like "Tap below to ..." or "Want me to help with ...?"
- IMPORTANT: You have access to tools that can make actual changes to the app state. When greeting or conversing, if you notice the user needs something, or if you make a recommendation, you MUST call the relevant tool (e.g. `qualify_lead`, `initiate_kyc_step`, `activate_upi`, `suggest_first_action`, `surface_recommendation`, `log_spending_insight`, `boost_goal_savings`, or `suggest_service_activation`) parallel to your response. Do NOT just output text, execute the tool corresponding to your advice!
''';

    _liveService = GeminiLiveService(
      apiKey: apiKey,
      systemPrompt: systemPrompt,
      onToolCall: (name, args) {
        if (!mounted) return;
        _dispatchToolCall(name, args);
      },
    );

    try {
      await _liveService!.connect();

      setState(() {
        _isLiveConnected = true;
        _isStreaming = true;
        _displayText = '';
      });

      // Listen to streaming messages from Gemini Live
      _liveService!.messageStream.listen((msg) {
        if (!mounted) return;
        setState(() {
          _displayText = msg.text;
          _isStreaming = !msg.isComplete;
        });
        if (msg.isComplete) {
          ref.read(proactiveLiveTypingProvider.notifier).state = msg.text;
        }
      });

      _liveService!.statusStream.listen((status) {
        if (!mounted) return;
        if (status == GeminiLiveStatus.error || status == GeminiLiveStatus.closed) {
          if (_displayText.isEmpty) {
            _startTypewriterEffect(suggestion.message);
          }
          setState(() {
            _isLiveConnected = false;
            _isStreaming = false;
          });
        }
      });

      // Send the proactive prompt to Gemini Live
      _liveService!.sendText(
        'Generate a proactive personalized greeting and one key recommendation for the user opening the YONO SBI app right now.',
      );
    } catch (e) {
      debugPrint('[ProactiveAI] Gemini Live failed: $e. Using typewriter fallback.');
      _startTypewriterEffect(suggestion.message);
    }
  }

  void _dispatchToolCall(String name, Map<String, dynamic> args) {
    debugPrint('[ProactiveAI] Dispatched tool: $name with args: $args');
    switch (name) {
      case 'surface_recommendation':
        final id = args['id'] as String? ?? '';
        final reason = args['reason'] as String? ?? '';
        if (id.isNotEmpty && reason.isNotEmpty) {
          ref.read(recommendationsProvider.notifier).addOrSurfaceRecommendation(id, reason);
        }
        break;

      case 'log_spending_insight':
        final category = args['category'] as String? ?? '';
        final insight = args['insight'] as String? ?? '';
        final reason = args['reason'] as String? ?? '';
        if (category.isNotEmpty && insight.isNotEmpty) {
          ref.read(engagementProvider.notifier).trackEvent(
            'AI Insight: $category',
            coins: 0,
            details: '$insight | Reason: $reason',
          );
        }
        break;

      case 'boost_goal_savings':
        final goalId = args['goal_id'] as String? ?? '';
        final amountValue = args['amount'] as num? ?? 0.0;
        final amount = amountValue.toDouble();
        final reason = args['reason'] as String? ?? '';
        if (goalId.isNotEmpty) {
          if (_boostedGoalIds.contains(goalId)) {
            debugPrint('[ProactiveAI] boost_goal_savings for $goalId already executed in this session.');
            return;
          }
          final goals = ref.read(goalsProvider);
          final goalExists = goals.any((g) => g.id == goalId);
          if (!goalExists) {
            debugPrint('[ProactiveAI] boost_goal_savings failed: Goal $goalId does not exist.');
            return;
          }
          _boostedGoalIds.add(goalId);
          final clampedAmount = amount.clamp(0.0, 500.0);
          final user = ref.read(userProfileProvider);
          
          ref.read(userProfileProvider.notifier).updateBalance(user.balance - clampedAmount);
          ref.read(goalsProvider.notifier).saveToGoal(goalId, clampedAmount);
          ref.read(engagementProvider.notifier).trackEvent(
            'AI Goal Boost: $goalId',
            coins: 10,
            details: '$reason (Boosted: ₹$clampedAmount)',
          );
        }
        break;

      case 'suggest_service_activation':
        final serviceId = args['service_id'] as String? ?? '';
        final reason = args['reason'] as String? ?? '';
        if (serviceId.isNotEmpty) {
          ref.read(servicesProvider.notifier).activateService(serviceId);
          ref.read(engagementProvider.notifier).trackEvent(
            'AI Activated: $serviceId',
            coins: 20,
            details: reason,
          );
        }
        break;

      case 'qualify_lead':
        final incomeBracket = args['income_bracket'] as String? ?? '';
        final bankingNeed = args['banking_need'] as String? ?? '';
        final existingBank = args['existing_bank'] as String? ?? '';
        if (incomeBracket.isNotEmpty && bankingNeed.isNotEmpty && existingBank.isNotEmpty) {
          ref.read(userProfileProvider.notifier).qualifyLead(
            incomeBracket: incomeBracket,
            bankingNeed: bankingNeed,
            existingBank: existingBank,
          );
        }
        break;

      case 'initiate_kyc_step':
        final step = args['step'] as String? ?? '';
        final userConfirmed = args['user_confirmed'] as bool? ?? false;
        if (step.isNotEmpty && userConfirmed) {
          final user = ref.read(userProfileProvider);
          if (!user.kycComplete && ModalRoute.of(context)?.settings.name != '/onboarding/kyc') {
            Navigator.of(context).pushNamed('/onboarding/kyc');
          }
          ref.read(agentKycProvider.notifier).triggerKycStep(step, userConfirmed);
        }
        break;

      case 'activate_upi':
        if (ref.read(upiActivatedSessionProvider)) {
          debugPrint('[ProactiveAI] activate_upi already executed in this session.');
          return;
        }
        ref.read(upiActivatedSessionProvider.notifier).state = true;
        ref.read(userProfileProvider.notifier).enableUpi();
        ref.read(servicesProvider.notifier).activateService('upi');
        ref.read(engagementProvider.notifier).trackEvent(
          'UPI Activated during Onboarding',
          coins: 40,
          details: 'Enabled unified payment interface and registered primary banking VPA',
        );
        ref.read(recommendationsProvider.notifier).completeRecommendation('r_upi');
        break;

      case 'suggest_first_action':
        final recommendationId = args['recommendation_id'] as String? ?? '';
        final reason = args['reason'] as String? ?? '';
        if (recommendationId.isNotEmpty && reason.isNotEmpty) {
          if (ref.read(suggestFirstActionSessionProvider)) {
            debugPrint('[ProactiveAI] suggest_first_action already executed in this session.');
            return;
          }
          ref.read(suggestFirstActionSessionProvider.notifier).state = true;
          ref.read(recommendationsProvider.notifier).addOrSurfaceRecommendation(recommendationId, reason);
        }
        break;

      default:
        debugPrint('[ProactiveAI] Unknown tool call name: $name');
    }
  }

  void _startTypewriterEffect(String text) {
    if (!mounted) return;
    setState(() {
      _displayText = '';
      _isStreaming = true;
      _charIndex = 0;
    });

    _typingTimer = Timer.periodic(const Duration(milliseconds: 18), (timer) {
      if (!mounted || _charIndex >= text.length) {
        timer.cancel();
        if (mounted) setState(() => _isStreaming = false);
        return;
      }
      setState(() {
        _displayText += text[_charIndex];
        _charIndex++;
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _liveService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dismissed = ref.watch(proactiveBannerDismissedProvider);
    if (dismissed || _suggestion == null) return const SizedBox.shrink();

    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 500)),
        SlideEffect(
          begin: Offset(0, -0.1),
          end: Offset.zero,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        ),
      ],
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.aiTeal.withValues(alpha: 0.12),
              AppTheme.sbiBlue.withValues(alpha: 0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          border: Border.all(
            color: AppTheme.aiTeal.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                // Pulsing AI orb
                _PulsingOrb(isActive: _isStreaming),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Sooubh AI',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppTheme.aiTeal,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _isLiveConnected
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : AppTheme.sbiBlue.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _isLiveConnected
                                    ? Colors.green.withValues(alpha: 0.4)
                                    : AppTheme.sbiBlue.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              _isLiveConnected ? '● LIVE' : '● Proactive',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: _isLiveConnected
                                    ? Colors.green.shade400
                                    : AppTheme.sbiBlue,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Dismiss
                GestureDetector(
                  onTap: () {
                    ref.read(proactiveBannerDismissedProvider.notifier).state = true;
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppTheme.textSecondary,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // AI message text with streaming cursor
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: AppTheme.textPrimary,
                ),
                children: [
                  TextSpan(text: _displayText),
                  if (_isStreaming)
                    TextSpan(
                      text: '▌',
                      style: TextStyle(
                        color: AppTheme.aiTeal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Action buttons row
            Row(
              children: [
                // Primary CTA
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _handleAction(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.aiTeal, AppTheme.sbiBlue],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _suggestion!.actionLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Open full chat
                GestureDetector(
                  onTap: () => _openChatWithContext(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.3)),
                    ),
                    child: const Text(
                      'Ask AI',
                      style: TextStyle(
                        color: AppTheme.aiTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context) {
    final route = _suggestion?.actionRoute;
    if (route == null) return;

    ref.read(proactiveBannerDismissedProvider.notifier).state = true;

    // Navigate directly with pre-filled args if present
    final args = _suggestion?.routeArgs;
    if (args != null && args.isNotEmpty) {
      Navigator.of(context).pushNamed(route, arguments: args);
    } else {
      Navigator.of(context).pushNamed(route);
    }
  }

  void _openChatWithContext(BuildContext context) {
    // Pass the current proactive message as context to the chat modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AiChatModal(
        initialMessage: _displayText.isNotEmpty ? _displayText : null,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pulsing AI Orb Widget
// ─────────────────────────────────────────────────────────────────────────────

class _PulsingOrb extends StatelessWidget {
  final bool isActive;
  const _PulsingOrb({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isActive)
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.aiTeal.withValues(alpha: 0.15),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.4, 1.4),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInOut,
                )
                .fadeOut(
                  begin: 0.6,
                  duration: const Duration(milliseconds: 900),
                ),
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppTheme.aiTeal, AppTheme.sbiBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Floating AI Orb — persistent bottom-right FAB style, always visible
// ─────────────────────────────────────────────────────────────────────────────

class FloatingAIOrb extends ConsumerStatefulWidget {
  const FloatingAIOrb({super.key});

  @override
  ConsumerState<FloatingAIOrb> createState() => _FloatingAIOrbState();
}

class _FloatingAIOrbState extends ConsumerState<FloatingAIOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Reset banner so it shows again (or open chat directly)
        ref.read(proactiveBannerDismissedProvider.notifier).state = false;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const AiChatModal(),
        );
      },
      onLongPress: () {
        // Long press re-shows banner
        ref.read(proactiveBannerDismissedProvider.notifier).state = false;
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulse ring
              Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.25),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.aiTeal.withValues(
                      alpha: 0.25 - (_pulseController.value * 0.2),
                    ),
                  ),
                ),
              ),
              // Main orb
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppTheme.aiTeal, AppTheme.sbiBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x5500BFA5),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
