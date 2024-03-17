import 'dart:convert';
import 'package:wallet_app/models/user.dart';
import 'package:wallet_app/models/authentication.dart';
import 'package:http/http.dart' as http;

Future<User?> Register(String username, String email, String password) async {
  Uri url = Uri.parse(
      'https://crypto-wallet-server.mock.beeceptor.com/api/v1/register');
  var body =
      jsonEncode({'username': username, 'email': email, 'password': password});

  final result = await http.post(url, body: body);
  if (result.statusCode == 200) {
    final resultData = jsonDecode(result.body);
    return User.fromJson(resultData);
  }
}

Future<Auth?> Login(String email, String password) async {
  Uri url =
      Uri.parse('https://crypto-wallet-server.mock.beeceptor.com/api/v1/login');
  var body = jsonEncode({'email': email, 'password': password});
  final result = await http.post(url, body: body);
  print(result.body);
  if (result.statusCode == 200) {
    final resultData = jsonDecode(result.body);
    return Auth.fromJson(resultData);
  }
}
