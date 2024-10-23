import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/favorite/data/data_sources/user_favorite/userFavoriteService.dart';
import 'package:movie_app/features/favorite/data/repository/favorite_repository.dart';
import 'package:movie_app/features/favorite/domain/usecases/getFavoriteItemUseCase.dart';
import '../../../config/config.dart';
import '../../../core/widget/navbar.dart';
import '../domain/entities/favoriteEntity.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Future<List<FavoriteEntity>> favoriteMovies;

  @override
  void initState() {
    super.initState();
   favoriteMovies =  _loadFavoriteMovies();
  }

  Future<List<FavoriteEntity>> _loadFavoriteMovies() async {
    final getFavoriteUseCase = GetFavoriteItemUseCase(
      FavoriteRepository(UserFavoriteService()),
    );

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      String username = userData['username'];
      return getFavoriteUseCase.call(params: {'username': username});
    } else {
      return Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite List'),
      ),
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Config.favoriteBackgroundImage),
                fit: BoxFit.fill,
              ),
            ),
          ),

          FutureBuilder<List<FavoriteEntity>>(
            future: favoriteMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No favorite movies found.'));
              } else {
                final movies = snapshot.data!;
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(movie.title),
                        subtitle: Text(movie.category),
                        leading: movie.backDropPath != null
                            ? Image.network(movie.backDropPath)
                            : const Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      )
    );
  }
}
