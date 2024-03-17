class Balance {
  double balance;
  String currency;
  Balance({required this.balance, required this.currency});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(balance: json['balance'], currency: json['currency']);
  }
}