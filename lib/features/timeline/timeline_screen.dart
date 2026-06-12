import 'package:flutter/material.dart';

import '../../widgets/coming_soon.dart';

/// Agent Timeline (PRD Screen 7) — full implementation lands in Phase 2.
class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timeline', style: TextStyle(fontWeight: FontWeight.w800))),
      body: const ComingSoon(title: 'Agent Timeline', phase: 'Phase 2', icon: Icons.history_rounded),
    );
  }
}
