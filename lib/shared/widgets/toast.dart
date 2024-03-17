import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final String title;
  final bool isLoading;
  const Toast({super.key, required this.title, required this.isLoading, required});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: !isLoading ? const Color(0xffFF2E63) : const Color(0xff1DC7AC),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        SizedBox(
          child: isLoading ? const CircularProgressIndicator(color: Colors.white) : null,
        )
      ]),
    );
  }
}