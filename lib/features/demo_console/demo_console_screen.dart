import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/privacy/privacy_sanitizer.dart';
import '../../core/privacy/safe_signal.dart';
import '../../core/theme/app_colors.dart';
import '../../models/insight.dart';
import '../../services/ai/signal_pipeline.dart';
import '../../services/persona.dart';
import '../../services/user_settings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../shell/main_shell.dart';

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
                        final nav = Navigator.of(context);
                        nav.pop(); // sheet
                        nav.pop(); // console
                        ref.read(shellIndexProvider.notifier).state =
                            ShellTab.compass.index;
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
