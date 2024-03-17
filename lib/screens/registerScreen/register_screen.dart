import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet_app/shared/widgets/inputs.dart';
import 'package:wallet_app/shared/widgets/toast.dart';
import 'package:wallet_app/services/auth.dart';
import 'package:wallet_app/screens/homeScreen/home_screen.dart';
import 'package:wallet_app/screens/loginScreen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  String? validationError;
  bool showToast = false;
  String? status;
  bool isLoading = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  void displayLoadingState() {
    setState(() {
      showToast =  true;
      status = 'Registering you up...';
      isLoading = true; 
    });
  }

  void hideToast() {
    setState(() {
      showToast = false;
      status = '';
      isLoading = false;
    });
  }

  void showErrorState() {
    setState(() {
      showToast = true;
      status = 'Sorry there was a problem connecting ): ';
      isLoading = false;
    });
  }

  void registerUser() {
    displayLoadingState();
    Register(usernameController.text, emailController.text, passwordController.text)
    .then((value) {
      if(value != null) {
        hideToast();
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    })
    .catchError((err) {
      print(err);
      hideToast();
      showErrorState();
      Timer.periodic(const Duration(seconds: 3), (Timer t) {
      hideToast();
  });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff1C265C),
      body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(
              children: [
                Container(
                  child: showToast ? Toast(isLoading: isLoading, title: status ?? '') : null,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: const Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Almost there !",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(top: 4),
                //   alignment: Alignment.topLeft,
                //   child: const Text(
                //     "We are so excited to see you here!",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 14),
                //     textAlign: TextAlign.start,
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  height: deviceHeight * 0.7,
                  child: Form(
                  key: _formKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                  child: InputField(
                  controller: usernameController,
                  label: "username",
                  validator: validateText
                )),
                Container(
                    child: InputField(
                  controller: emailController,
                  label: "email address",
                  validator: validateEmail
                )),
                Container(
                    child: InputField(
                  controller: passwordController,
                  isPassword: true,
                  label: "password",
                  validator: validatePassword,
                )),
                Container(
                    child: Column(children: [
                      InputField(
                  controller: confirmPasswordController,
                  isPassword: true,
                  label: "confirm password",
                  validator: validatePassword,
                ),
                Text(validationError ?? "", style: const TextStyle(color: Colors.red, fontSize: 12),)
                    ],)
                  ),
                Container(
                  child: Column(children: [
                    Text('By signing up i confirm that i have read and accepted the terms of use', style: TextStyle(fontSize: 12, color: Colors.white),),
                    Row(children: [
                      const Text('Already have an account?', style: TextStyle(fontSize: 12, color: Colors.white)),
                      TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      }, child: const Text('Sign in', style: TextStyle(fontWeight: FontWeight.w600),))
                    ],)
                  ]),
                ),
                Opacity(opacity: isLoading ? 0.3 : 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(deviceWidth, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffFFFFFF)),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20),
                      ),
                    ),
                  ),
                  onPressed: !isLoading ? () {
                    // registerUser();
                    if(_formKey.currentState!.validate()) {
                      if(passwordController.text == confirmPasswordController.text) {
                       
                        registerUser();
                      } else {
                        setState(() {
                          validationError = 'the passwords do not match';
                        });
                      }
                      print("its valid");
                    }
                } : null, child: Text('Sign Up')),
                )
                ],),),
                )
              ])),
    );
  }
}
