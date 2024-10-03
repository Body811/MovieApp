

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/auth/domain/Params/login_user_params.dart';
import 'package:movie_app/features/auth/domain/repository/auth_repository.dart';

import '../models/user_model.dart';

class LoginRepositoryImpl implements AuthRepository<UserModel, LoginUserParams>{

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  LoginRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> invoke({required LoginUserParams params}) async {
    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password
    );

    User? user = userCredential.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'USER_LOGIN_FAILED',
        message: 'Failed to login user.',
      );
    }

    DocumentSnapshot doc = await firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      throw FirebaseAuthException(
        code: 'USER_NOT_FOUND',
        message: 'User data not found in Firestore.',
      );
    }
    return UserModel.fromMap(doc.data() as Map<String,dynamic>);
  }
}