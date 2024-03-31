import 'package:equatable/equatable.dart';
import 'package:untitled/bloc/app_events.dart';
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
  final String errorMessage2;

  SeriesError(this.errorMessage2);
}

class ComicsLoading extends AppState {}

class ComicsLoaded extends AppState {
  final List<ComicVineIssues> comics;

  ComicsLoaded(this.comics);
}

class ComicsError extends AppState {
  final String errorMessage3;

  ComicsError(this.errorMessage3);
}

class CharacterLoading extends AppState {}

class CharacterLoaded extends AppState {
  final ComicVineCharacter characters;

  CharacterLoaded(this.characters);
}

class CharacterError extends AppState {
  final String errorMessage4;

  CharacterError(this.errorMessage4);
}

class MovieDetailLoading extends AppState {}

class MovieDetailLoaded extends AppState {
  final ComicVineMovieDetail details;

  MovieDetailLoaded(this.details);
}

class MovieDetailError extends AppState {
  final String errorMessage5;

  MovieDetailError(this.errorMessage5);
}

class SerieDetailLoading extends AppState {}

class SerieDetailLoaded extends AppState {
  final ComicVineSerieDetail details;

   SerieDetailLoaded(this.details);
}

class SerieDetailError extends AppState {
  final String errorMessage6;

  SerieDetailError(this.errorMessage6);
}

class ComicDetailLoading extends AppState {}

class ComicDetailLoaded extends AppState {
  final ComicVineIssueDetail details;

  ComicDetailLoaded(this.details);
}

class ComicDetailError extends AppState {
  final String errorMessage7;

  ComicDetailError(this.errorMessage7);
}

class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoadSuccess extends SearchState {

  final List<ComicVineSearch> searchIssueResults;
  SearchLoadSuccess({
    required this.searchIssueResults,
  });

  @override
  List<Object?> get props => [searchIssueResults];
}

class SearchLoadFailure extends SearchState {}
