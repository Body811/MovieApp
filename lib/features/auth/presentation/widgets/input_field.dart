import 'package:flutter/material.dart';


class InputField {
  static Widget getInputField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF67686D), fontSize: 15),
        filled: true,
        fillColor: const Color(0xFFE8ECF4),
        prefixIcon: Icon(icon),
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
