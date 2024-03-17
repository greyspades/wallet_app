import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/stepper.dart' as SplashStepper;
import 'package:wallet_app/shared/Models/step.dart' as SplashStep;
import 'package:wallet_app/screens/registerScreen/register_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double xOffset = 0.0;
  int stepIndex = 0;

  void _nextSplash() {
    _controller.forward();
  }

  void _navigateToSignin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  late List<SplashStep.Step> steps = [
    SplashStep.Step(
        index: 1,
        title: "Transfer That Is Safe",
        backgroundImage: 'assets/images/splash_one.jpg',
        content: 'You have nothing to be scared about, we got you covered.',
        action: _nextSplash),
    SplashStep.Step(
        index: 2,
        title: "Transfer Money With Ease",
        backgroundImage: 'assets/images/splash_two.jpg',
        content:
            'Making money is hard enough, we make transfering it easy enough.',
        action: _navigateToSignin)
  ];

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1, 0.0),
    ).animate(_controller);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        setState(() {
          stepIndex++;
        });
        _animation = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(1, 0),
        ).animate(_controller);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff10194E),
        body: Stack(
          children: [
            SlideTransition(
              position: _animation,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(steps[stepIndex].backgroundImage),
                        fit: BoxFit.cover)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Stack(
                  children: [SplashStepper.Stepper(step: steps[stepIndex])]),
            ),
          ],
        ));
  }
}
