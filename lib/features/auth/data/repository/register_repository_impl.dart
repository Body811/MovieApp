

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/auth/domain/repository/auth_repository.dart';
import '../../domain/Params/register_user_params.dart';
import '../models/user_model.dart';

class RegisterRepositoryImpl implements AuthRepository<UserModel, RegisterUserParams> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  RegisterRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> invoke({required RegisterUserParams params}) async {
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    User? user = userCredential.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'USER_CREATION_FAILED',
        message: 'Failed to Register.',
      );
    }

    UserModel userModel = UserModel(
      uid: user.uid,
      email: params.email,
      username: params.username,
    );

    await firestore.collection('users').doc(user.uid).set(userModel.toMap());
    return userModel;
  }
}
