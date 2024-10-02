import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/theme/app_fonts.dart';
import 'package:movie_app/features/details/domain/entities/movie_cast_entity.dart';

import '../../data/data_sources/remote/movie_cast/movie_cast_service.dart';
import '../../data/repository/movie_cast_repo_impl.dart';
import '../../domain/usecases/get_movie_cast_usecase.dart';

class CastTab extends StatefulWidget {
  final num movieId;

  const CastTab({super.key, required this.movieId});

  @override
  State<CastTab> createState() => _CastTabState();
}

class _CastTabState extends State<CastTab> {
  late Future<List<MovieCastEntity>> cast;

  @override
  void initState() {
    super.initState();

    var movieCastUseCase = GetMovieCastUseCase(
      MovieCastRepoImpl(
        MovieCastService(Dio()),
      ),
    );

    cast = movieCastUseCase.call(params: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    int crossAxisCount = 2;
    if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }

    return FutureBuilder<List<MovieCastEntity>>(
      future: cast,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: screenWidth * 0.05,
                mainAxisSpacing:  screenHeight * 0.01,
                childAspectRatio: 5 / 4,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final castMember = snapshot.data![index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.1,
                      backgroundImage: NetworkImage(castMember.profilePath),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      castMember.name,
                      textAlign: TextAlign.center,
                      style: AppFonts.body4
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
