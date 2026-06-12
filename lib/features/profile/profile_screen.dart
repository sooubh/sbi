import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/privacy/privacy_level.dart';
import '../../core/theme/app_colors.dart';
import '../../services/user_settings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';

/// Profile with live privacy & AI controls. These controls are the seed of
/// the Privacy Control Center (PRD Feature 8), expanded in Phase 3.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);
    final notifier = ref.read(userSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.w800))),
      body: ListView(
        padding: const EdgeInsets.all(Insets.m),
        children: [
          const AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.lightBlue,
                  child: Text('AR', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.deepBlue)),
                ),
                SizedBox(width: Insets.m),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aarav Rao', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink)),
                    Text('Demo profile — young professional', style: TextStyle(fontSize: 13, color: AppColors.slate)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.m),
          const SectionHeader(title: 'AI personalization level'),
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
                  value: settings.eventTracking,
                  onChanged: notifier.setEventTracking,
                  title: const Text('Life event tracking', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.goalTracking,
                  onChanged: notifier.setGoalTracking,
                  title: const Text('Goal tracking', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.chatExplanations,
                  onChanged: notifier.setChatExplanations,
                  title: const Text('Chat explanation mode', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.m),
          const Center(
            child: Text(
              '${AppConstants.appName} • ${AppConstants.tagline}',
              style: TextStyle(fontSize: 12, color: AppColors.slate),
            ),
          ),
        ],
      ),
    );
  }
}
