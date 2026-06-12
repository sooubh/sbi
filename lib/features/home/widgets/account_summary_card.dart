import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/trend_chip.dart';

/// Demo account summary (PRD Screen 3). All figures are local placeholder
/// data and are NEVER passed to the AI layer.
class AccountSummaryCard extends StatefulWidget {
  const AccountSummaryCard({super.key});

  @override
  State<AccountSummaryCard> createState() => _AccountSummaryCardState();
}

class _AccountSummaryCardState extends State<AccountSummaryCard> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_balance_rounded, size: 18, color: AppColors.slate),
              SizedBox(width: Insets.s),
              Expanded(
                child: Text('Savings Account  ••••  4821',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.slate)),
              ),
              TrendChip(label: 'Savings up'),
            ],
          ),
          const SizedBox(height: Insets.m),
          Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _visible ? '₹ 1,28,540.00' : '₹ ••••••',
                  key: ValueKey(_visible),
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
              ),
              const SizedBox(width: Insets.s),
              IconButton(
                onPressed: () => setState(() => _visible = !_visible),
                icon: Icon(
                  _visible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  size: 20,
                  color: AppColors.slate,
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.xs),
          const Row(
            children: [
              Icon(Icons.lock_rounded, size: 13, color: AppColors.slate),
              SizedBox(width: 4),
              Text('Demo data — never shared with AI',
                  style: TextStyle(fontSize: 12, color: AppColors.slate)),
            ],
          ),
        ],
      ),
    );
  }
}
