import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/privacy/privacy_level.dart';
import '../core/theme/app_colors.dart';
import 'app_card.dart';

/// Shared personalization-level picker used by onboarding and the
/// Privacy Control Center.
class PrivacyLevelSelector extends StatelessWidget {
  const PrivacyLevelSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final PrivacyLevel selected;
  final ValueChanged<PrivacyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final level in PrivacyLevel.values) ...[
          AppCard(
            color: selected == level ? AppColors.lightBlue : AppColors.surface,
            onTap: () => onChanged(level),
            child: Row(
              children: [
                Icon(
                  selected == level
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: AppColors.deepBlue,
                ),
                const SizedBox(width: Insets.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(level.label,
                          style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                      const SizedBox(height: 2),
                      Text(level.description,
                          style: const TextStyle(fontSize: 13, color: AppColors.slate)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.s + 4),
        ],
      ],
    );
  }
}
