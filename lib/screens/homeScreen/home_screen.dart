import 'package:flutter/material.dart';
import 'package:wallet_app/screens/homeScreen/widgets/menu_button.dart';
import 'package:wallet_app/screens/homeScreen/widgets/transactions.dart';
import 'package:wallet_app/screens/homeScreen/widgets/balance.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff010A43),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0, right: 16, top: 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      MenuButton(),
                      Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: const Text('Hello sandra,',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)))
                    ]),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, top: 8, right: 8, bottom: 8),
                      decoration: const BoxDecoration(
                        color: Color(0xff212A6B),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        'Add money',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff426DDC),
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ]),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              margin: const EdgeInsets.only(top: 40),
              child: BalanceWidget(),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Transactions(),
            ),
          ],
        ));
  }
}
