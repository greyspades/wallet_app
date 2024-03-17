import 'dart:convert';
import 'package:wallet_app/models/balance.dart';
import 'package:http/http.dart' as http;

Future<Balance>? getBalance() async {
  Uri url =
      Uri.parse('https://crypto-wallet-server.mock.beeceptor.com/api/v1/balance');
  final result = await http.get(url);
  final resultData = jsonDecode(result.body);
    return Balance.fromJson(resultData);
}