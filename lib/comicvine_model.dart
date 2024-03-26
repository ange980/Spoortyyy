/// comicvine_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'comicvine_model.g.dart';

@JsonSerializable()
class ComicVineMoviesResponse {
  @JsonKey(name: 'results')
  final List<ComicVineMovie> results;

  ComicVineMoviesResponse(this.results);

  factory ComicVineMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$ComicVineMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineMoviesResponseToJson(this);
}

@JsonSerializable()
class ComicVineSeriesResponse {
  @JsonKey(name: 'results')
  final List<ComicVineSeries> results;

  ComicVineSeriesResponse(this.results);

  factory ComicVineSeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$ComicVineSeriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineSeriesResponseToJson(this);
}


@JsonSerializable()
class ComicVineMoviesDetailResponse{
  @JsonKey(name: 'results')
  final ComicVineMovieDetail results;

  ComicVineMoviesDetailResponse(this.results);

  factory ComicVineMoviesDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ComicVineMoviesDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ComicVineMoviesDetailResponseToJson(this);
}



@JsonSerializable()
class ComicVineIssuesResponse{
  @JsonKey(name: 'results')
  final List<ComicVineIssues> results;

  ComicVineIssuesResponse(this.results);

  factory ComicVineIssuesResponse.fromJson(Map<String, dynamic> json) {
    return _$ComicVineIssuesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ComicVineIssuesResponseToJson(this);
}

@JsonSerializable()
class ComicVineSerieDetailResponse {
  @JsonKey(name: 'results')
  final ComicVineSerieDetail results;

  ComicVineSerieDetailResponse(this.results);

  factory ComicVineSerieDetailResponse.fromJson(Map<String, dynamic> json) => _$ComicVineSerieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineSerieDetailResponseToJson(this);
}

@JsonSerializable()
class ComicVineIssueDetailResponse {
  @JsonKey(name: 'results')
  final ComicVineIssueDetail results;

  ComicVineIssueDetailResponse(this.results);

  factory ComicVineIssueDetailResponse.fromJson(Map<String, dynamic> json) => _$ComicVineIssueDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineIssueDetailResponseToJson(this);
}




//Informations Page Film
@JsonSerializable()
class ComicVineMovie {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'runtime')
  final String? runtime;

  @JsonKey(name: 'image')
  final ComicVineImage? image;

  ComicVineMovie(this.id,this.name, this.releaseDate, this.runtime, this.image);

  factory ComicVineMovie.fromJson(Map<String, dynamic> json) =>
      _$ComicVineMovieFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineMovieToJson(this);
}

//Informations Details Film
@JsonSerializable()
class ComicVineMovieDetail {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'runtime')
  final int budget;

  ComicVineMovieDetail(this.id,this.name, this.releaseDate, this.budget);

  factory ComicVineMovieDetail.fromJson(Map<String, dynamic> json) =>
      _$ComicVineMovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineMovieDetailToJson(this);
}

@JsonSerializable()
class ComicVinePublisher {
  @JsonKey(name: 'api_detail_url')
  final String apiDetailUrl;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'image')
  final ComicVineImage? image;

  ComicVinePublisher(this.apiDetailUrl, this.id, this.name,this.image);

  factory ComicVinePublisher.fromJson(Map<String, dynamic> json) =>
      _$ComicVinePublisherFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVinePublisherToJson(this);
}


//Informations Page Serie
@JsonSerializable()
class ComicVineSeries {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'count_of_episodes')
  final int nbEpisode;

  @JsonKey(name: 'start_year')
  final String year;

  @JsonKey(name: 'image')
  final ComicVineImage? image;


  ComicVineSeries(this.id, this.name,this.nbEpisode, this.year, this.image);

  factory ComicVineSeries.fromJson(Map<String, dynamic> json) =>
      _$ComicVineSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineSeriesToJson(this);
}

//Informations Details Serie
@JsonSerializable()
class ComicVineSerieDetail {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'deck')
  final String description;

  @JsonKey(name: 'count_of_episodes')
  final int nbEpisode;

  @JsonKey(name: 'start_year')
  final String year;

  @JsonKey(name: 'image')
  final ComicVineImage? image;

  @JsonKey(name: 'publisher')
  final ComicVinePublisher? publisher;

  ComicVineSerieDetail(this.name, this.description, this.publisher, this.image, this.year,this.nbEpisode);

  factory ComicVineSerieDetail.fromJson(Map<String, dynamic> json) => _$ComicVineSerieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineSerieDetailToJson(this);
}


//Informations Page Comics
@JsonSerializable()
class ComicVineIssues {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'issue_number')
  final String? number;

  @JsonKey(name: 'cover_date')
  final String? date;

  @JsonKey(name: 'volume')
  final ComicVineComic? comic;

  @JsonKey(name: 'image')
  final ComicVineImage? image;



  ComicVineIssues(this.id,this.name, this.number,this.image,this.comic,this.date);

  factory ComicVineIssues.fromJson(Map<String, dynamic> json) =>
      _$ComicVineIssuesFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineIssuesToJson(this);
}

//Informations Details Comics
@JsonSerializable()
class ComicVineIssueDetail {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'issue_number')
  final String? number;

  @JsonKey(name: 'cover_date')
  final String? date;

  @JsonKey(name: 'volume')
  final ComicVineComic? comic;

  @JsonKey(name: 'image')
  final ComicVineImage? image;

  @JsonKey(name: 'deck')
  final String? description;

  ComicVineIssueDetail(this.id,this.name,this.number,this.comic, this.date,this.image, this.description);

  factory ComicVineIssueDetail.fromJson(Map<String, dynamic> json) =>
      _$ComicVineIssueDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineIssueDetailToJson(this);
}

///RECUP IMAGE  - affichage : Image.network(movie.image!.iconUrl, width: 50, height: 50) : null
@JsonSerializable()
class ComicVineImage {
  @JsonKey(name: 'icon_url')
  final String iconUrl;

  ComicVineImage(this.iconUrl);

  factory ComicVineImage.fromJson(Map<String, dynamic> json) => _$ComicVineImageFromJson(json);
}

///RECUP COMIC
@JsonSerializable()
class ComicVineComic {

  @JsonKey(name: 'name')
  final String name;

  ComicVineComic(this.name);

  factory ComicVineComic.fromJson(Map<String, dynamic> json) => _$ComicVineComicFromJson(json);
}