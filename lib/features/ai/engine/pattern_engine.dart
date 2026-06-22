import '../../../data/models/transaction_model.dart';

class SpendingSpikeSignal {
  final String category;
  final double spikePercentage;
  final double recentSpend;
  final double historicalAverage;

  const SpendingSpikeSignal({
    required this.category,
    required this.spikePercentage,
    required this.recentSpend,
    required this.historicalAverage,
  });
}

class IdleBalanceSignal {
  final double balance;
  final double monthlySpend;
  final double estimatedIdle;

  const IdleBalanceSignal({
    required this.balance,
    required this.monthlySpend,
    required this.estimatedIdle,
  });
}

class MissedRecurringSignal {
  final String merchant;
  final int daysSinceLastSeen;

  const MissedRecurringSignal({
    required this.merchant,
    required this.daysSinceLastSeen,
  });
}

class LowBalanceSignal {
  final double balance;
  final double threshold;
  final double estimatedDays;

  const LowBalanceSignal({
    required this.balance,
    required this.threshold,
    required this.estimatedDays,
  });
}

class SalaryNoSaveSignal {
  final double salaryAmount;
  final int daysSinceCredit;

  const SalaryNoSaveSignal({
    required this.salaryAmount,
    required this.daysSinceCredit,
  });
}

class FinancialSignals {
  final SpendingSpikeSignal? spendingSpike;
  final IdleBalanceSignal? idleBalance;
  final MissedRecurringSignal? missedRecurring;
  final LowBalanceSignal? lowBalance;
  final SalaryNoSaveSignal? salaryReceivedNoSave;
  final String summaryForAgent;

  const FinancialSignals({
    this.spendingSpike,
    this.idleBalance,
    this.missedRecurring,
    this.lowBalance,
    this.salaryReceivedNoSave,
    required this.summaryForAgent,
  });
}

