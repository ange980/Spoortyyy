import 'package:equatable/equatable.dart';
import 'package:untitled/comicvine_model.dart';


abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitialState extends AppState {}

class AppLoadingState extends AppState {}
class MoviesLoadingState extends AppState {}


class SeriesLoadingState extends AppState {}
class ComicsLoadingState extends AppState {}

class MoviesLoadedState extends AppState {
  final List<ComicVineMovie> movies;

  const MoviesLoadedState(this.movies);

  @override
  List<Object> get props => [movies];
}

class SeriesLoadedState extends AppState {
  final List<ComicVineSeries> series;

  const SeriesLoadedState(this.series);

  @override
  List<Object> get props => [series];
}
class ComicsLoadedState extends AppState {
  final List<ComicVineIssues> comics;

  const ComicsLoadedState(this.comics);

  @override
  List<Object> get props => [comics];
}

class AppErrorState extends AppState {
  final String errorMessage;

  const AppErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
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