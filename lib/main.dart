import 'package:flutter/material.dart';
import 'package:wallet_app/screens/splashScreen/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
      child: MaterialApp(
    color: const Color(0xff10194E),
    theme: ThemeData(
      primaryColor: const Color(0xff10194E),
      fontFamily: 'Roboto',
    ),
    home:
        Directionality(textDirection: TextDirection.ltr, child: SplashScreen()),
  )));
}
