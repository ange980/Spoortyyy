import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:untitled/comicvine_api.dart';
import 'app_events.dart';
import 'app_states.dart';

class SerieBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  SerieBloc(this.comicVineRequests) : super(SeriesLoading());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchSeries) {
      yield SeriesLoading();
      try {
        final series = await comicVineRequests.getSeries();
        yield SeriesLoaded(series.results);
      } catch (e) {
        yield SeriesError('Erreur lors du chargement des films');
      }
    }
  }
}
class ComicBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  ComicBloc(this.comicVineRequests) : super(ComicsLoading());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchComics) {
      yield ComicsLoading();
      try {
        final comics = await comicVineRequests.getVolumes();
        yield ComicsLoaded(comics.results);
      } catch (e) {
        yield ComicsError('Erreur lors du chargement des films');
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

class AppBloc extends Bloc<AppEvent, AppState> {
  final ComicVineRequests comicVineRequests;

  AppBloc(this.comicVineRequests) : super(MoviesLoading());

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
    if (event is FetchSeries) {
      yield SeriesLoading();
      try {
        final series = await comicVineRequests.getSeries();
        yield SeriesLoaded(series.results);
      } catch (e) {
        yield SeriesError('Erreur lors du chargement des séries');
      }
    }
    if (event is FetchComics) {
      yield ComicsLoading();
      try {
        final comics = await comicVineRequests.getVolumes();
        yield ComicsLoaded(comics.results);
      } catch (e) {
        yield ComicsError('Erreur lors du chargement des comics');
      }
    }
    if (event is FetchCharacter) {
      yield CharacterLoading();
      try {
        final characters = await comicVineRequests.loadCharacter(event.characterId);
        yield CharacterLoaded(characters.results);
      } catch (e) {
        yield ComicsError('Erreur lors du chargement du character');
      }
    }
    if (event is FetchSeriesDetail) {
      yield SerieDetailLoading();
      try {
        final detail = await comicVineRequests.getSeriesDetail(event.serieId);
        yield SerieDetailLoaded(detail.results);
      } catch (e) {
        yield SerieDetailError('Erreur lors du chargement du detail de la serie');
      }
    }
    if (event is FetchMoviesDetail) {
      yield MovieDetailLoading();
      try {
        final detail = await comicVineRequests.getMoviesDetail(event.movieId);
        yield MovieDetailLoaded(detail.results);
      } catch (e) {
        yield MovieDetailError('Erreur lors du chargement du detail du film');
        print(e);
      }
    }
    if (event is FetchIssueDetail) {
      yield ComicDetailLoading();
      try {
        final detail = await comicVineRequests.getIssueDetail(event.issueId);
        yield ComicDetailLoaded(detail.results);
      } catch (e) {
        yield ComicDetailError('Erreur lors du chargement du detail du comic');
      }
    }

  }

}
