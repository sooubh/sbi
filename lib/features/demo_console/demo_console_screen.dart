import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/privacy/privacy_sanitizer.dart';
import '../../core/privacy/safe_signal.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/services/ai_service.dart';
import '../../domain/services/model_download_service.dart';
import '../../models/insight.dart';
import '../../providers/achievements_provider.dart';
import '../../providers/goals_provider.dart';
import '../../providers/health_score_provider.dart';
import '../../services/ai/signal_pipeline.dart';
import '../../services/persona.dart';
import '../../services/user_settings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';

/// Demo Signal Console ("judge mode"): switch personas and fire
/// privacy-safe signals to watch the PRD section 15 pipeline respond live.
class DemoConsoleScreen extends ConsumerWidget {
  const DemoConsoleScreen({super.key});

  static final _signals = <({String type, String category, SignalSeverity severity, IconData icon, String label})>[
    (type: 'savings_consistency_improved', category: 'savings', severity: SignalSeverity.positive, icon: Icons.savings_rounded, label: 'Savings consistency improved'),
    (type: 'income_pattern_detected', category: 'income', severity: SignalSeverity.positive, icon: Icons.payments_rounded, label: 'Income pattern detected'),
    (type: 'spending_up_in_food_category', category: 'food', severity: SignalSeverity.attention, icon: Icons.restaurant_rounded, label: 'Food spending spike'),
    (type: 'travel_event_detected', category: 'travel', severity: SignalSeverity.info, icon: Icons.flight_takeoff_rounded, label: 'Travel event detected'),
    (type: 'bill_due_soon', category: 'bills', severity: SignalSeverity.attention, icon: Icons.receipt_long_rounded, label: 'Bill due soon'),
    (type: 'goal_progress_slow', category: 'goals', severity: SignalSeverity.attention, icon: Icons.flag_rounded, label: 'Goal progress slowing'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persona = ref.watch(personaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Demo Console')),
      body: ListView(
        padding: const EdgeInsets.all(Insets.m),
        children: [
          const AppCard(
            child: Row(
              children: [
                Icon(Icons.science_rounded, color: AppColors.deepBlue),
                SizedBox(width: Insets.m),
                Expanded(
                  child: Text(
                    'Judge mode: fire a privacy-safe signal and watch the Compass AI pipeline respond live.',
                    style: TextStyle(fontSize: 13, height: 1.4, color: AppColors.slate),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.m),
          const _ModelDownloadSection(),
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'Demo persona'),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: Insets.s,
                  runSpacing: Insets.s,
                  children: [
                    for (final p in DemoPersona.values)
                      ChoiceChip(
                        label: Text(p.label),
                        selected: persona == p,
                        selectedColor: AppColors.lightBlue,
                        onSelected: (_) =>
                            ref.read(personaProvider.notifier).select(p),
                      ),
                  ],
                ),
                const SizedBox(height: Insets.s),
                Text(
                  '${persona.fullName} · ${persona.description}',
                  style: const TextStyle(fontSize: 12, color: AppColors.slate),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'Fire a safe signal'),
          for (final s in _signals) ...[
            AppCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
                    child: Icon(s.icon, size: 20, color: AppColors.deepBlue),
                  ),
                  const SizedBox(width: Insets.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.label,
                            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                        Text(s.type,
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.slate)),
                      ],
                    ),
                  ),
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      backgroundColor: AppColors.lightBlue,
                      foregroundColor: AppColors.deepBlue,
                    ),
                    onPressed: () {
                      final signal = SafeSignal(
                        type: s.type,
                        category: s.category,
                        severity: s.severity,
                        timestamp: DateTime.now(),
                      );
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(Corners.sheet)),
                        ),
                        builder: (_) => _PipelineSheet(signal: signal),
                      );
                    },
                    child: const Text('Fire'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Insets.s + 4),
          ],
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'Model Playground'),
          const _DemoChatPlayground(),
        ],
      ),
    );
  }
}

