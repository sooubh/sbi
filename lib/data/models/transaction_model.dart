class TransactionModel {
  final String id;
  final String merchant;
  final String category;
  final double amount;
  final String date;

  const TransactionModel({
    required this.id,
    required this.merchant,
    required this.category,
    required this.amount,
    required this.date,
  });

  bool get isCredit => amount > 0;
}
