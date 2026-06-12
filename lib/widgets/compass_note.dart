import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

/// Ambient one-line AI guidance embedded inside regular banking screens.
/// Every note is accountable: the "Why?" affordance reveals the reason
/// and the privacy guarantee behind it.
class CompassNote extends StatelessWidget {
  const CompassNote({super.key, required this.text, this.reason});

  final String text;
  final String? reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.s + 4),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.deepBlue),
          const SizedBox(width: Insets.s),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.deepBlue)),
          ),
          if (reason != null) ...[
            const SizedBox(width: Insets.s),
            InkWell(
              onTap: () => _showReason(context),
              child: const Text(
                'Why?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.deepBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showReason(BuildContext context) {
    showModalBottomSheet<void>(
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
            Text(reason!, style: const TextStyle(height: 1.5, color: AppColors.slate)),
            const SizedBox(height: Insets.m),
            const Row(
              children: [
                Icon(Icons.lock_rounded, size: 13, color: AppColors.slate),
                SizedBox(width: 4),
                Text('Based on privacy-safe signals only',
                    style: TextStyle(fontSize: 12, color: AppColors.slate)),
              ],
            ),
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
}
