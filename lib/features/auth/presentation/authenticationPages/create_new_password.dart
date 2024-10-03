import 'package:flutter/material.dart';
import 'package:movie_app/utils/validation_utils.dart';

import '../widgets/authentication_appbar.dart';
import '../widgets/authentication_screen_button.dart';
import '../widgets/password_input_field.dart';
import '../widgets/welcome_text.dart';

class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35),
                const WelcomeText(text: "Create new password"),
                const SizedBox(height: 25),
                PasswordInputField(
                  text: "New Password",
                  controller: _passwordController,
                  validator: ValidationUtils.validatePassword,
                ),
                const SizedBox(height: 10),
                PasswordInputField(
                  text: "Confirm password",
                  controller: _confirmPasswordController,
                  validator: (value) => ValidationUtils.validateConfirmPassword(value, _passwordController.text),
                ),
                const SizedBox(height: 15),
                AuthenticationScreenButton(
                    text: "Reset Password",
                    onPress: () {}
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
