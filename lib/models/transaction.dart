class Transaction {
  final String? id;
  final String? fromWallet;
  final String? toWallet;
  final String? type;
  final double? amount;
  final String? currency;
  final String? timeStamp;

  Transaction(
      {this.id,
      this.fromWallet,
      this.toWallet,
      this.currency,
      this.type,
      this.amount,
      this.timeStamp}
    );
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json['id'],
        fromWallet: json['from_wallet'],
        toWallet: json['to_wallet'],
        amount: json['amount'],
        currency: json['currency'],
        timeStamp: json['timestamp'],
        type: json['type']);
  }
}
