import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

enum TrendDirection { up, down, flat }

/// Small pill indicating a trend, e.g. "Improving".
class TrendChip extends StatelessWidget {
  const TrendChip({super.key, required this.label, this.direction = TrendDirection.up});

  final String label;
  final TrendDirection direction;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, icon) = switch (direction) {
      TrendDirection.up => (AppColors.successBg, AppColors.success, Icons.trending_up_rounded),
      TrendDirection.down => (AppColors.warningBg, AppColors.warning, Icons.trending_down_rounded),
      TrendDirection.flat => (AppColors.lightBlue, AppColors.deepBlue, Icons.trending_flat_rounded),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Corners.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
        ],
      ),
    );
  }
}
