import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';

class MoviesSearchCard extends StatelessWidget {
  final int id; // Added id for navigation
  final String imageUrl;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String title;
  final double voteAverage;

  const MoviesSearchCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.title,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details/$id');
      },
      child: Card(
        color: Colors.white54,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  height: 100.0,
                  width: 80.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 100.0,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.0),
              Text(
                originalTitle,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                "Language: $originalLanguage",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.star_border_outlined,
                    color: AppColors.orange,
                    size: 18.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    voteAverage.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
