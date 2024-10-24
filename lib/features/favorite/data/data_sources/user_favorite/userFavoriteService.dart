import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/features/favorite/data/data_sources/interfaces/firebase_datasource.dart';
import 'package:movie_app/features/favorite/domain/entities/favoriteEntity.dart';


class UserFavoriteService implements FirebaseDatasource<FavoriteEntity> {
  final _firestore = FirebaseFirestore.instance;
  final String _COLLECTION = 'favorite';
  late final CollectionReference _ref;

  UserFavoriteService() {
    _ref = _firestore
        .collection(_COLLECTION)
        .withConverter<FavoriteEntity>(
        fromFirestore: (snapshot, _) => FavoriteEntity.fromJson(snapshot.data()!,),
        toFirestore: (favorite, _) => favorite.toJson());
  }

  @override
  Future<List<FavoriteEntity>> fetch({required String email, Map<String, dynamic>? params}) async {
    final querySnapshot = await _ref
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as FavoriteEntity)
        .toList();
  }

  @override
  Future<void> remove({required String email, required String title, Map<String, dynamic>? params}) async {
    final querySnapshot = await _ref
        .where('email', isEqualTo: email)
        .where('title', isEqualTo: title)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> save(FavoriteEntity favoriteItem) async {
    await _ref.add(favoriteItem);
  }
}