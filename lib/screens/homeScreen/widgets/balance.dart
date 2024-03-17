import 'package:flutter/material.dart';
import 'package:wallet_app/shared/widgets/button.dart';
import 'package:wallet_app/models/balance.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BalanceWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  late final Balance balance;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Future<Balance>? getBalance() async {
      Uri url = Uri.parse(
          'https://crypto-wallet-server.mock.beeceptor.com/api/v1/balance');
      final result = await http.get(url);
      final resultData = jsonDecode(result.body);
      return Balance.fromJson(resultData);
    }

    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your current balance is',
              style: TextStyle(color: Color(0xffE7E4E4), fontSize: 12)),
          const SizedBox(
            height: 16,
          ),
          Row(children: [
            FutureBuilder<Balance>(
              future: getBalance(),
              builder: (BuildContext context, AsyncSnapshot<Balance> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    'Sorry we couldnt get your balance',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        snapshot.data!.currency,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffEEEEEE)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        snapshot.data!.balance.toString(),
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffEEEEEE)),
                      )
                    ],
                  );
                }
              },
            )
          ]),
          const SizedBox(
            height: 32,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                backgroundColor: Colors.transparent,
                label: 'Request money',
                borderColor: Color(0xff464E8A),
                textColor: Color(0xff464E8A),
              ),
              SizedBox(
                width: 15,
              ),
              Button(
                backgroundColor: Colors.transparent,
                label: 'Send money',
                borderColor: Color(0xff464E8A),
                textColor: Color(0xff464E8A),
              )
            ],
          )
        ],
      ),
    );
  }
}
