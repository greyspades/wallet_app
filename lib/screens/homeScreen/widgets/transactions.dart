import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wallet_app/models/transaction.dart';
import 'package:http/http.dart' as http;

class Transactions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  Future<List<Transaction>>? getTransactions() async {
    Uri url = Uri.parse(
        'https://crypto-wallet-server.mock.beeceptor.com/api/v1/transactions');
    final result = await http.get(url);
    final resultData = List.from(jsonDecode(result.body)['transactions']);
    return resultData.map((e) => Transaction.fromJson(e)).toList();
  }

  final List<String> avatars = [
    'avatar1.png',
    'avatar2.png',
    'avatar3.png',
  ];
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      width: deviceWidth,
      padding: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Color(0xff10194E),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40))),
      child: Stack(alignment: Alignment.topCenter, children: [
        Positioned(
          top: 12,
          child: Container(
            height: 7,
            width: 64,
            decoration: const BoxDecoration(
                color: Color(0xff4E589F),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Transactions',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                child: const Row(
                  children: [
                    Text('Sort by:',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff4E589F))),
                    SizedBox(
                      width: 9,
                    ),
                    Text('Recent',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xffDDD9D9))),
                    Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 80),
            height: deviceHeight * 0.3,
            child: FutureBuilder<List<Transaction>>(
              future: getTransactions(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Transaction>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      width: 64,
                      height: 64,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ));
                } else if (snapshot.hasError) {
                  return const Text(
                    'Sorry we couldnt get your history',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Transaction transaction = snapshot.data![index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color(0xff192259)
                            : const Color(0xff10194E),
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 16),
                        child: Row(children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/${avatars[index]}'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.fromWallet ??
                                    transaction.toWallet ??
                                    '',
                                style: const TextStyle(
                                    color: Color(0xff858EC5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: transaction.type == 'credit'
                                        ? const Color(0xff1DC7AC)
                                        : const Color(0xffFAAD39)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Icon(
                                          transaction.type == 'credit'
                                              ? Icons.trending_up
                                              : Icons.trending_down,
                                          color: transaction.type == 'credit'
                                              ? const Color(0xff1DC7AC)
                                              : const Color(0xffFAAD39),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        transaction.type ?? '',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ]),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                '${transaction.currency} ${transaction.amount.toString()}',
                                style: TextStyle(
                                    color: transaction.type == 'credit'
                                        ? const Color(0xff1DC7AC)
                                        : const Color(0xffFAAD39),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ]),
                      );
                    },
                  );
                }
              },
            ))
      ]),
    );
  }
}
