





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/auth_repository.dart';

class SendPasswordResetEmailRepositoryImpl implements AuthRepository<void, String> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

 SendPasswordResetEmailRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<void> invoke({required String params}) async {
    try{
      await firebaseAuth.sendPasswordResetEmail(email: params);
    }on FirebaseAuthException catch(e){
      throw (e);
    }
  }


}