class PatternEngine {
  static DateTime? parseDateString(String dateStr) {
    final cleanStr = dateStr.toLowerCase().trim();
    if (cleanStr == 'today') {
      return DateTime(2026, 6, 22);
    }
    try {
      final clean = dateStr.replaceAll(',', '').trim();
      final parts = clean.split(' ');
      if (parts.length != 3) return null;
      final monthStr = parts[0].toLowerCase();
      final day = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      int month = 1;
      switch (monthStr) {
        case 'january': case 'jan': month = 1; break;
        case 'february': case 'feb': month = 2; break;
        case 'march': case 'mar': month = 3; break;
        case 'april': case 'apr': month = 4; break;
        case 'may': month = 5; break;
        case 'june': case 'jun': month = 6; break;
        case 'july': case 'jul': month = 7; break;
        case 'august': case 'aug': month = 8; break;
        case 'september': case 'sep': month = 9; break;
        case 'october': case 'oct': month = 10; break;
        case 'november': case 'nov': month = 11; break;
        case 'december': case 'dec': month = 12; break;
      }
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  static FinancialSignals analyze(List<TransactionModel> transactions, double balance) {
    final referenceDate = DateTime(2026, 6, 22);

    final datedTxs = <MapEntry<TransactionModel, DateTime>>[];
    for (final tx in transactions) {
      final date = parseDateString(tx.date);
      if (date != null) {
        datedTxs.add(MapEntry(tx, date));
      }
    }

    // 1. Spending Spike Signal
    // Spend in last 7 days vs monthly average (historical)
    final recentTxs = datedTxs.where((entry) => entry.value.isAfter(referenceDate.subtract(const Duration(days: 8)))).toList();
    final historicalTxs = datedTxs.where((entry) => entry.value.isBefore(referenceDate.subtract(const Duration(days: 7)))).toList();

    SpendingSpikeSignal? spendingSpike;
    final recentByCategory = <String, double>{};
    for (final entry in recentTxs) {
      if (entry.key.amount < 0) {
        recentByCategory[entry.key.category] = (recentByCategory[entry.key.category] ?? 0.0) + entry.key.amount.abs();
      }
    }

    final historicalByCategory = <String, double>{};
    for (final entry in historicalTxs) {
      if (entry.key.amount < 0) {
        historicalByCategory[entry.key.category] = (historicalByCategory[entry.key.category] ?? 0.0) + entry.key.amount.abs();
      }
    }

    for (final category in recentByCategory.keys) {
      final recent = recentByCategory[category]!;
      final histAvg = historicalByCategory[category] ?? 0.0;
      if (histAvg > 0 && recent > 1.5 * histAvg) {
        spendingSpike = SpendingSpikeSignal(
          category: category,
          spikePercentage: (recent / histAvg) * 100,
          recentSpend: recent,
          historicalAverage: histAvg,
        );
        break;
      }
    }

    // 2. Idle Balance Signal
    double totalHistoricalSpend = 0.0;
    for (final entry in historicalTxs) {
      if (entry.key.amount < 0) {
        totalHistoricalSpend += entry.key.amount.abs();
      }
    }
    final monthlySpend = totalHistoricalSpend > 0 ? totalHistoricalSpend : 10000.0;

    bool hasInvestmentIn30Days = false;
    for (final entry in datedTxs) {
      final isRecent30 = entry.value.isAfter(referenceDate.subtract(const Duration(days: 30)));
      if (isRecent30) {
        final categoryLower = entry.key.category.toLowerCase();
        final merchantLower = entry.key.merchant.toLowerCase();
        if (categoryLower == 'savings' || 
            categoryLower == 'investment' || 
            merchantLower.contains('sip') || 
            merchantLower.contains('mutual fund') || 
            merchantLower.contains('fixed deposit') || 
            merchantLower.contains('fd') || 
            merchantLower.contains('invest')) {
          if (entry.key.amount.abs() >= 100) {
            hasInvestmentIn30Days = true;
          }
        }
      }
    }

    IdleBalanceSignal? idleBalance;
    if (balance > 3 * monthlySpend && !hasInvestmentIn30Days) {
      idleBalance = IdleBalanceSignal(
        balance: balance,
        monthlySpend: monthlySpend,
        estimatedIdle: balance - (1.5 * monthlySpend),
      );
    }

    // 3. Missed Recurring Signal
    final mayTxs = datedTxs.where((entry) => entry.value.month == 5 && entry.value.year == 2026).toList();
    final juneTxs = datedTxs.where((entry) => entry.value.month == 6 && entry.value.year == 2026).toList();

    MissedRecurringSignal? missedRecurring;
    for (final mayEntry in mayTxs) {
      final merchant = mayEntry.key.merchant;
      final lowerMerchant = merchant.toLowerCase();
      if (lowerMerchant.contains('sip') || 
          lowerMerchant.contains('subscription') || 
          lowerMerchant.contains('wework') || 
          lowerMerchant.contains('premium') || 
          lowerMerchant.contains('bill') ||
          lowerMerchant.contains('netflix') || 
          lowerMerchant.contains('insurance')) {
        
        final hasInJune = juneTxs.any((juneEntry) => juneEntry.key.merchant == merchant);
        if (!hasInJune) {
          final diffDays = referenceDate.difference(mayEntry.value).inDays;
          missedRecurring = MissedRecurringSignal(
            merchant: merchant,
            daysSinceLastSeen: diffDays,
          );
          break;
        }
      }
    }

    // 4. Low Balance Signal
    double averageMonthlyCredit = 0.0;
    for (final entry in datedTxs) {
      if (entry.key.amount > 0 && (entry.key.category.toLowerCase() == 'salary' || entry.key.merchant.toLowerCase().contains('salary'))) {
        averageMonthlyCredit = entry.key.amount;
      }
    }
    if (averageMonthlyCredit == 0) {
      averageMonthlyCredit = 50000.0;
    }

    LowBalanceSignal? lowBalance;
    final threshold = 0.20 * averageMonthlyCredit;
    if (balance < threshold) {
      double recentSpendSum = 0.0;
      for (final entry in recentTxs) {
        if (entry.key.amount < 0) {
          recentSpendSum += entry.key.amount.abs();
        }
      }
      final dailySpendRate = recentSpendSum > 0 ? (recentSpendSum / 7.0) : 300.0;
      lowBalance = LowBalanceSignal(
        balance: balance,
        threshold: threshold,
        estimatedDays: balance / dailySpendRate,
      );
    }

    // 5. Salary Credited, No Savings Action Taken
    SalaryNoSaveSignal? salaryReceivedNoSave;
    MapEntry<TransactionModel, DateTime>? recentSalaryCredit;
    for (final entry in recentTxs) {
      if (entry.key.amount > 15000 && (entry.key.category.toLowerCase() == 'salary' || entry.key.merchant.toLowerCase().contains('salary'))) {
        recentSalaryCredit = entry;
        break;
      }
    }

    if (recentSalaryCredit != null) {
      bool hasSavingsAfterSalary = false;
      for (final entry in datedTxs) {
        if (entry.value.isAfter(recentSalaryCredit.value)) {
          final catLower = entry.key.category.toLowerCase();
          final merchLower = entry.key.merchant.toLowerCase();
          if (catLower == 'savings' || 
              catLower == 'investment' || 
              merchLower.contains('sip') || 
              merchLower.contains('save') || 
              merchLower.contains('fd') || 
              merchLower.contains('deposit')) {
            hasSavingsAfterSalary = true;
          }
        }
      }

      if (!hasSavingsAfterSalary) {
        final days = referenceDate.difference(recentSalaryCredit.value).inDays;
        salaryReceivedNoSave = SalaryNoSaveSignal(
          salaryAmount: recentSalaryCredit.key.amount,
          daysSinceCredit: days,
        );
      }
    }

    final buffer = StringBuffer();
    if (spendingSpike != null) {
      buffer.write('User spent ₹${spendingSpike.recentSpend.toStringAsFixed(0)} on ${spendingSpike.category} in the last 7 days, which is ${spendingSpike.spikePercentage.toStringAsFixed(0)}% of their historical monthly average of ₹${spendingSpike.historicalAverage.toStringAsFixed(0)}. ');
    }
    if (idleBalance != null) {
      buffer.write('User has ₹${idleBalance.balance.toStringAsFixed(0)} idle in savings, with ₹${idleBalance.estimatedIdle.toStringAsFixed(0)} estimated as idle (exceeding 3x monthly spend of ₹${idleBalance.monthlySpend.toStringAsFixed(0)}) and no investment action in 30 days. ');
    }
    if (missedRecurring != null) {
      buffer.write('A recurring payment to "${missedRecurring.merchant}" was missed this month (last seen ${missedRecurring.daysSinceLastSeen} days ago). ');
    }
    if (lowBalance != null) {
      buffer.write('User balance is low at ₹${lowBalance.balance.toStringAsFixed(0)} (under 20% of salary threshold ₹${lowBalance.threshold.toStringAsFixed(0)}), estimated to last ${lowBalance.estimatedDays.toStringAsFixed(1)} days. ');
    }
    if (salaryReceivedNoSave != null) {
      buffer.write('Salary of ₹${salaryReceivedNoSave.salaryAmount.toStringAsFixed(0)} was credited ${salaryReceivedNoSave.daysSinceCredit} days ago, but no savings or investment action has been taken since. ');
    }
    if (buffer.isEmpty) {
      buffer.write('User\'s spending patterns and savings rate are normal this period.');
    }
    final summaryForAgent = buffer.toString().trim();

    return FinancialSignals(
      spendingSpike: spendingSpike,
      idleBalance: idleBalance,
      missedRecurring: missedRecurring,
      lowBalance: lowBalance,
      salaryReceivedNoSave: salaryReceivedNoSave,
      summaryForAgent: summaryForAgent,
    );
  }
}
