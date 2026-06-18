import 'package:flutter/material.dart';
import '../constants/navigation_routes.dart';
import '../../features/navigation/presentation/main_shell.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/ai/presentation/model_settings_screen.dart';
import '../../features/analytics/presentation/web_dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );
      case NavigationRoutes.mainShell:
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
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
      default:
        // Default fallback to main navigation shell
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
          settings: settings,
        );
    }
  }
}
