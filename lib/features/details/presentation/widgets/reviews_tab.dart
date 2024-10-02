import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/details/data/data_sources/remote/movie_reviews/movie_reviews_service.dart';
import 'package:movie_app/features/details/data/repository/movie_reviews_repo_impl.dart';
import 'package:movie_app/features/details/domain/entities/movie_reviews_entity.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_fonts.dart';
import '../../domain/usecases/get_movie_reviews_usecase.dart';

class ReviewsTab extends StatefulWidget {
  final num movieId;

  const ReviewsTab({super.key, required this.movieId});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  late Future<List<MovieReviewsEntity>> _reviews;

  @override
  void initState() {
    super.initState();

    var getMovieReviewsUseCase = GetMovieReviewsUseCase(
      MovieReviewsRepoImpl(
        MovieReviewsService(Dio()),
      ),
    );

    _reviews = getMovieReviewsUseCase.call(params: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<MovieReviewsEntity>>(
      future: _reviews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No reviews available'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final review = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            review.authorAvatarPath,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                            (review.rate != 0) ? review.rate.toString() : 'N/A',
                            style: AppFonts.body4.copyWith(
                                color: AppColors.ceruleanBlue
                            )
                        ),
                      ],
                    ),
                    SizedBox(width: screenHeight * 0.01),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review.author,
                                style: AppFonts.body4
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            review.content,
                            style: AppFonts.body5
                          ),
                          SizedBox(height: screenWidth * 0.05)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
