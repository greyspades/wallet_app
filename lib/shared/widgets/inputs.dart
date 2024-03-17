import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final bool isPassword;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const InputField({super.key, this.isPassword = false, required this.label, required this.controller, this.validator});
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _isObscured = widget.isPassword;

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white),
        suffixIcon: widget.isPassword ? IconButton(
          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility, color: Colors.white,),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 3
          )
        ),
        // filled: true,
        // fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
      ),
      validator: widget.validator,
    );
  }
}
