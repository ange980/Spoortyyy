import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:untitled/comicvine_api.dart';
import 'app_events.dart';
import 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  AppBloc(this.comicVineRequests) : super(MoviesLoadingState());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchMovies) {
      yield MoviesLoadingState();
      try {
        final movies = await comicVineRequests.getMovies();
        yield MoviesLoadedState(movies.results);
      } catch (e) {
        yield AppErrorState('Erreur lors du chargement des films');
      }
    }
    if (event is FetchSeries) {
      yield SeriesLoadingState();
      try {
        final series = await comicVineRequests.getSeries();
        yield SeriesLoadedState(series.results);
      } catch (e) {
        yield AppErrorState('Erreur lors du chargement des séries');
      }
    }
    /*if (event is FetchComics) {
      yield ComicsLoadingS();
      try {
        final comics = await comicVineRequests.getVolumes();
        yield ComicsLoaded(comics.results.cast<ComicVineSeries>());
      } catch (e) {
        yield ComicsError('Erreur lors du chargement des comics');
      }
    }*/
  }

}
class SerieBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  SerieBloc(this.comicVineRequests) : super(SeriesLoadingState());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchSeries) {
      yield SeriesLoadingState();
      try {
        final series = await comicVineRequests.getSeries();
        yield SeriesLoadedState(series.results);
      } catch (e) {
        yield AppErrorState('Erreur lors du chargement des films');
      }
    }
  }
}
class ComicBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  ComicBloc(this.comicVineRequests) : super(ComicsLoadingState());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchComics) {
      yield ComicsLoadingState();
      try {
        final comics = await comicVineRequests.getVolumes();
        yield ComicsLoadedState(comics.results);
      } catch (e) {
        yield AppErrorState('Erreur lors du chargement des films');
      }
    }
  }
}
class SearchBloc extends Bloc< AppEvent, SearchState> {
  final ComicVineRequests search;

  SearchBloc(this.search) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(AppEvent event) async* {
    if (event is SearchRequested) {

      yield SearchLoadInProgress();
      try {
        final searchResults = await search.searchIssue(event.value);
        yield SearchLoadSuccess(
          searchIssueResults: searchResults.results,
        );
      } catch (_) {
        yield SearchLoadFailure();
      }
    }
  }
}