import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/privacy/privacy_level.dart';
import '../../core/privacy/privacy_sanitizer.dart';
import '../../core/privacy/safe_signal.dart';
import '../../core/theme/app_colors.dart';
import '../../services/user_settings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';

/// Privacy Control Center (PRD Feature 8 / Screen 10): personalization
/// level, AI permissions, consent management and a live preview of the
/// exact payload the AI receives.
class PrivacyCenterScreen extends ConsumerWidget {
  const PrivacyCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);
    final notifier = ref.read(userSettingsProvider.notifier);

    // Built through the real chokepoint — this IS the AI payload.
    final payload = PrivacySanitizer.buildAiPayload(
      signal: SafeSignal(
        type: 'savings_consistency_improved',
        category: 'savings',
        severity: SignalSeverity.positive,
        timestamp: DateTime.now(),
      ),
      level: settings.privacyLevel,
      goalProgressPercent: 72,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Control Center', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Insets.m),
        children: [
          const SectionHeader(title: 'What the AI can see'),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Insets.m),
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    [
                      '{',
                      for (final entry in payload.entries)
                        '  "${entry.key}": ${entry.value is String ? '"${entry.value}"' : entry.value},',
                      '}',
                    ].join('\n'),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: Insets.s + 4),
                const Row(
                  children: [
                    Icon(Icons.lock_rounded, size: 14, color: AppColors.slate),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'This is the entire payload sent to the AI. Balances, account '
                        'numbers and transactions never leave your banking data.',
                        style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.slate),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'Personalization level'),
          for (final level in PrivacyLevel.values) ...[
            AppCard(
              color: settings.privacyLevel == level ? AppColors.lightBlue : AppColors.surface,
              onTap: () => notifier.setPrivacyLevel(level),
              child: Row(
                children: [
                  Icon(
                    settings.privacyLevel == level
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: AppColors.deepBlue,
                  ),
                  const SizedBox(width: Insets.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(level.label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                        Text(level.description, style: const TextStyle(fontSize: 13, color: AppColors.slate)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Insets.s),
          ],
          const SizedBox(height: Insets.s),
          const SectionHeader(title: 'AI permissions'),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.xs),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.detailedInsights,
                  onChanged: notifier.setDetailedInsights,
                  title: const Text('Detailed insights', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  subtitle: const Text('When off, insights stay generic.', style: TextStyle(fontSize: 12, color: AppColors.slate)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.eventTracking,
                  onChanged: notifier.setEventTracking,
                  title: const Text('Life event tracking', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Detect events from behavioral patterns.', style: TextStyle(fontSize: 12, color: AppColors.slate)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.goalTracking,
                  onChanged: notifier.setGoalTracking,
                  title: const Text('Goal tracking', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Allow AI nudges on goal progress.', style: TextStyle(fontSize: 12, color: AppColors.slate)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.chatExplanations,
                  onChanged: notifier.setChatExplanations,
                  title: const Text('Chat explanation mode', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Allow the limited explain-only chat.', style: TextStyle(fontSize: 12, color: AppColors.slate)),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'Consent'),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.xs),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: settings.demoConsent,
              onChanged: notifier.setDemoConsent,
              title: const Text('Demo consent', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              subtitle: const Text(
                'Use realistic demo data for this prototype. Revoking consent can be done anytime.',
                style: TextStyle(fontSize: 12, color: AppColors.slate),
              ),
            ),
          ),
          const SizedBox(height: Insets.m),
        ],
      ),
    );
  }
}
