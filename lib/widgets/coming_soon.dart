import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Temporary placeholder for screens scheduled in a later build phase.
/// Each usage is removed when its feature lands (PRD section 17).
class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key, required this.title, required this.phase, required this.icon});

  final String title;
  final String phase;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
            child: Icon(icon, size: 40, color: AppColors.deepBlue),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 6),
          Text('Arriving in $phase of the build plan.', style: const TextStyle(color: AppColors.slate)),
        ],
      ),
    );
  }
}
