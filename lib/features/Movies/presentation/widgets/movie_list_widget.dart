import 'package:flutter/material.dart';
import '../../domain/entities/Movie.dart';

class MoviesListWidget extends StatelessWidget {
  final List<Movie> Movies;
  final String imgPath = "https://image.tmdb.org/t/p/w500/";

  const MoviesListWidget({super.key, required this.Movies});

  @override
  Widget build(BuildContext context) {
    // Filter out adult movies before building the grid
    final nonAdultMovies =
        Movies.where((movie) => movie.adult != true).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: nonAdultMovies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // For 3 columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.7, // Aspect ratio for movie poster display
      ),
      itemBuilder: (context, index) {
        final movie =
            nonAdultMovies[index]; // Reference to each non-adult movie
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/details/${movie.id}');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2.1 / 3, // Adjust as per movie poster size ratio
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    imgPath + movie.poster_path, // Use full image path
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                          Icons.movie); // Handle image load errors
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