class _ModelDownloadSection extends ConsumerWidget {
  const _ModelDownloadSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadState = ref.watch(modelDownloadProvider);
    final downloadNotifier = ref.read(modelDownloadProvider.notifier);
    final aiService = ref.watch(aiServiceProvider);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.download_rounded, color: AppColors.blue),
              const SizedBox(width: Insets.s),
              const Expanded(
                child: Text(
                  'Local AI Model (llama.cpp)',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.ink),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: aiService.isModelLoaded ? AppColors.successBg : AppColors.warningBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  aiService.isModelLoaded ? 'ACTIVE (Native)' : 'FALLBACK (Templates)',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: aiService.isModelLoaded ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.m),
          if (downloadState.status == DownloadStatus.notDownloaded) ...[
            const Text(
              'No local GGUF model found. The app is currently running in fast offline template mode.',
              style: TextStyle(fontSize: 12, color: AppColors.slate),
            ),
            const SizedBox(height: Insets.s),
            FilledButton.tonal(
              onPressed: () => downloadNotifier.startDownload(),
              child: const Text('Download TinyLlama Q4 (700MB)'),
            ),
          ] else if (downloadState.status == DownloadStatus.downloading) ...[
            Text(
              'Downloading model file: ${(downloadState.progress * 100).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.ink),
            ),
            const SizedBox(height: Insets.s),
            LinearProgressIndicator(
              value: downloadState.progress,
              backgroundColor: AppColors.lightBlue,
              color: AppColors.blue,
            ),
          ] else if (downloadState.status == DownloadStatus.downloaded) ...[
            const Text(
              'TinyLlama model successfully downloaded. Native on-device inference is fully operational.',
              style: TextStyle(fontSize: 12, color: AppColors.slate),
            ),
            const SizedBox(height: Insets.s),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => downloadNotifier.deleteModel(),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.warning),
                    child: const Text('Delete Model File'),
                  ),
                ),
              ],
            ),
          ] else if (downloadState.status == DownloadStatus.error) ...[
            Text(
              'Download failed: ${downloadState.errorMessage}',
              style: const TextStyle(fontSize: 12, color: AppColors.warning),
            ),
            const SizedBox(height: Insets.s),
            FilledButton.tonal(
              onPressed: () => downloadNotifier.startDownload(),
              child: const Text('Retry Download'),
            ),
          ],
        ],
      ),
    );
  }
}

class _DemoChatPlayground extends ConsumerStatefulWidget {
  const _DemoChatPlayground();

  @override
  ConsumerState<_DemoChatPlayground> createState() => _DemoChatPlaygroundState();
}

class _DemoChatPlaygroundState extends ConsumerState<_DemoChatPlayground> {
  final _controller = TextEditingController();
  final List<({bool fromUser, String text})> _messages = [
    (fromUser: false, text: 'Hello! I am your local AI. Ask me anything about your current goals, achievements or financial health score to test my responses!'),
  ];
  bool _busy = false;
  bool _showContext = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _compileSafeContext(WidgetRef ref) {
    final persona = ref.read(personaProvider);
    final healthAsync = ref.read(healthScoreStateProvider);
    final goals = ref.read(goalListProvider);
    final achievements = ref.read(achievementsStateProvider);

    final healthScoreText = healthAsync.maybeWhen(
      data: (h) {
        final sectionDetails = h.sections.map((s) => '${s.name}: ${s.score}/100').join(', ');
        return '${h.total}/100 ($sectionDetails)';
      },
      orElse: () => 'Not loaded',
    );

    final goalsText = goals.isEmpty 
        ? 'No active goals.' 
        : goals.map((g) => '- ${g.name} (${g.category} category): ${g.progressPercent}% complete').join('\n');

    final unlockedBadges = achievements.where((a) => a.isUnlocked).map((a) => a.title).toList();
    final badgesText = unlockedBadges.isEmpty ? 'No badges unlocked yet.' : unlockedBadges.join(', ');

    return '''
User Profile:
- Persona: ${persona.fullName} (${persona.description})
- Financial Health Score: $healthScoreText
- Active Goals:
$goalsText
- Unlocked Badges: $badgesText
''';
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _busy) return;
    _controller.clear();

    setState(() {
      _messages.add((fromUser: true, text: text));
      _busy = true;
    });

