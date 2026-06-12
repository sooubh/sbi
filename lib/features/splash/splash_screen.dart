import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../services/app_prefs.dart';
import '../onboarding/onboarding_screen.dart';
import '../shell/main_shell.dart';

/// Animated splash with privacy-first branding (PRD Screen 1). Returning
/// users skip onboarding and land directly on the shell.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), _go);
  }

  void _go() {
    if (!mounted) return;
    final onboarded = ref.read(appPrefsProvider).onboardingComplete;
    final Widget next =
        onboarded ? const MainShell() : const OnboardingScreen();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) =>
            FadeTransition(opacity: animation, child: next),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.explore_rounded, size: 56, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.tagline,
                  style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8)),
                ),
                const SizedBox(height: 40),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
