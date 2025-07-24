import 'package:flutter/material.dart';

class MyTextFeild extends StatelessWidget {
  final String text;
  final bool obscureText;
  final Icon icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyTextFeild({
    super.key,
    required this.text,
    required this.obscureText,
    required this.icon,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(hintText: text, prefixIcon: icon),
      validator: validator,
    );
  }
}