    try {
      final aiService = ref.read(aiServiceProvider);
      final persona = ref.read(personaProvider);
      final safeContext = _compileSafeContext(ref);

      final systemPrompt = '''
You are Compass, a warm, professional, privacy-safe on-device financial assistant. 
You are having a conversation with the user (persona: ${persona.fullName}). 
Here is the user's current safe financial context (only percentages, scores, and badges):
$safeContext

Answer the user's question directly, concisely (max 3 sentences), and constructively.
CRITICAL: Do NOT mention or ask for card numbers, OTPs, PINs, passwords, or exact bank balances.
''';

      final reply = await aiService.generate(
        systemPrompt: systemPrompt,
        prompt: text,
        fallbackResponse: 'I am here to help you navigate your goals and score! From your safe dashboard details, you are currently on pace for your goals with a health score of ${ref.read(healthScoreStateProvider).valueOrNull?.total ?? 84}/100.',
      );

      setState(() {
        _messages.add((fromUser: false, text: reply));
      });
    } catch (e) {
      setState(() {
        _messages.add((fromUser: false, text: 'Error generating response: $e'));
      });
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeContextText = _compileSafeContext(ref);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.blue),
              const SizedBox(width: Insets.s),
              const Expanded(
                child: Text(
                  'Local AI Chatbot Playground',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.ink),
                ),
              ),
              IconButton(
                icon: Icon(_showContext ? Icons.visibility : Icons.visibility_off, size: 18, color: AppColors.slate),
                tooltip: 'Toggle App Context View',
                onPressed: () {
                  setState(() {
                    _showContext = !_showContext;
                  });
                },
              ),
            ],
          ),
          const Text(
            'Test the LLM using direct free-form queries. App context (goals, health, achievements) is dynamically injected.',
            style: TextStyle(fontSize: 12, color: AppColors.slate),
          ),
          if (_showContext) ...[
            const SizedBox(height: Insets.s),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Insets.s + 4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.divider),
              ),
              child: Text(
                'Injected Context:\n$safeContextText',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: AppColors.slate),
              ),
            ),
          ],
          const SizedBox(height: Insets.m),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.divider),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(Insets.s),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: msg.fromUser ? AppColors.deepBlue : AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        fontSize: 12,
                        color: msg.fromUser ? Colors.white : AppColors.ink,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_busy) ...[
            const SizedBox(height: Insets.s),
            const Row(
              children: [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.blue),
                ),
                SizedBox(width: 8),
                Text('AI is thinking...', style: TextStyle(fontSize: 11, color: AppColors.slate)),
              ],
            ),
          ],
          const SizedBox(height: Insets.s),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Ask your local AI...',
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, size: 18, color: AppColors.blue),
                onPressed: _send,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Animated step-by-step view of the live pipeline run.
class _PipelineSheet extends ConsumerStatefulWidget {
  const _PipelineSheet({required this.signal});

  final SafeSignal signal;

  @override
  ConsumerState<_PipelineSheet> createState() => _PipelineSheetState();
}

class _PipelineSheetState extends ConsumerState<_PipelineSheet> {
  static const _steps = [
    'Safe signal emitted',
    'PrivacySanitizer approved the payload',
    'AI insight generated',
    'Saved to insights feed & timeline',
  ];

  int _done = 0;
  Map<String, Object>? _payload;
  Insight? _insight;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() => _done = 1);

    final level = ref.read(userSettingsProvider).privacyLevel;
    final payload =
        PrivacySanitizer.buildAiPayload(signal: widget.signal, level: level);
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() {
      _done = 2;
      _payload = payload;
    });

    final result = await ref.read(signalPipelineProvider).fire(widget.signal);
    if (!mounted) return;
    setState(() {
      _done = 3;
      _insight = result.insight;
    });

    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() => _done = 4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Insets.l,
        right: Insets.l,
        top: Insets.l,
        bottom: MediaQuery.of(context).viewInsets.bottom + Insets.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI pipeline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
          const SizedBox(height: Insets.m),
          for (var i = 0; i < _steps.length; i++) ...[
            Row(
              children: [
                if (i < _done)
                  const Icon(Icons.check_circle_rounded, size: 18, color: AppColors.success)
                else if (i == _done)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.deepBlue),
                  )
                else
                  const Icon(Icons.circle_outlined, size: 18, color: AppColors.slate),
                const SizedBox(width: 10),
                Text(_steps[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: i < _done ? FontWeight.w600 : FontWeight.w400,
                      color: i <= _done ? AppColors.ink : AppColors.slate,
                    )),
              ],
            ),
            const SizedBox(height: Insets.s),
          ],
          if (_payload != null) ...[
            const SizedBox(height: Insets.xs),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Insets.s + 4),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                [
                  '{',
                  for (final entry in _payload!.entries)
                    '  "${entry.key}": ${entry.value is String ? '"${entry.value}"' : entry.value},',
                  '}',
                ].join('\n'),
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 11, height: 1.5, color: Colors.white),
              ),
            ),
          ],
          if (_insight != null && _done >= 4) ...[
            const SizedBox(height: Insets.m),
            AppCard(
              color: AppColors.lightBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_insight!.title,
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.deepBlue)),
                  const SizedBox(height: 4),
                  Text(_insight!.body,
                      style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.ink)),
                ],
              ),
            ),
          ],
          const SizedBox(height: Insets.l),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close', style: TextStyle(color: AppColors.slate)),
              ),
              const SizedBox(width: Insets.xs),
              FilledButton(
                onPressed: _done < 4
                    ? null
                    : () {
                        Navigator.of(context).pop(); // sheet
                        context.go('/compass');
                      },
                style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
                child: const Text('View in Compass'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
