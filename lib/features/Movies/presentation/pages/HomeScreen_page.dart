import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/config/theme/app_fonts.dart';
import 'package:movie_app/features/Movies/presentation/cubit/movies_cubit.dart';

import '../../../../core/widget/loading_widget.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/movie_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Now playing'; // Default category

  @override
  void initState() {
    super.initState();
    // Fetch initial category movies
    context.read<MoviesCubit>().GetNewPlayingMovies();
  }

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'Now playing') {
        context.read<MoviesCubit>().GetNewPlayingMovies();
      } else if (category == 'Upcoming') {
        context.read<MoviesCubit>().GetUpcomingMovies();
      } else if (category == 'Top rated') {
        context.read<MoviesCubit>().GetTopRatedMovies();
      } else if (category == 'Popular') {
        context.read<MoviesCubit>().GetPopularMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/backgrounds/Cinema_concept_with_clapperboard_and_popcorn.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Movies',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Poppins', // Font family reference
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryTab(context, 'Now playing'),
                  _buildCategoryTab(context, 'Upcoming'),
                  _buildCategoryTab(context, 'Top rated'),
                  _buildCategoryTab(context, 'Popular'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildMovieContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        _onCategoryTap(title);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.bold,
              color: _selectedCategory == title
                  ? AppColors.poloBlue
                  : Colors.black,
            ),
          ),
          if (_selectedCategory == title)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 50,
              color: AppColors.poloBlue,
            ),
        ],
      ),
    );
  }

  Widget _buildMovieContent() {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is LoadingMoviesState) {
          return const LoadingWidget();
        } else if (state is LoadedNewPlayingMoviesState &&
            _selectedCategory == 'Now playing') {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context, 'Now playing'),
            child: MoviesListWidget(Movies: state.newPlayingMovies),
          );
        } else if (state is LoadedUpcomingMoviesState &&
            _selectedCategory == 'Upcoming') {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context, 'Upcoming'),
            child: MoviesListWidget(Movies: state.upcomingMovies),
          );
        } else if (state is LoadedTopRatedMoviesState &&
            _selectedCategory == 'Top rated') {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context, 'Top rated'),
            child: MoviesListWidget(Movies: state.topRatedMovies),
          );
        } else if (state is LoadedPopularMoviesState &&
            _selectedCategory == 'Popular') {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context, 'Popular'),
            child: MoviesListWidget(Movies: state.popularMovies),
          );
        } else if (state is ErrorMoviesState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Future<void> _onRefresh(BuildContext context, String category) async {
    final moviesCubit = context.read<MoviesCubit>();
    if (category == 'Now playing') {
      moviesCubit.RefreshNewPlayingMovies();
    } else if (category == 'Upcoming') {
      moviesCubit.RefreshUpcomingMovies();
    } else if (category == 'Top rated') {
      moviesCubit.RefreshTopRatedMovies();
    } else if (category == 'Popular') {
      moviesCubit.RefreshPopularMovies();
    }
  }
}
