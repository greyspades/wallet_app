import 'dart:convert';
import 'package:wallet_app/models/transaction.dart';
import 'package:http/http.dart' as http;

Future<List<Transaction>>? getBalance() async {
  Uri url =
      Uri.parse('https://crypto-wallet-server.mock.beeceptor.com/api/v1/transactions');
  final result = await http.get(url);
  final resultData = List.from(jsonDecode(result.body));
  return resultData.map((e) => Transaction.fromJson(e)).toList();
}