import 'package:flutter/material.dart';
import 'package:wallet_app/shared/Models/step.dart' as SplashStep;
import 'package:wallet_app/screens/splashScreen/widgets/stepper_pill.dart';

class Stepper extends StatefulWidget {
  final SplashStep.Step step;
  const Stepper({super.key, required this.step});
  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return DefaultTextStyle(
        style: TextStyle(
            color: widget.step.index == 1
                ? const Color(0xffFAFAFA)
                : const Color(0xff1C265C)),
        child: Container(
          width: deviceWidth * 0.9,
          height: 224,
          padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(60)),
              color: widget.step.index == 1
                  ? const Color(0xff17288E)
                  : const Color(0xffFFFFFF)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              StepperPill(step: widget.step.index),
              const SizedBox(height: 16,),
              Text(widget.step.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: deviceWidth * 0.7,
                child: Text(
                widget.step.content,
                style: const TextStyle(fontSize: 16, height: 24 / 16),
              ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(widget.step.index == 1 ? const Color(0xffFFFFFF) : const Color(0xff1C265C)),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10),
                      ),
                    ),
                  ),
                  onPressed: () => widget.step.action(),
                  child: Text(
                    'Start banking',
                    style: TextStyle(
                        color: widget.step.index == 1
                            ? const Color(0xff17288E)
                            : const Color(0xffFFFFFF)),
                  ))
            ])
        ));
  }
}
