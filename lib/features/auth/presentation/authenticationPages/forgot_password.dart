import 'package:flutter/material.dart';
import '../widgets/authentication_appbar.dart';
import '../widgets/authentication_screen_button.dart';
import '../widgets/input_field.dart';
import '../widgets/welcome_text.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AuthenticationAppbar(backgroundColor: Color(0xFFFFFFFF)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/Film elements on white background with copy space.png'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              const WelcomeText(text: "Forgot Password?"),
              const SizedBox(height: 10),
              const Text("Don't worry! It occurs. Please enter the email address linked with your account",
                style: TextStyle(
                  color: Color(0xFF67686D),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              InputField(
                hintText: "Enter Your Email",
                controller: _emailController,
                icon: Icons.email,
              ),
              const SizedBox(height: 30),
              AuthenticationScreenButton(
                  text: "Send Code", onPress: () {}),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remember Password?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E232C))),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(" login",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF35C2C1))))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
