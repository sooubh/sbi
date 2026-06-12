import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

/// Transparency widget: shows how confident the AI is in an insight.
class ConfidenceIndicator extends StatelessWidget {
  const ConfidenceIndicator({super.key, required this.confidence});

  /// 0.0–1.0.
  final double confidence;

  @override
  Widget build(BuildContext context) {
    final pct = (confidence * 100).round();
    final color = confidence >= 0.85 ? AppColors.success : AppColors.blue;
    return Row(
      children: [
        const Text('Confidence',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.slate)),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Corners.chip),
            child: LinearProgressIndicator(
              value: confidence.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text('$pct%',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }
}
