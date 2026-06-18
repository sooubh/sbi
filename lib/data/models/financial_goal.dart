class FinancialGoal {
  final String id;
  final String name;
  final double targetAmount;
  final double savedAmount;
  final double monthlyContribution;
  final String status; // 'active' | 'completed'

  const FinancialGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.savedAmount,
    required this.monthlyContribution,
    required this.status,
  });

  double get progress => (savedAmount / targetAmount).clamp(0.0, 1.0);
  int get progressPercent => (progress * 100).toInt();

  FinancialGoal copyWith({
    String? id,
    String? name,
    double? targetAmount,
    double? savedAmount,
    double? monthlyContribution,
    String? status,
  }) {
    return FinancialGoal(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      savedAmount: savedAmount ?? this.savedAmount,
      monthlyContribution: monthlyContribution ?? this.monthlyContribution,
      status: status ?? this.status,
    );
  }
}
