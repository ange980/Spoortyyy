abstract class AppEvent {}

class FetchMovies extends AppEvent {}
class FetchSeries extends AppEvent{}
class FetchComics extends AppEvent{}
class SearchRequested extends AppEvent {
  final String value;

  SearchRequested(this.value);
}