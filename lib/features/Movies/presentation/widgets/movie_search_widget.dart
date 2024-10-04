import 'package:flutter/material.dart';
import 'package:movie_app/features/Movies/domain/entities/Movie.dart';

import 'movies_search_card.dart';

class MovieSearchWidget extends StatelessWidget {
  final List<Movie> Movies;

  const MovieSearchWidget({super.key, required this.Movies});

  final String imgPath = "https://image.tmdb.org/t/p/w500/";

  @override
  Widget build(BuildContext context) {
    // Filter out adult movies
    final nonAdultMovies =
        Movies.where((movie) => movie.adult != true).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: nonAdultMovies.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the text vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center the text horizontally
                children: [
                  Image(
                    image: AssetImage('assets/icons/Group.png'),
                    height: 76,
                    width: 76,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'We Are Sorry, We Can \n Not Find The Movies :(',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center, // Center align the text
                  ),
                  const SizedBox(
                      height: 8.0), // Add space between the two texts
                  Text(
                    'Find your movie by typing the title...',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center, // Center align the text
                  ),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two cards in a row
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7, // Aspect ratio for the movie card
              ),
              itemCount: nonAdultMovies.length,
              itemBuilder: (context, index) {
                final movie = nonAdultMovies[index];
                return MoviesSearchCard(
                  id: movie.id,
                  imageUrl: imgPath + movie.poster_path,
                  originalLanguage: movie.original_language,
                  originalTitle: movie.original_title,
                  overview: movie.overview,
                  title: movie.title,
                  voteAverage: movie.vote_average,
                );
              },
            ),
    );
  }
}
