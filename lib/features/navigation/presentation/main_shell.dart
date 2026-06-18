import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/bottom_nav_state.dart';
import '../../home/presentation/home_screen.dart';
import '../../accounts/presentation/accounts_screen.dart';
import '../../services/presentation/services_screen.dart';
import '../../menu/presentation/menu_screen.dart';

import '../../onboarding/presentation/onboarding_screen.dart';
import '../../../data/repositories/state_providers.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    AccountsScreen(),
    ServicesScreen(),
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    
    if (user.newUser) {
      return const OnboardingScreen();
    }

    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(bottomNavIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            activeIcon: Icon(Icons.menu_rounded),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
