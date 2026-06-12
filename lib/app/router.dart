import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/chat/chat_screen.dart';
import '../features/compass/compass_screen.dart';
import '../features/compass/life_events_screen.dart';
import '../features/demo_console/demo_console_screen.dart';
import '../features/goals/goals_screen.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/profile/privacy_center_screen.dart';
import '../features/recommendations/recommendations_screen.dart';
import '../features/shell/main_shell.dart';
import '../features/splash/splash_screen.dart';
import '../features/story/weekly_story_screen.dart';
import '../features/timeline/timeline_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/weekly-story',
        builder: (context, state) => const WeeklyStoryScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/life-events',
        builder: (context, state) => const LifeEventsScreen(),
      ),
      GoRoute(
        path: '/recommendations',
        builder: (context, state) => const RecommendationsScreen(),
      ),
      GoRoute(
        path: '/privacy-center',
        builder: (context, state) => const PrivacyCenterScreen(),
      ),
      GoRoute(
        path: '/demo-console',
        builder: (context, state) => const DemoConsoleScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/compass',
                builder: (context, state) => const CompassScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/goals',
                builder: (context, state) => const GoalsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/timeline',
                builder: (context, state) => const TimelineScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
