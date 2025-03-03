import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const PasswordInputField({required this.label, required this.controller, Key? key}) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
      ),
    );
  }
}
