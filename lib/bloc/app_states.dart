import 'package:untitled/comicvine_model.dart';

abstract class AppState {}

class MoviesLoading extends AppState {}

class MoviesLoaded extends AppState {
  final List<ComicVineMovie> movies;

  MoviesLoaded(this.movies);
}

class MoviesError extends AppState {
  final String errorMessage;

  MoviesError(this.errorMessage);
}

class SeriesLoading extends AppState {}

class SeriesLoaded extends AppState {
  final List<ComicVineSeries> series;

  SeriesLoaded(this.series);
}

class SeriesError extends AppState {
  final String errorMessage;

  SeriesError(this.errorMessage);
}

class ComicsLoading extends AppState {}

class ComicsLoaded extends AppState {
  final List<ComicVineSeries> comics;

  ComicsLoaded(this.comics);
}

class ComicsError extends AppState {
  final String errorMessage;

  ComicsError(this.errorMessage);
}