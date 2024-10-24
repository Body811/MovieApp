import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../model/icon_state.dart';

class IconStateService {
  final String _COLLECTION_KEY = 'icon_state';
  final String _USER_ICONS_COLLECTION = 'user_icons';
  late final CollectionReference _iconStateCollection;
  final logger = Logger();

  IconStateService() {
     _iconStateCollection = FirebaseFirestore.instance.collection(_COLLECTION_KEY);
  }

  Future<void> saveIconState(IconState iconState, num movieId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _iconStateCollection.doc(user.uid).collection(movieId.toString()).doc(iconState.iconId).set(iconState.toJson());
      logger.i("Icon state saved");
    }
  }

  Future<IconState?> getIconState(String iconId, num movieId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot snapshot = await _iconStateCollection.doc(user.uid).collection(movieId.toString()).doc(iconId).get();
      if (snapshot.exists) {
        logger.i("Icon state returned");
        return IconState.fromJson(snapshot.data() as Map<String, dynamic>);
      }
    }
    return null;
  }
}