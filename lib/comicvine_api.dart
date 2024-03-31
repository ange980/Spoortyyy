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


  @GET('series_list')
  Future<ComicVineSeriesResponse> loadSeries(
      {@Query('limit') int limit = 20});

  @GET('episodes')
  Future<ComicVineEpisodeResponse> loadEpisode(
      {@Query('limit') int limit = 20});

  @GET('series/4075-{id}')
  Future<ComicVineSerieDetailResponse> getSeriesDetail(@Path('id') String serieId );

  @GET('movie/4025-{id}')
  Future<ComicVineMoviesDetailResponse> getMoviesDetail(@Path('id') String moviesId );

  @GET('issue/4000-{id}')
  Future<ComicVineIssueDetailResponse> getIssueDetail(@Path('id') String issueId );

  @GET('character/4005-{id}')
  Future<ComicVineCharacterResponse> loadCharacter(@Path('id') String characterId );

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

  Future<ComicVineSerieDetailResponse> getSeriesDetail(String serieId) {
    try {
      return _api.getSeriesDetail(serieId);
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

  Future<ComicVineMoviesDetailResponse> getMoviesDetail(String moviesId) {
    try {
      return _api.getMoviesDetail(moviesId);
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

  Future<ComicVineIssueDetailResponse> getIssueDetail(String issueId) {
    try {
      return _api.getIssueDetail(issueId);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ComicVineEpisodeResponse> getEpisode() {
    try {
      return _api.loadEpisode(limit: 20);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ComicVineCharacterResponse> loadCharacter(String characterId) {
    try {
      return _api.loadCharacter(characterId);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}

