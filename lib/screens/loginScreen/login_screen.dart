import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet_app/screens/registerScreen/register_screen.dart';
import 'package:wallet_app/shared/widgets/inputs.dart';
import 'package:wallet_app/shared/widgets/toast.dart';
import 'package:wallet_app/services/auth.dart';
import 'package:wallet_app/screens/homeScreen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? validationError;
  bool showToast = false;
  String? status;
  bool isLoading = false;
  bool isErrored = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain at least one uppercase letter';
      }
      if (!value.contains(RegExp(r'[a-z]'))) {
        return 'Password must contain at least one lowercase letter';
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return 'Password must contain at least one digit';
      }
      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Password must contain at least one special character';
      }
      return null;
    }

    String? validateText(String? value) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      return null;
    }

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Invalid email format';
      }
      return null;
    }

    void displayLoadingState() {
      setState(() {
        showToast = true;
        status = 'Login you in...';
        isLoading = true;
      });
    }

    void hideToast() {
      setState(() {
        showToast = false;
        status = '';
        isLoading = false;
        isErrored = true;
      });
    }

    void showErrorState() {
      setState(() {
        showToast = true;
        status = 'Sorry there was a problem connecting ): ';
        isLoading = false;
        isErrored = true;
      });
    }

    void login() {
      displayLoadingState();
      Login(emailController.text, passwordController.text).then((value) {
        if (value != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }).catchError((err) {
        print(err);
        hideToast();
        showErrorState();
        Timer.periodic(const Duration(seconds: 3), (Timer t) {
          hideToast();
        });
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff1C265C),
      body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(children: [
            Container(
              child: showToast
                  ? Toast(isLoading: isLoading, title: status ?? '')
                  : null,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              alignment: Alignment.topLeft,
              child: const Text(
                "Welcome back!",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              height: deviceHeight * 0.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputField(
                        controller: emailController,
                        label: "email address",
                        validator: validateEmail),
                    Column(
                      children: [
                        InputField(
                          controller: confirmPasswordController,
                          isPassword: true,
                          label: "password",
                          validator: validatePassword,
                        ),
                        Text(
                          validationError ?? "",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Dont have an account?',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))
                      ],
                    ),
                    Opacity(
                      opacity: isLoading ? 0.3 : 1,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(deviceWidth, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffFFFFFF)),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 20, right: 20)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: !isLoading
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                }
                              : null,
                          child: const Text('Login')),
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
