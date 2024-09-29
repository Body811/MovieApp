import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/utils/authentication_utils.dart';



class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AuthenticationAppbar.getAppbar(context: context, backgroundColor: const Color(0xFFFFFFFF)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Film_elements_on_white_background_with_copy_space.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35),
                WelcomeText.getText(text: "Create new password"),
                const SizedBox(height: 25),
                PasswordInputField(text: "New Password", controller: _passwordController),
                const SizedBox(height: 10),
                PasswordInputField(text: "Confirm password", controller: _confirmPasswordController),
                const SizedBox(height: 15),
                AuthenticationScreenButton.getButton(text: "Reset Password", onPress: (){}),
                const SizedBox(height:5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
