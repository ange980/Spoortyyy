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
  final List<ComicVineMovieDetail> results;

  ComicVineMoviesDetailResponse(this.results);

  factory ComicVineMoviesDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ComicVineMoviesDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ComicVineMoviesDetailResponseToJson(this);
}

@JsonSerializable()
class ComicVineVolumesResponse {
  @JsonKey(name: 'results')
  final List<ComicVineVolume> results;

  ComicVineVolumesResponse(this.results);

  factory ComicVineVolumesResponse.fromJson(Map<String, dynamic> json) =>
      _$ComicVineVolumesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineVolumesResponseToJson(this);
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

  ComicVineMovie(this.id,this.name, this.releaseDate, this.runtime);

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

  @JsonKey(name: 'budget')
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

  ComicVinePublisher(this.apiDetailUrl, this.id, this.name);

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


  ComicVineSeries(this.id, this.name,this.nbEpisode, this.year);

  factory ComicVineSeries.fromJson(Map<String, dynamic> json) =>
      _$ComicVineSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineSeriesToJson(this);
}


//Informations Page Comics
@JsonSerializable()
class ComicVineVolume {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'issue_number')
  final int? issueNumber;

  @JsonKey(name: 'date_added')
  final String? dateAdded;

  ComicVineVolume(this.name, this.issueNumber,this.dateAdded);

  factory ComicVineVolume.fromJson(Map<String, dynamic> json) =>
      _$ComicVineVolumeFromJson(json);

  Map<String, dynamic> toJson() => _$ComicVineVolumeToJson(this);
}