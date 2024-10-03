import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final String? Function(String?) validator; // Function for validation

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.text,
    required this.validator, // Pass the validation function
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isObscureText = true;

  void _toggleObscureText() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.black,
      obscureText: _isObscureText,
      validator: widget.validator, // Attach validator here
      decoration: _buildInputDecoration(),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.text,
      hintStyle: const TextStyle(color: Color(0xFF67686D), fontSize: 15),
      filled: true,
      fillColor: const Color(0xD0E8ECF4),
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: Icon(_isObscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: _toggleObscureText,
      ),
      contentPadding:
      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      enabledBorder: _buildBorder(2.0),
      focusedBorder: _buildBorder(5.0),
    );
  }
  OutlineInputBorder _buildBorder(double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: const Color(0xFFE3E7EF), width: width),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
