import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/state_providers.dart';
import '../../features/ai/presentation/proactive_ai_widget.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Debug Panel — Universal Debug Info Overlay
// Tap the debug button (shown in home header) to open this.
// Shows: App State, AI Engine, WebSocket, Mock Data, API Keys, Providers.
// ─────────────────────────────────────────────────────────────────────────────

class DebugPanel extends ConsumerWidget {
  const DebugPanel({super.key});

  /// Show the debug panel as a full-screen bottom sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DebugPanel(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final goals = ref.watch(goalsProvider);
    final transactions = ref.watch(transactionsProvider);
    final recommendations = ref.watch(recommendationsProvider);
    final services = ref.watch(servicesProvider);
    final engagement = ref.watch(engagementProvider);
    final apiKey = ref.watch(geminiApiKeyProvider);
    final proactiveDismissed = ref.watch(proactiveBannerDismissedProvider);
    final liveTyping = ref.watch(proactiveLiveTypingProvider);

    // Build the full debug string
    final debugInfo = _buildDebugInfo(
      user: user,
      goals: goals,
      transactions: transactions,
      recommendations: recommendations,
      services: services,
      engagement: engagement,
      apiKey: apiKey,
      proactiveDismissed: proactiveDismissed,
      liveTyping: liveTyping,
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.97,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0D1117), // GitHub dark
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // ── Handle + Header ──────────────────────────────────────────
              _DebugHeader(debugInfo: debugInfo),

