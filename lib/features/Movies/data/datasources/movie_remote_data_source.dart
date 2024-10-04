import 'dart:convert';

import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/Movies/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getUpcoming();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> search(String Query);
}

final String apiKey = "&api_key=3c667c8ee7177c556967b2044266efa5";
final String url = "https://api.themoviedb.org/3";

final String pathNow = "/movie/now_playing?language=en-US&page=1";
final String apiUrlNowPlaying = "$url$pathNow$apiKey";

final String pathPop = "/movie/popular?language=en-US&page=1";
final String apiUrlPopular = "$url$pathPop$apiKey";

final String pathTop = "/movie/top_rated?language=en-US&page=1";
final String apiUrlTopRated = "$url$pathTop$apiKey";

final String pathUp = "/movie/upcoming?language=en-US&page=1";
final String apiUrlUpcoming = "$url$pathUp$apiKey";

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});
  @override
  Future<List<MovieModel>> getNowPlaying() async {
    return await getHome(apiUrlNowPlaying);
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    return await getHome(apiUrlPopular);
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    return await getHome(apiUrlTopRated);
  }

  @override
  Future<List<MovieModel>> getUpcoming() async {
    return await getHome(apiUrlUpcoming);
  }

  @override
  Future<List<MovieModel>> search(String Query) async {
    final response = await client.get(
      Uri.parse('$url/search/movie?query=$Query$apiKey'),
      headers: {
        "accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYzY2N2M4ZWU3MTc3YzU1Njk2N2IyMDQ0MjY2ZWZhNSIsIm5iZiI6MTcyNzczMTczNi41MzUzOTgsInN1YiI6IjY2ZWFmNDgyYjI5MTdlYjE4MDBiYjNmYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gRDXzLBGU6tW1_K677C1fl3SM-WnFJZ1zc-lCX2uRAo"
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> results = decodedJson['results'] as List<dynamic>;

      final List<MovieModel> movieModels = results
          .map<MovieModel>(
              (jsonMovieModel) => MovieModel.fromJson(jsonMovieModel))
          .toList();

      return movieModels;
    } else {
      throw ServerException();
    }
  }

  Future<List<MovieModel>> getHome(String API) async {
    final response = await client.get(
      Uri.parse(API),
      headers: {
        "accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYzY2N2M4ZWU3MTc3YzU1Njk2N2IyMDQ0MjY2ZWZhNSIsIm5iZiI6MTcyNzczMTczNi41MzUzOTgsInN1YiI6IjY2ZWFmNDgyYjI5MTdlYjE4MDBiYjNmYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gRDXzLBGU6tW1_K677C1fl3SM-WnFJZ1zc-lCX2uRAo"
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> results = decodedJson['results'] as List<dynamic>;

      final List<MovieModel> movieModels = results
          .map<MovieModel>(
              (jsonMovieModel) => MovieModel.fromJson(jsonMovieModel))
          .toList();

      return movieModels;
    } else {
      throw ServerException();
    }
  }
}
