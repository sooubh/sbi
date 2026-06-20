import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/navigation_routes.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../data/repositories/state_providers.dart';
import '../../services/widgets/ai_chat_modal.dart';
import '../../ai/presentation/ai_dev_config_modal.dart';
import '../../../core/widgets/debug_panel.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  void _showLocatorDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ATM & Branch Locator',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildLocationTile(context, 'SBI Branch - Connaught Place', '0.4 km · Open until 4:00 PM'),
              const Divider(height: 1),
              _buildLocationTile(context, 'SBI ATM - Parliament Street', '0.6 km · 24/7 Dispenser active'),
              const Divider(height: 1),
              _buildLocationTile(context, 'SBI E-Corner - Rajiv Chowk', '0.8 km · Cash recycler active'),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationTile(BuildContext context, String name, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppTheme.sbiBlue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.directions_rounded, color: AppTheme.aiTeal, size: 20),
        ],
      ),
    );
  }

  void _showSecurityDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Security Center',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Biometric Login'),
                    subtitle: const Text('Use FaceID/Fingerprint for fast access'),
                    value: true,
                    activeTrackColor: AppTheme.aiTeal.withValues(alpha: 0.5),
                    activeThumbColor: AppTheme.aiTeal,
                    onChanged: (val) {},
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('2-Factor Authentication'),
                    subtitle: const Text('Requires SMS OTP for major transactions'),
                    value: true,
                    activeTrackColor: AppTheme.aiTeal.withValues(alpha: 0.5),
                    activeThumbColor: AppTheme.aiTeal,
                    onChanged: (val) {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Change Access PIN'),
                    subtitle: const Text('Last updated 3 months ago'),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Simulated Change PIN wizard launched.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'App Settings',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.language_rounded, color: AppTheme.sbiBlue),
                title: const Text('App Language'),
                subtitle: const Text('English (US)'),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.brightness_medium_rounded, color: AppTheme.sbiBlue),
                title: const Text('Visual Theme'),
                subtitle: const Text('System Default (Light)'),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.notifications_active_rounded, color: AppTheme.sbiBlue),
                title: const Text('Push Notifications'),
                subtitle: const Text('All alerts enabled'),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {},
              ),
              if (kDebugMode) ...[
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.bug_report_rounded, color: Colors.red),
                  title: const Text(
                    'Debug Console',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Inspect provider registry & configs'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.red),
                  onTap: () {
                    Navigator.of(context).pop();
                    DebugPanel.show(context);
                  },
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final engagement = ref.watch(engagementProvider);

    return GradientScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Screen title
            Text(
              'Menu',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Profile Info Header Card
            SooubhCard(
              child: Row(
                children: [
                  // Circular initial avatar
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.softShadow,
                    ),
                    child: const Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Savings Account · ${user.maskedAccount}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening Profile Editor...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, color: AppTheme.sbiBlue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Badges Section
            Text(
              'Your Badges & Achievements',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SooubhCard(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: engagement.unlockedAchievements.map((badge) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.aiTeal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.aiTeal.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.workspace_premium_rounded, color: AppTheme.aiTeal, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            badge,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.aiTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Links Box Card
            SooubhCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildMenuTile(
                    context: context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => _showSettingsDialog(context),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.security_outlined,
                    title: 'Security Center',
                    onTap: () => _showSecurityDialog(context),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Support ticket system activated. Support ID: #9832'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.stars_outlined,
                    title: 'Rewards',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rewards Ledger: 350 SBI points active.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.local_offer_outlined,
                    title: 'Offers',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pre-approved credit limits & partner offers synced.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.location_on_outlined,
                    title: 'ATM Locator',
                    onTap: () => _showLocatorDialog(context),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.insights_rounded,
                    title: 'AI Financial Coach',
                    onTap: () => Navigator.of(context).pushNamed(NavigationRoutes.financialCoach),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildMenuTile(
                    context: context,
                    icon: Icons.settings_suggest_outlined,
                    title: 'AI & Developer Settings',
                    onTap: () => AiDevConfigModal.show(context),
                  ),
                  if (kDebugMode) ...[
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.bug_report_rounded, color: Colors.red, size: 20),
                      ),
                      title: Row(
                        children: [
                          Text(
                            'Debug Console',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'DEV',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: const Text(
                        'View providers, settings & simulation states',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.red),
                      onTap: () => DebugPanel.show(context),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Highlighted AI Assistant launcher Card
            SooubhCard(
              hasAiBorder: true,
              onTap: () => AiChatModal.show(context),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.aiTeal.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bolt_rounded, color: AppTheme.aiTeal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sooubh AI Assistant',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.aiTeal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Consult with AI on setup and settings help',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppTheme.aiTeal),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      leading: Icon(icon, color: AppTheme.sbiBlue),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary),
      onTap: onTap,
    );
  }
}
