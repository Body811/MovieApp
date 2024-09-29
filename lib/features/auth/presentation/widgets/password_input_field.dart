import 'package:flutter/material.dart';


class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const PasswordInputField(
      {super.key, required this.controller, required this.text});

  @override
  State<PasswordInputField> createState() => PasswordInputFieldState();
}

class PasswordInputFieldState extends State<PasswordInputField> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: Colors.black,
      obscureText: _isObscureText,
      decoration: InputDecoration(
        hintText: widget.text,
        hintStyle: const TextStyle(color: Color(0xFF67686D), fontSize: 15),
        filled: true,
        fillColor: const Color(0xD0E8ECF4),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_isObscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscureText = !_isObscureText;
            });
          },
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 2.0),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 5.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
