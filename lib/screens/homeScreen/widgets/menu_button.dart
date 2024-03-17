import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(48, 48),
        backgroundColor: const Color(0xff212A6B),
        shape: const CircleBorder()
      ),
      onPressed: () {

      }, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          color: Color(0xffFF2E63),
          width: 20,
          height: 2,
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          color: Color(0xffFF2E63),
          width: 15,
          height: 2,
        )
      ],));
  }
}