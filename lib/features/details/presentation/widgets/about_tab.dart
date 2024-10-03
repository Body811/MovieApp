import 'package:flutter/cupertino.dart';
import 'package:movie_app/config/theme/app_fonts.dart';

import '../../domain/entities/movie_details_entity.dart';



class AboutMovieTab extends StatelessWidget {
  final MovieDetailsEntity movieDetail;

  const AboutMovieTab({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              movieDetail.overview,
              style: AppFonts.body5,
          ),
        ],
      ),
    );
  }
}

