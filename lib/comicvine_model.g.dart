// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comicvine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicVineMoviesResponse _$ComicVineMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineMoviesResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineMoviesResponseToJson(
        ComicVineMoviesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineSeriesResponse _$ComicVineSeriesResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineSeriesResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineSeries.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineSeriesResponseToJson(
        ComicVineSeriesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineMoviesDetailResponse _$ComicVineMoviesDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineMoviesDetailResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineMovieDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineMoviesDetailResponseToJson(
        ComicVineMoviesDetailResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineVolumesResponse _$ComicVineVolumesResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineVolumesResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineVolume.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineVolumesResponseToJson(
        ComicVineVolumesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineMovie _$ComicVineMovieFromJson(Map<String, dynamic> json) =>
    ComicVineMovie(
      json['id'] as int,
      json['name'] as String?,
      json['release_date'] as String?,
      json['runtime'] as String?,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineMovieToJson(ComicVineMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'release_date': instance.releaseDate,
      'runtime': instance.runtime,
      'image': instance.image,
    };

ComicVineMovieDetail _$ComicVineMovieDetailFromJson(
        Map<String, dynamic> json) =>
    ComicVineMovieDetail(
      json['id'] as int,
      json['name'] as String?,
      json['release_date'] as String?,
      json['budget'] as int,
    );

Map<String, dynamic> _$ComicVineMovieDetailToJson(
        ComicVineMovieDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'release_date': instance.releaseDate,
      'budget': instance.budget,
    };

ComicVinePublisher _$ComicVinePublisherFromJson(Map<String, dynamic> json) =>
    ComicVinePublisher(
      json['api_detail_url'] as String,
      json['id'] as int,
      json['name'] as String,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVinePublisherToJson(ComicVinePublisher instance) =>
    <String, dynamic>{
      'api_detail_url': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

ComicVineSeries _$ComicVineSeriesFromJson(Map<String, dynamic> json) =>
    ComicVineSeries(
      json['id'] as int,
      json['name'] as String?,
      json['count_of_episodes'] as int,
      json['start_year'] as String,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineSeriesToJson(ComicVineSeries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count_of_episodes': instance.nbEpisode,
      'start_year': instance.year,
      'image': instance.image,
    };

ComicVineVolume _$ComicVineVolumeFromJson(Map<String, dynamic> json) =>
    ComicVineVolume(
      json['name'] as String?,
      json['issue_number'] as int?,
      json['date_added'] as String?,
    );

Map<String, dynamic> _$ComicVineVolumeToJson(ComicVineVolume instance) =>
    <String, dynamic>{
      'name': instance.name,
      'issue_number': instance.issueNumber,
      'date_added': instance.dateAdded,
    };

ComicVineImage _$ComicVineImageFromJson(Map<String, dynamic> json) =>
    ComicVineImage(
      json['icon_url'] as String,
    );

Map<String, dynamic> _$ComicVineImageToJson(ComicVineImage instance) =>
    <String, dynamic>{
      'icon_url': instance.iconUrl,
    };
