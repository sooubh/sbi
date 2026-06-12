import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../models/insight.dart';

/// Shared explainable-AI bottom sheet: "why you see this" + suggested
/// action. Used by every insight surface in the app.
Future<void> showInsightExplanation(BuildContext context, Insight insight) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Corners.sheet)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(Insets.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shield_rounded, color: AppColors.deepBlue),
              SizedBox(width: Insets.s),
              Text('Why you see this',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
            ],
          ),
          const SizedBox(height: Insets.m),
          Text(insight.reason, style: const TextStyle(height: 1.5, color: AppColors.slate)),
          const SizedBox(height: Insets.m),
          const Text('Suggested action',
              style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 4),
          Text(insight.recommendation, style: const TextStyle(height: 1.5, color: AppColors.slate)),
          const SizedBox(height: Insets.l),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    ),
  );
}