              // ── Scrollable content ────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DebugSection(
                        title: '👤 USER PROFILE',
                        color: Colors.blue.shade300,
                        entries: {
                          'userId': user.userId,
                          'name': user.name,
                          'maskedAccount': user.maskedAccount,
                          'balance': '₹${user.balance.toStringAsFixed(2)}',
                          'kycComplete': user.kycComplete.toString(),
                          'upiEnabled': user.upiEnabled.toString(),
                          'hasGoal': user.hasGoal.toString(),
                          'goalCount': user.goalCount.toString(),
                          'healthScore': '${user.financialHealthScore}/100',
                          'lastLogin': user.lastLogin,
                          'newUser': user.newUser.toString(),
                        },
                      ),
                      _DebugSection(
                        title: '🎯 SAVINGS GOALS (${goals.length})',
                        color: Colors.green.shade300,
                        entries: goals.isEmpty
                            ? {'status': 'No active goals'}
                            : {
                                for (int i = 0; i < goals.length; i++)
                                  'goal[$i]':
                                      '${goals[i].name} | ₹${goals[i].savedAmount}/₹${goals[i].targetAmount} (${goals[i].progressPercent}%)',
                              },
                      ),
                      _DebugSection(
                        title: '💳 TRANSACTIONS (${transactions.length})',
                        color: Colors.orange.shade300,
                        entries: transactions.isEmpty
                            ? {'status': 'No transactions'}
                            : {
                                for (int i = 0; i < transactions.length; i++)
                                  'tx[$i]':
                                      '${transactions[i].date} | ${transactions[i].merchant} | ₹${transactions[i].amount} (${transactions[i].category})',
                              },
                      ),
                      _DebugSection(
                        title: '📋 RECOMMENDATIONS (${recommendations.length})',
                        color: Colors.purple.shade300,
                        entries: recommendations.isEmpty
                            ? {'status': 'No recommendations'}
                            : {
                                for (final r in recommendations)
                                  r.id:
                                      '${r.completed ? "✅" : "⏳"} ${r.title} | priority=${r.priority} | route=${r.actionRoute}',
                              },
                      ),
                      _DebugSection(
                        title: '🏦 SERVICES (${services.length})',
                        color: Colors.cyan.shade300,
                        entries: {
                          for (final s in services)
                            s.id:
                                '${s.isActivated ? "🟢" : "⚪"} ${s.name} (${s.category})${s.isNew ? " [NEW]" : ""}',
                        },
                      ),
                      _DebugSection(
                        title: '🏆 ENGAGEMENT & GAMIFICATION',
                        color: Colors.amber.shade300,
                        entries: {
                          'sbiCoins': engagement.sbiCoins.toString(),
                          'streakCount': '${engagement.streakCount} days',
                          'achievements': engagement.unlockedAchievements.join(', '),
                          'recentEvents (last 5)': engagement.trackedEvents
                              .take(5)
                              .map((e) => e.actionName)
                              .join(' | '),
                        },
                      ),
                      _DebugSection(
                        title: '🤖 AI ENGINE STATE',
                        color: const Color(0xFF00BFA5),
                        entries: {
                          'geminiApiKey':
                              apiKey.isEmpty ? '❌ NOT SET' : '✅ SET (${apiKey.length} chars)',
                          'geminiApiKeyMasked': apiKey.isEmpty
                              ? 'N/A'
                              : '${apiKey.substring(0, 4)}...${apiKey.substring(apiKey.length - 4)}',
                          'geminiModel': 'gemini-2.5-flash',
                          'liveWebSocket': 'wss://generativelanguage.googleapis.com/ws/...',
                          'liveEndpoint':
                              'BidiGenerateContent (bidirectional text streaming)',
                          'localModels':
                              'Offline demo KB profiles | GGUF runtime pending',
                          'routingLogic':
                              'Rule → Offline demo KB (small) → Gemini (complex) → Fallback',
                          'proactiveBannerDismissed': proactiveDismissed.toString(),
                          'liveStreamedText': liveTyping.isEmpty
                              ? '(not yet received)'
                              : liveTyping.length > 80
                                  ? '${liveTyping.substring(0, 80)}...'
                                  : liveTyping,
                        },
                      ),
                      _DebugSection(
                        title: '🔧 PROVIDER REGISTRY',
                        color: Colors.pink.shade300,
                        entries: {
                          'userProfileProvider': 'StateNotifierProvider<UserProfile>',
                          'goalsProvider': 'StateNotifierProvider<List<FinancialGoal>>',
                          'transactionsProvider':
                              'StateNotifierProvider<List<TransactionModel>>',
                          'recommendationsProvider':
                              'StateNotifierProvider<List<Recommendation>>',
                          'servicesProvider': 'StateNotifierProvider<List<ServiceModel>>',
                          'engagementProvider': 'StateNotifierProvider<EngagementState>',
                          'geminiApiKeyProvider': 'StateProvider<String>',
                          'localAiProvider': 'StateNotifierProvider<List<LocalModel>>',
                          'weeklyStoryProvider': 'Provider<WeeklyStory>',
                          'proactiveBannerDismissedProvider': 'StateProvider<bool>',
                          'proactiveLiveTypingProvider': 'StateProvider<String>',
                        },
                      ),
                      _DebugSection(
                        title: '🗄️ PERSISTENCE',
                        color: Colors.teal.shade300,
                        entries: {
                          'storage': 'Hive (local key-value)',
                          'boxes': 'settings | user_profile | goals | transactions | recs',
                          'userProfileBox': 'key=user_profile_\${userId}',
                          'goalsBox': 'key=goals_\${userId}',
                          'txBox': 'key=transactions_\${userId}',
                          'recsBox': 'key=recommendations_\${userId}',
                          'apiKeyBox': 'settings → gemini_api_key',
                        },
                      ),
                      _DebugSection(
                        title: '🛣️ NAVIGATION ROUTES',
                        color: Colors.lime.shade300,
                        entries: {
                          '/': 'HomeScreen',
                          '/onboarding': 'OnboardingScreen',
                          '/onboarding/kyc': 'Video KYC Flow',
                          '/onboarding/upi': 'UPI Setup Flow',
                          '/send-money': 'SendMoneyScreen (args: recipient, amount)',
                          '/goals/create': 'GoalCreationScreen',
                          '/services': 'ServicesScreen',
                          '/services/fd': 'Fixed Deposit',
                          '/services/sip': 'SIP / Mutual Fund',
                          '/coach': 'FinancialCoachScreen',
                          '/profile': 'ProfileScreen',
                          '/card-control': 'CardControlScreen',
                        },
                      ),
                      _DebugSection(
                        title: '📦 BUILD INFO',
                        color: Colors.grey.shade400,
                        entries: {
                          'appName': 'YONO SBI — Sooubh AI',
                          'version': '1.0.0+1',
                          'flutter': '3.x (Dart 3.11.5)',
                          'framework': 'Flutter Riverpod v2',
                          'stateManagement': 'Riverpod StateNotifier + Hive',
                          'aiStack':
                              'Gemini 2.5 Flash (REST+Live WS) + Offline Demo KB + Rule Engine',
                          'websocket': 'web_socket_channel: ^3.0.1',
                          'charts': 'fl_chart: ^0.69.0',
                          'animations': 'flutter_animate: ^4.5.0',
                          'fonts': 'Google Fonts (Outfit, Inter)',
                          'debugNote': '🔴 HACKATHON BUILD — Mock data only',
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _buildDebugInfo({
    required dynamic user,
    required dynamic goals,
    required dynamic transactions,
    required dynamic recommendations,
    required dynamic services,
    required dynamic engagement,
    required String apiKey,
    required bool proactiveDismissed,
    required String liveTyping,
  }) {
    final buf = StringBuffer();
    buf.writeln('╔══════════════════════════════════════════╗');
    buf.writeln('║   YONO SBI — Sooubh AI Debug Dump       ║');
    buf.writeln('║   Generated: ${DateTime.now().toIso8601String()}  ║');
    buf.writeln('╚══════════════════════════════════════════╝');
    buf.writeln();
    buf.writeln('=== USER PROFILE ===');
    buf.writeln('userId: ${user.userId}');
    buf.writeln('name: ${user.name}');
    buf.writeln('account: ${user.maskedAccount}');
    buf.writeln('balance: ₹${user.balance.toStringAsFixed(2)}');
    buf.writeln('kycComplete: ${user.kycComplete}');
    buf.writeln('upiEnabled: ${user.upiEnabled}');
    buf.writeln('healthScore: ${user.financialHealthScore}/100');
    buf.writeln('goalCount: ${user.goalCount}');
    buf.writeln();
    buf.writeln('=== GOALS (${(goals as List).length}) ===');
    for (final g in goals) {
      buf.writeln('  ${g.name}: ₹${g.savedAmount}/₹${g.targetAmount} (${g.progressPercent}%)');
    }
    buf.writeln();
    buf.writeln('=== TRANSACTIONS (${(transactions as List).length}) ===');
    for (final t in transactions) {
      buf.writeln('  ${t.date} | ${t.merchant} | ₹${t.amount} | ${t.category}');
    }
    buf.writeln();
    buf.writeln('=== RECOMMENDATIONS (${(recommendations as List).length}) ===');
    for (final r in recommendations) {
      buf.writeln('  [${r.completed ? "DONE" : "PENDING"}] ${r.id}: ${r.title}');
    }
    buf.writeln();
    buf.writeln('=== AI ENGINE ===');
    buf.writeln('geminiApiKey: ${apiKey.isEmpty ? "NOT SET" : "SET (${apiKey.length} chars)"}');
    buf.writeln('model: gemini-2.5-flash');
    buf.writeln('liveWS: BidiGenerateContent endpoint');
    buf.writeln('proactiveDismissed: $proactiveDismissed');
    buf.writeln('liveText: ${liveTyping.isEmpty ? "(none)" : liveTyping}');
    buf.writeln();
    buf.writeln('=== ENGAGEMENT ===');
    buf.writeln('coins: ${engagement.sbiCoins}');
    buf.writeln('streak: ${engagement.streakCount} days');
    buf.writeln('achievements: ${engagement.unlockedAchievements.join(", ")}');
    buf.writeln();
    buf.writeln('=== SERVICES (${(services as List).length}) ===');
    for (final s in services) {
      buf.writeln('  ${s.id}: ${s.name} | active=${s.isActivated}');
    }
    return buf.toString();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Debug Header with drag handle, title, copy and close buttons
// ─────────────────────────────────────────────────────────────────────────────

class _DebugHeader extends StatelessWidget {
  final String debugInfo;
  const _DebugHeader({required this.debugInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Bug icon + title
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: const Icon(Icons.bug_report_rounded, color: Colors.red, size: 18),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Debug Console',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'YONO SBI · Sooubh AI · Hackathon Build',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Copy all button
              _ActionButton(
                icon: Icons.copy_rounded,
                label: 'Copy All',
                color: const Color(0xFF00BFA5),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: debugInfo));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          const Text('Debug info copied to clipboard!'),
                        ],
                      ),
                      backgroundColor: const Color(0xFF00BFA5),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              // Close button
              _ActionButton(
                icon: Icons.close_rounded,
                label: 'Close',
                color: Colors.white30,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1117),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                _StatusDot(color: Colors.green.shade400),
                const SizedBox(width: 6),
                Text(
                  'Riverpod Active',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
                ),
                const SizedBox(width: 16),
                _StatusDot(color: Colors.blue.shade400),
                const SizedBox(width: 6),
                Text(
                  'Hive Persistent',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
                ),
                const SizedBox(width: 16),
                _StatusDot(color: Colors.orange.shade400),
                const SizedBox(width: 6),
                Text(
                  'Mock Data',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
                ),
                const Spacer(),
                Text(
                  DateTime.now().toUtc().toString().substring(0, 19),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final Color color;
  const _StatusDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Debug Section — coloured header + monospace key-value rows
// ─────────────────────────────────────────────────────────────────────────────

class _DebugSection extends StatefulWidget {
  final String title;
  final Color color;
  final Map<String, String> entries;

  const _DebugSection({
    required this.title,
    required this.color,
    required this.entries,
  });

  @override
  State<_DebugSection> createState() => _DebugSectionState();
}

class _DebugSectionState extends State<_DebugSection> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          // Section header — tap to collapse/expand
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.08),
                borderRadius: _expanded
                    ? const BorderRadius.vertical(top: Radius.circular(10))
                    : BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  // Section copy button
                  GestureDetector(
                    onTap: () {
                      final sectionText = widget.entries.entries
                          .map((e) => '${e.key}: ${e.value}')
                          .join('\n');
                      Clipboard.setData(ClipboardData(text: '${widget.title}\n$sectionText'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Section copied!'),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                          backgroundColor: widget.color.withValues(alpha: 0.85),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.copy_all_rounded, size: 14, color: widget.color.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: widget.color.withValues(alpha: 0.6),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          // Entries
          if (_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                children: widget.entries.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Key
                        SizedBox(
                          width: 130,
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              color: widget.color.withValues(alpha: 0.75),
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          ' : ',
                          style: TextStyle(
                            color: Colors.white24,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                        // Value
                        Expanded(
                          child: GestureDetector(
                            onLongPress: () {
                              Clipboard.setData(ClipboardData(text: entry.value));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Copied: ${entry.key}'),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.grey.shade800,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Debug Button — small icon button to embed anywhere (e.g. home header)
// ─────────────────────────────────────────────────────────────────────────────

class DebugButton extends StatelessWidget {
  const DebugButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Open Debug Console',
      child: GestureDetector(
        onTap: () => DebugPanel.show(context),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bug_report_rounded, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Text(
                'DEBUG',
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
