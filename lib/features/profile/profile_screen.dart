import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../services/firebase/firebase_bootstrap.dart';
import '../../widgets/app_card.dart';
import 'privacy_center_screen.dart';

/// Profile: account header, backend status and entry points to settings.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAvailable = ref.watch(firebaseAvailableProvider);
    final userId = ref.watch(currentUserIdProvider);

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
          const SizedBox(height: Insets.s + 4),
          AppCard(
            child: Row(
              children: [
                Icon(
                  firebaseAvailable ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                  color: firebaseAvailable ? AppColors.success : AppColors.slate,
                ),
                const SizedBox(width: Insets.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firebaseAvailable ? 'Connected to Firebase' : 'Local demo mode',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
                      ),
                      Text(
                        firebaseAvailable
                            ? 'Signed in anonymously · ${userId == null ? '' : userId.substring(0, userId.length < 8 ? userId.length : 8)}…'
                            : 'Run flutterfire configure to enable the cloud backend.',
                        style: const TextStyle(fontSize: 12, color: AppColors.slate),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.s + 4),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.shield_rounded, color: AppColors.deepBlue),
                  title: const Text('Privacy Control Center', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Control how deep the AI personalization goes', style: TextStyle(fontSize: 12, color: AppColors.slate)),
                  trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.slate),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PrivacyCenterScreen()),
                  ),
                ),
                const Divider(height: 1, indent: Insets.m, endIndent: Insets.m),
                ListTile(
                  leading: const Icon(Icons.info_rounded, color: AppColors.deepBlue),
                  title: const Text('About ${AppConstants.appName}', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.slate),
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: AppConstants.appName,
                    applicationVersion: '0.1.0',
                    children: const [Text(AppConstants.tagline)],
                  ),
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
