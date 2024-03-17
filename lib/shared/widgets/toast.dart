import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  String title;
  bool isLoading;
  Toast({super.key, required this.title, required this.isLoading, required});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: !isLoading ? const Color(0xffFF2E63) : const Color(0xff1DC7AC),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        SizedBox(
          child: isLoading ? CircularProgressIndicator(color: Colors.white) : null,
        )
      ]),
    );
  }
}