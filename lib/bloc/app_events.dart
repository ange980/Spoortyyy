abstract class AppEvent {}

class FetchMovies extends AppEvent {}
class FetchSeries extends AppEvent {}
class FetchComics extends AppEvent {}

class SearchRequested extends AppEvent {
  final String value;

  SearchRequested(this.value);
}

class FetchSeriesDetail extends AppEvent {
  final String serieId;

  FetchSeriesDetail(this.serieId);
}


class FetchMoviesDetail extends AppEvent {
  final String movieId;

  FetchMoviesDetail(this.movieId);
}


class FetchIssueDetail extends AppEvent {
  final String issueId;

  FetchIssueDetail(this.issueId);
}


class FetchCharacter extends AppEvent {
  final String characterId;

  FetchCharacter(this.characterId);
}
