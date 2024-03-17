import 'package:flutter/material.dart';

class StepperPill extends StatelessWidget {
  final int step;
  StepperPill({super.key, required this.step});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: step == 1 ? 32 : 16,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          // color: Colors.red
          color: step == 1 ? Color(0xffFFB129)
          : const Color(0xffFDD590)
        ),
      ),
      SizedBox(width: 4,),
      Container(
        height: 8,
        width: step == 2 ? 32 : 16,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          // color: Colors.blue
          color: step == 2 ? const Color(0xffFFB129) : const Color(0xffFDD590)
        ),
      ),
    ],);
  }
}