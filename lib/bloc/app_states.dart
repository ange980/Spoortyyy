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
