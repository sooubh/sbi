import 'package:flutter/material.dart';

import '../../widgets/coming_soon.dart';

/// Goals screen (PRD Screen 6) — full implementation lands in Phase 2.
class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals', style: TextStyle(fontWeight: FontWeight.w800))),
      body: const ComingSoon(title: 'Goal Coach', phase: 'Phase 2', icon: Icons.flag_rounded),
    );
  }
}
