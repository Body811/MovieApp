import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/utils/authenticationUtils.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AuthenticationAppbar.getAppbar(
          context: context, backgroundColor: Colors.white),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/Film_elements_on_white_background_with_copy_space.png'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              WelcomeText.getText(text: "OTP Verification"),
              const Text(
                "Enter the verification code we just sent on your email address.",
                style: TextStyle(
                  color: Color(0xFF67686D),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              const OtpField(),
              const SizedBox(height: 25),
              AuthenticationScreenButton.getButton(
                  text: "Verify", onPress: () {}),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive the code?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E232C))),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(" Resend",
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
