import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/state/icon_state/model/icon_state.dart';
import 'package:movie_app/core/state/icon_state/network/icon_state_service.dart';
import 'package:movie_app/features/favorite/data/data_sources/user_favorite/userFavoriteService.dart';
import 'package:movie_app/features/favorite/data/repository/favorite_repository.dart';
import 'package:movie_app/features/favorite/domain/entities/favoriteEntity.dart';
import 'package:movie_app/features/favorite/domain/usecases/deleteFavoriteItemUseCase.dart';
import 'package:movie_app/features/favorite/domain/usecases/saveFavoriteItemUseCase.dart';

import '/config/config.dart';
import '/config/strings/app_strings.dart';
import '/config/theme/app_colors.dart';
import '/config/theme/app_fonts.dart';
import '/features/details/data/data_sources/remote/movie_details/movie_details_service.dart';
import '/features/details/data/repository/movie_details_repository_impl.dart';
import '/features/details/domain/usecases/get_movie_details_usecase.dart';
import '/features/details/domain/entities/movie_details_entity.dart';
import '../widgets/about_tab.dart';
import '../widgets/cast_tab.dart';
import '../widgets/reviews_tab.dart';

class MovieDetailsScreen extends StatefulWidget {
  final num movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {

  late Future<MovieDetailsEntity> movieDetails;
  late TabController _tabController;

  static const _FAVORITE_ICON_ID = 'favoriteIcon';
  late bool _toggle = false;

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

    _fetchFavoriteIconState();
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
        titleTextStyle: AppFonts.header1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                _toggle = !_toggle;
              });

              final iconState = new IconState(iconId: _FAVORITE_ICON_ID, isActive: _toggle);
              await _saveIconState(iconState);

              if (_toggle) {
                _saveFavorite();
              } else {
                _removeFavorite();
              }
            },
            icon: _toggle ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
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
                        image: NetworkImage(movieDetail.backDropPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: screenHeight * 0.25,
                    left: screenWidth * 0.77,
                    child: Row(
                      children: [
                        const Icon(Icons.star_border, color: AppColors.orange),
                        SizedBox(width: screenWidth * 0.02),
                        Text(movieDetail.voteAverage.toString(), style: AppFonts.header3),
                      ],
                    )
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  left: screenWidth * 0.05,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movieDetail.posterPath,
                          width: screenWidth * 0.27,
                          height: screenHeight * 0.17,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ]
                  ),
                ),
                Align(
                  alignment: const Alignment(0.5, -0.27),
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: Text(
                        movieDetail.title,
                        style: AppFonts.body1,
                      ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, -0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(Config.calender, color: AppColors.poloBlue,),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            movieDetail.releaseDate,
                            style: AppFonts.header2
                          ),
                        ],
                      ),

                      SizedBox(width: screenWidth * 0.02),
                      const Text('|'),
                      SizedBox(width: screenWidth * 0.02),

                      Row(
                        children: [
                         Image.asset(Config.clock, color: AppColors.poloBlue),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            movieDetail.runtime.toString(),
                            style: AppFonts.header2
                          ),
                        ],
                      ),

                      SizedBox(width: screenWidth * 0.02),
                      const Text('|'),
                      SizedBox(width: screenWidth * 0.02),

                      Row(
                        children: [
                          Image.asset(Config.ticketIcon, color: AppColors.poloBlue),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                             '  '+ _getCategories(movieDetail.category),
                            style: AppFonts.header2,
                          ),
                        ],
                      ),
                    ],
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
                              indicatorColor: AppColors.black,
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

  // Function to get the first two categories before the comma
  String _getCategories(String category) {
    // Split the category by comma
    final categories = category.split(',');

    // Join the first two categories with a comma and return
    return categories.take(2).join(',\n '); // Return first two categories joined by comma
  }

  void _saveFavorite() async {
    var details = await movieDetails;
    final User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore
        .instance.collection('users')
        .doc(user?.uid)
        .get();

    String email = userData['email'];

    var favoriteEntity= FavoriteEntity(
        details.releaseDate,
        details.category,
        details.runtime,
        details.voteAverage,
        details.title,
        details.posterPath,
        email
    );

    final saveFavoriteUseCase = SaveFavoriteItemUseCase(
        FavoriteRepository(
            UserFavoriteService()
        )
    );

    await saveFavoriteUseCase.call(params: {'data' : favoriteEntity});
  }

  void _removeFavorite() async {
    var details = await movieDetails;
    final User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore
        .instance.collection('users')
        .doc(user?.uid)
        .get();

    String email = userData['email'];
    print("her $email");

    final removeFavoriteUseCase = DeleteFavoriteItemUseCase(
        FavoriteRepository(
            UserFavoriteService()
        )
    );

    removeFavoriteUseCase.call(params: {'email': email, 'title': details.title});
  }

  Future<void> _saveIconState(IconState iconState) async {
    var service = IconStateService();
    await service.saveIconState(iconState, widget.movieId);
  }

  Future<IconState?> _getIconState(String iconId) async {
    var service = IconStateService();
    return service.getIconState(iconId, widget.movieId);
  }

  void _fetchFavoriteIconState() async {
    final saveIconState = await _getIconState(_FAVORITE_ICON_ID);
    setState(() {
      _toggle = saveIconState?.isActive ?? false;
      print(_toggle);
    });
  }
}