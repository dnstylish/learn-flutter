class Transaction {
  String? content;
  int? amount;
  DateTime? createdAt;

  Transaction({required this.content, required this.amount, required this.createdAt});

  @override
  String toString() {
    return '$content - $amount';
  }

  reset() {
    this.amount = 0;
    this.content = '';
  }
}