import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final String variant;
  final Function? action;
  const Button({super.key, required this.backgroundColor, this.variant = 'normal', this.textColor = Colors.white, this.borderColor, this.action, required this.label});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(variant == 'full' ? deviceWidth : 164, 50)),
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(BorderSide(
            color: borderColor ?? Colors.transparent,
          ))
        ),
        onPressed: action != null ? action!() : null,
        child: Text(label, style: TextStyle(color: textColor),));
  }
}
