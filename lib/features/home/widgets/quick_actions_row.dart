import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Banking quick actions. Demo-only by design — the PRD excludes real
/// payments/UPI from MVP scope.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  static const _actions = [
    (Icons.send_rounded, 'Send'),
    (Icons.qr_code_scanner_rounded, 'Scan & Pay'),
    (Icons.receipt_long_rounded, 'Bills'),
    (Icons.description_rounded, 'Statements'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final (icon, label) in _actions)
          _QuickAction(
            icon: icon,
            label: label,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label is a demo-only action in this prototype.')),
            ),
          ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Corners.card),
      child: Padding(
        padding: const EdgeInsets.all(Insets.s),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(color: AppColors.lightBlue, shape: BoxShape.circle),
              child: Icon(icon, size: 22, color: AppColors.deepBlue),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.ink)),
          ],
        ),
      ),
    );
  }
}
