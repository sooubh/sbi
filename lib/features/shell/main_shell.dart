import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../compass/compass_screen.dart';
import '../goals/goals_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../timeline/timeline_screen.dart';

/// Bottom-navigation tabs in display order.
enum ShellTab { home, compass, goals, timeline, profile }

/// Currently selected tab. Exposed as a provider so any feature can
/// deep-link to a tab (e.g. Home "View all" → Goals).
final shellIndexProvider = StateProvider<int>((_) => ShellTab.home.index);

/// Bottom-navigation shell: Home, Compass, Goals, Timeline, Profile
/// (PRD section 6).
class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const _screens = [
    HomeScreen(),
    CompassScreen(),
    GoalsScreen(),
    TimelineScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(shellIndexProvider);
    return Scaffold(
      body: IndexedStack(index: index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) =>
            ref.read(shellIndexProvider.notifier).state = i,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded), label: 'Compass'),
          NavigationDestination(icon: Icon(Icons.flag_outlined), selectedIcon: Icon(Icons.flag_rounded), label: 'Goals'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history_rounded), label: 'Timeline'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
