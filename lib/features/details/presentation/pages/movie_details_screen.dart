import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/config.dart';
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
      extendBodyBehindAppBar: false,
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
                Container(
                  height: screenHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Config.detailsBackGroundImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      image: DecorationImage(
                        image: NetworkImage(backDropBaseImageUrl + movieDetail.backDropPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: screenHeight * 0.2,
                  left: screenWidth * 0.05,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      posterBaseImageUrl + movieDetail.posterPath,
                      width: screenWidth * 0.27,
                      height: screenHeight * 0.17,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.43,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              controller: _tabController,
                              indicatorColor: AppColors.grayishBlue,
                              labelColor: AppColors.black,
                              unselectedLabelColor: AppColors.poloBlue,
                              tabs: const [
                                Tab(text: 'About Movie'),
                                Tab(text: 'Reviews'),
                                Tab(text: 'Cast'),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.4,
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