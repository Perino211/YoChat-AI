import 'package:flutter/material.dart';

class Textformfield extends StatelessWidget {
  const Textformfield(
      {super.key,
      required this.inputController,
      required this.myhinttext,
      required this.obscureText,
      required this.inputValidator});

  final dynamic inputController;
  final String myhinttext;
  final bool obscureText;
  // ignore: prefer_typing_uninitialized_variables
  final String? Function(String?)? inputValidator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        validator: inputValidator,
        controller: inputController,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: myhinttext),
      ),
    );
  }
}
