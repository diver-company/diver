import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(),
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
      controller: widget.controller,
    );
  }
}
