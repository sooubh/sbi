import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/navigation_routes.dart';
import '../../features/navigation/presentation/main_shell.dart';
import '../../features/navigation/state/bottom_nav_state.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/ai/presentation/model_settings_screen.dart';
import '../../features/analytics/presentation/web_dashboard_screen.dart';
import '../../features/services/presentation/send_money_screen.dart';
import '../../features/ai/presentation/financial_coach_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );
      case '/onboarding/kyc':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(
            initialStep: OnboardingStep.videoKyc,
          ),
          settings: settings,
        );
      case '/onboarding/upi':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(
            initialStep: OnboardingStep.upiSetup,
          ),
          settings: settings,
        );
      case NavigationRoutes.mainShell:
      case NavigationRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const _TabRouteShell(tabIndex: 0),
          settings: settings,
        );
      case NavigationRoutes.accounts:
        return MaterialPageRoute(
          builder: (_) => const _TabRouteShell(tabIndex: 1),
          settings: settings,
        );
      case NavigationRoutes.services:
      case '/services/fd':
      case '/services/sip':
      case '/services/insurance':
        return MaterialPageRoute(
          builder: (_) => const _TabRouteShell(tabIndex: 2),
          settings: settings,
        );
      case NavigationRoutes.menu:
      case '/card-control':
        return MaterialPageRoute(
          builder: (_) => const _TabRouteShell(tabIndex: 3),
          settings: settings,
        );
      case NavigationRoutes.goalCreation:
      case '/goals/create':
        return MaterialPageRoute(
          builder: (_) => const _TabRouteShell(tabIndex: 0),
          settings: settings,
        );
      case NavigationRoutes.chat:
        return MaterialPageRoute(
          builder: (_) => const _TabRouteShell(tabIndex: 2),
          settings: settings,
        );
      case NavigationRoutes.modelSettings:
        return MaterialPageRoute(
          builder: (_) => const ModelSettingsScreen(),
          settings: settings,
        );
      case NavigationRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const WebDashboardScreen(),
          settings: settings,
        );
      case NavigationRoutes.sendMoney:
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => SendMoneyScreen(
            recipient: args?['recipient'],
            amount: args?['amount'],
          ),
          settings: settings,
        );
      case NavigationRoutes.financialCoach:
        return MaterialPageRoute(
          builder: (_) => const FinancialCoachScreen(),
          settings: settings,
        );
      default:
        // Default fallback to main navigation shell
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
          settings: settings,
        );
    }
  }
}

class _TabRouteShell extends ConsumerWidget {
  final int tabIndex;

  const _TabRouteShell({required this.tabIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bottomNavIndexProvider.notifier).state = tabIndex;
    });
    return const MainShell();
  }
}
