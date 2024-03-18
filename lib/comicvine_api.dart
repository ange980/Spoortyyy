/// comicvine_api.dart

import 'package:dio/dio.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:retrofit/retrofit.dart';

part 'comicvine_api.g.dart';

@RestApi()
abstract class ComicVineAPI {
  factory ComicVineAPI(Dio dio, {String baseUrl}) = _ComicVineAPI;

  @GET('movies')
  Future<ComicVineMoviesResponse> loadMovies(
      {@Query('limit') int limit = 20});

  @GET('/movie/4000-1')
  Future<ComicVineMoviesDetailResponse> getMovieDetail(
      @Path("id") int movieId);

  @GET('series_list')
  Future<ComicVineSeriesResponse> loadSeries(
      {@Query('limit') int limit = 20});

  @GET('issues')
  Future<ComicVineIssuesResponse> loadVolumes(
      {@Query('limit') int limit = 20});
}


class ComicVineRequests {

  /// Singleton
  static final ComicVineRequests _singleton = ComicVineRequests._internal();

  factory ComicVineRequests() {
    return _singleton;
  }

  ComicVineRequests._internal();

  final ComicVineAPI _api = ComicVineAPI(
    Dio(
      BaseOptions(queryParameters: {
        'api_key': 'cd0f322e37a01eacb8ec8fe4089d14f5107f4c41',
        'format': 'json',
      }),
    ),
    baseUrl: 'https://comicvine.gamespot.com/api/',
  );

  Future<ComicVineSeriesResponse> getSeries() {
    try {
      return _api.loadSeries(limit: 20);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ComicVineMoviesResponse> getMovies() {
    try {
      return _api.loadMovies(limit: 20);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ComicVineIssuesResponse> getVolumes() {
    try {
      return _api.loadVolumes(limit: 20);
    } catch (e) {
      print(e);
      rethrow;
    }
  }




}

