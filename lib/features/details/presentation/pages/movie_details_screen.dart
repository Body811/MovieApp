import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/strings/app_strings.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/config/theme/app_fonts.dart';
import 'package:movie_app/features/details/data/data_sources/remote/movie_details/movie_details_service.dart';
import 'package:movie_app/features/details/data/repository/movie_details_repository_impl.dart';
import 'package:movie_app/features/details/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/features/details/domain/entities/movie_details_entity.dart';

import '../widgets/about_tab.dart';
import '../widgets/cast_tab.dart';
import '../widgets/reviews_tab.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
with SingleTickerProviderStateMixin {
  late Future<MovieDetailsEntity> movieDetails;
  late TabController _tabController;
  String backDropBaseImageUrl = 'https://image.tmdb.org/t/p/w500';
  String posterBaseImageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    final movieDetailsUseCase = GetMovieDetailsUseCase(
      MovieDetailsRepositoryImpl(
        MovieDetailsService(Dio()),
      ),
    );

    movieDetails = movieDetailsUseCase.call(params: widget.movieId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(AppStrings.detailsTitle),
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          fontSize: screenWidth * 0.05,
          fontFamily: AppFonts.montserrat,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: FutureBuilder<MovieDetailsEntity>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movieDetail = snapshot.data!;
            return Stack(
              children: [
                Align(
                  alignment: const Alignment(0.5, -0.6),
                  child: Container(
                    height: screenHeight * 0.55,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(backDropBaseImageUrl + movieDetail.backDropPath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight ,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                posterBaseImageUrl + movieDetail.posterPath,
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movieDetail.title,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontFamily: AppFonts.poppins,
                                      fontSize: screenWidth * 0.045, // Responsive font size
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    '${movieDetail.releaseDate.split('-')[0]} | ${movieDetail.runtime} min',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    movieDetail.category,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow, size: screenWidth * 0.05), // Responsive icon size
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        '9.5',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.red,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              tabs: const [
                                Tab(text: 'About Movie'),
                                Tab(text: 'Reviews'),
                                Tab(text: 'Cast'),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.5,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  AboutMovieTab(movieDetail: movieDetail),
                                  ReviewsTab(movieId: widget.movieId),
                                  CastTab(movieId: widget.movieId),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('No data found.'));
        },
      ),
    );
  }
}
