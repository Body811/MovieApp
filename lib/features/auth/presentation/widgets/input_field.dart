import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;

  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF67686D), fontSize: 15),
        filled: true,
        fillColor: const Color(0xFFE8ECF4),
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 5.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}
