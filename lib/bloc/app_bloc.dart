import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:untitled/comicvine_api.dart';
import 'app_events.dart';
import 'app_states.dart';

class MovieBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  MovieBloc(this.comicVineRequests) : super(MoviesLoading());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchMovies) {
      yield MoviesLoading();
      try {
        final movies = await comicVineRequests.getMovies();
        yield MoviesLoaded(movies.results);
      } catch (e) {
        yield MoviesError('Erreur lors du chargement des films');
      }
    }
  }
}
class SerieBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  SerieBloc(this.comicVineRequests) : super(SeriesLoading());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchMovies) {
      yield SeriesLoading();
      try {
        final series = await comicVineRequests.getSeries();
        yield SeriesLoaded(series.results);
      } catch (e) {
        yield MoviesError('Erreur lors du chargement des films');
      }
    }
  }
}