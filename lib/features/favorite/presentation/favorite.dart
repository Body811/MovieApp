import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/favorite/data/data_sources/user_favorite/userFavoriteService.dart';
import 'package:movie_app/features/favorite/data/repository/favorite_repository.dart';
import 'package:movie_app/features/favorite/domain/usecases/getFavoriteItemUseCase.dart';
import '../../../config/config.dart';
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
    favoriteMovies = _loadFavoriteMovies();
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
    final screenWidth = MediaQuery.of(context).size.width;

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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double imageWidth = constraints.maxWidth * 0.3;
                          final double imageHeight = imageWidth * 1.5;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  movie.backDropPath,
                                  width: imageWidth,
                                  height: imageHeight,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        movie.title,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: constraints.maxWidth * 0.68,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.orange, size: 16),
                                        const SizedBox(width: 4),
                                        Text(movie.voteAverage.toString(),
                                            style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text(movie.releaseDate.toString(),
                                            style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.category, size: 16),
                                        const SizedBox(width: 4),
                                        SizedBox(
                                          child: Text(movie.category,
                                              style:
                                              const TextStyle(fontSize: 16)),
                                          width: constraints.maxWidth * 0.5,
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.timer, size: 16),
                                        const SizedBox(width: 4),
                                        Text('${movie.runtime} minutes',
                                            style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
