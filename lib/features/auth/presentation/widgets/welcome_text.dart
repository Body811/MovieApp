import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  final String text;

  // Constructor to accept the text parameter
  const WelcomeText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
