import 'package:flutter/material.dart';

import '../../widgets/coming_soon.dart';

/// Compass Dashboard (PRD Screen 4) — full implementation lands in Phase 2.
class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compass', style: TextStyle(fontWeight: FontWeight.w800))),
      body: const ComingSoon(title: 'Compass Dashboard', phase: 'Phase 2', icon: Icons.explore_rounded),
    );
  }
}
