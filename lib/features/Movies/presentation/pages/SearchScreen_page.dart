import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_fonts.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/navbar.dart';
import '../cubit/search_movies_cubit.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/movie_search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController
        .dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  void _onSearch(String query) {
    context
        .read<SearchMoviesCubit>()
        .Search(query); // Trigger search on text change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text("Search"),
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontFamily: AppFonts.montserrat,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white38,
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: AppColors.slateGray),
                  suffixIcon: const Icon(Icons.search,
                      size: 30.0, color: AppColors.slateGray),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildMovieSearch(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieSearch() {
    return BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
      builder: (context, state) {
        if (state is LoadingSearchMoviesState) {
          return const LoadingWidget();
        } else if (state is LoadedSearchMoviesState) {
          return MovieSearchWidget(Movies: state.searchMovies);
        } else if (state is ErrorSearchMoviesState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return const Center(child: Text("Search results will appear here"));
        }
      },
    );
  }
}
