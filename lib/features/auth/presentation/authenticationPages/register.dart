import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/data/repository/register_repository_impl.dart';
import 'package:movie_app/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:movie_app/utils/success_snack_bar.dart';
import '../../../../utils/validation_utils.dart';
import '../../domain/Params/register_user_params.dart';
import '../widgets/authentication_appbar.dart';
import '../widgets/authentication_screen_button.dart';
import '../../../../utils/error_snack_bar.dart';
import '../widgets/input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/welcome_text.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {

      final String username = _userNameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;

      final registerUserUsecase = RegisterUserUsecase(
        repository: RegisterRepositoryImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
        ),
      );
      try{
       await registerUserUsecase.call(
            params: RegisterUserParams(
                email: email,
                password: password,
                username: username
            )
        );
        Navigator.pushReplacementNamed(context, "/login");
        SuccessSnackBar.show(context, "Registered successfully. Please login.");
      }on FirebaseAuthException catch(e){
        ErrorSnackBar.show(context, 'Error ${e.message}.');
      }catch(e){
        ErrorSnackBar.show(context, 'An unexpected error occurred.');
      }

    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/backgrounds/Curled film stripes isolated white background.png',
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Scaffold(
          appBar: const AuthenticationAppbar(backgroundColor: Color(0xFFFBFBFB)),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 35),
                      const WelcomeText(text: "Hello! Register to get \nStarted"),
                      const SizedBox(height: 25),
                      InputField(
                        hintText: "Enter Your Username",
                        controller: _userNameController,
                        icon: Icons.account_circle,
                        validator: ValidationUtils.validateUsername,
                      ),
                      const SizedBox(height: 10),
                      InputField(
                        hintText: "Enter Your Email",
                        controller: _emailController,
                        icon: Icons.email,
                        validator: ValidationUtils.validateEmail,
                      ),
                      const SizedBox(height: 10),
                      PasswordInputField(
                        text: "Enter your Password",
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
                        text: "Register",
                        onPress: (){
                          FocusScope.of(context).unfocus();
                          _register();
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E232C))),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(" login Now",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF35C2C1))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
