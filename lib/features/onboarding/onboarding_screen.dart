import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../services/app_prefs.dart';
import '../../services/user_settings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/privacy_level_selector.dart';
import '../shell/main_shell.dart';

/// Three-step onboarding: welcome, privacy explanation, personalization
/// level + demo consent (PRD Screen 2). Completion is persisted so
/// returning users go straight to the shell.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  void _next() {
    if (_page < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      ref.read(appPrefsProvider).setOnboardingComplete();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(userSettingsProvider);
    final notifier = ref.read(userSettingsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  const _OnboardPage(
                    icon: Icons.explore_rounded,
                    title: 'Welcome to ${AppConstants.appName}',
                    body:
                        'A smarter banking experience with an AI companion that '
                        'helps you stay on top of your financial life.',
                  ),
                  const _OnboardPage(
                    icon: Icons.shield_rounded,
                    title: 'Private by design',
                    body:
                        'The AI never sees your balances, account numbers or '
                        'transactions. It works only on safe behavioral '
                        'signals — patterns, not records.',
                  ),
                  _PersonalizationPage(settings: settings, notifier: notifier),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.l),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _page == i ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _page == i ? AppColors.deepBlue : AppColors.divider,
                          borderRadius: BorderRadius.circular(Corners.chip),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: Insets.m),
                  FilledButton(
                    onPressed: _next,
                    child: Text(_page == 2 ? 'Get started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  const _OnboardPage({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(26),
            decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
            child: Icon(icon, size: 52, color: AppColors.deepBlue),
          ),
          const SizedBox(height: Insets.l),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink),
          ),
          const SizedBox(height: Insets.m),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, height: 1.5, color: AppColors.slate),
          ),
        ],
      ),
    );
  }
}

class _PersonalizationPage extends StatelessWidget {
  const _PersonalizationPage({required this.settings, required this.notifier});

  final UserSettings settings;
  final UserSettingsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Insets.l),
      children: [
        const SizedBox(height: Insets.m),
        const Text(
          'Choose your AI depth',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink),
        ),
        const SizedBox(height: Insets.s),
        const Text(
          'You can change this anytime in the Privacy Control Center.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.slate),
        ),
        const SizedBox(height: Insets.l),
        PrivacyLevelSelector(
          selected: settings.privacyLevel,
          onChanged: notifier.setPrivacyLevel,
        ),
        const SizedBox(height: Insets.s),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.xs),
          child: SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: settings.demoConsent,
            onChanged: notifier.setDemoConsent,
            title: const Text('Demo consent', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            subtitle: const Text(
              'Use realistic demo data for this prototype.',
              style: TextStyle(fontSize: 13, color: AppColors.slate),
            ),
          ),
        ),
      ],
    );
  }
}
