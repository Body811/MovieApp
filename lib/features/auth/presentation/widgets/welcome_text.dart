import 'package:flutter/material.dart';

class WelcomeText {
  static Widget getText({required String text}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),
      ),
    );
  }
}