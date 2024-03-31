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
      ComicVineMovieDetail.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineMoviesDetailResponseToJson(
        ComicVineMoviesDetailResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineCharacterResponse _$ComicVineCharacterResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineCharacterResponse(
      ComicVineCharacter.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineCharacterResponseToJson(
        ComicVineCharacterResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineIssuesResponse _$ComicVineIssuesResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineIssuesResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineIssues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineIssuesResponseToJson(
        ComicVineIssuesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineSerieDetailResponse _$ComicVineSerieDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineSerieDetailResponse(
      ComicVineSerieDetail.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineSerieDetailResponseToJson(
        ComicVineSerieDetailResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineIssueDetailResponse _$ComicVineIssueDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineIssueDetailResponse(
      ComicVineIssueDetail.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineIssueDetailResponseToJson(
        ComicVineIssueDetailResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineEpisodeResponse _$ComicVineEpisodeResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineEpisodeResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineEpisodeResponseToJson(
        ComicVineEpisodeResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineSearchResponse _$ComicVineSearchResponseFromJson(
        Map<String, dynamic> json) =>
    ComicVineSearchResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ComicVineSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineSearchResponseToJson(
        ComicVineSearchResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ComicVineSearch _$ComicVineSearchFromJson(Map<String, dynamic> json) =>
    ComicVineSearch(
      json['id'] as int,
      json['name'] as String?,
      json['issuenumber'] as String?,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      json['volume'] == null
          ? null
          : ComicVineComic.fromJson(json['volume'] as Map<String, dynamic>),
      json['cover_date'] as String?,
    );

Map<String, dynamic> _$ComicVineSearchToJson(ComicVineSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issuenumber': instance.number,
      'cover_date': instance.date,
      'volume': instance.comic,
      'image': instance.image,
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
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      (json['producers'] as List<dynamic>)
          .map((e) => ComicVineProducers.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['writers'] as List<dynamic>)
          .map((e) => ComicVineWriters.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['studios'] as List<dynamic>)
          .map((e) => ComicVineStudios.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['rating'] as String?,
      json['total_revenue'] as String?,
      json['distributor'] as String?,
      json['budget'] as String?,
      json['box_office_revenue'] as String?,
      json['deck'] as String?,
      (json['characters'] as List<dynamic>)
          .map((e) => ComicVinePerso.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineMovieDetailToJson(
        ComicVineMovieDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'release_date': instance.date,
      'image': instance.image,
      'total_revenue': instance.total,
      'box_office_revenue': instance.boxOffice,
      'budget': instance.budget,
      'deck': instance.description,
      'distributor': instance.distributeur,
      'rating': instance.classe,
      'writers': instance.writers,
      'studios': instance.studio,
      'producers': instance.producers,
      'characters': instance.characters,
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

ComicVineEpisode _$ComicVineEpisodeFromJson(Map<String, dynamic> json) =>
    ComicVineEpisode(
      json['id'] as int,
      json['name'] as String,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      json['episode_number'] as String,
      json['air_date'] as String,
    );

Map<String, dynamic> _$ComicVineEpisodeToJson(ComicVineEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'episode_number': instance.number,
      'air_date': instance.date,
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
      json['publisher'] == null
          ? null
          : ComicVinePublisher.fromJson(
              json['publisher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineSeriesToJson(ComicVineSeries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count_of_episodes': instance.nbEpisode,
      'start_year': instance.year,
      'image': instance.image,
      'publisher': instance.publisher,
    };

ComicVineSerieDetail _$ComicVineSerieDetailFromJson(
        Map<String, dynamic> json) =>
    ComicVineSerieDetail(
      json['name'] as String,
      json['deck'] as String,
      json['publisher'] == null
          ? null
          : ComicVinePublisher.fromJson(
              json['publisher'] as Map<String, dynamic>),
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      json['start_year'] as String,
      json['count_of_episodes'] as int,
      (json['characters'] as List<dynamic>)
          .map((e) => ComicVinePerso.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['episodes'] as List<dynamic>)
          .map((e) => ComicVineEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineSerieDetailToJson(
        ComicVineSerieDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deck': instance.description,
      'count_of_episodes': instance.nbEpisode,
      'start_year': instance.year,
      'image': instance.image,
      'publisher': instance.publisher,
      'characters': instance.characters,
      'episodes': instance.episode,
    };

ComicVineIssues _$ComicVineIssuesFromJson(Map<String, dynamic> json) =>
    ComicVineIssues(
      json['id'] as int,
      json['name'] as String?,
      json['issue_number'] as String?,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      json['volume'] == null
          ? null
          : ComicVineComic.fromJson(json['volume'] as Map<String, dynamic>),
      json['cover_date'] as String?,
    );

Map<String, dynamic> _$ComicVineIssuesToJson(ComicVineIssues instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issue_number': instance.number,
      'cover_date': instance.date,
      'volume': instance.comic,
      'image': instance.image,
    };

ComicVineIssueDetail _$ComicVineIssueDetailFromJson(
        Map<String, dynamic> json) =>
    ComicVineIssueDetail(
      json['id'] as int,
      json['name'] as String?,
      json['issue_number'] as String?,
      json['volume'] == null
          ? null
          : ComicVineComic.fromJson(json['volume'] as Map<String, dynamic>),
      json['cover_date'] as String?,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      json['deck'] as String?,
      (json['person_credits'] as List<dynamic>)
          .map((e) => ComicVineAuteur.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['character_credits'] as List<dynamic>)
          .map((e) => ComicVinePerso.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineIssueDetailToJson(
        ComicVineIssueDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issue_number': instance.number,
      'cover_date': instance.date,
      'volume': instance.comic,
      'image': instance.image,
      'deck': instance.description,
      'person_credits': instance.auteurs,
      'character_credits': instance.character,
    };

ComicVineCharacter _$ComicVineCharacterFromJson(Map<String, dynamic> json) =>
    ComicVineCharacter(
      json['id'] as int,
      json['name'] as String?,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
      json['deck'] as String?,
      json['gender'] as int,
      json['aliases'] as String?,
      json['birth'] as String?,
      json['real_name'] as String?,
      (json['creators'] as List<dynamic>)
          .map((e) => ComicVineCreator.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicVineCharacterToJson(ComicVineCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'aliases': instance.aliases,
      'real_name': instance.realName,
      'deck': instance.description,
      'birth': instance.birthday,
      'gender': instance.gender,
      'image': instance.image,
      'creators': instance.createur,
    };

ComicVineImage _$ComicVineImageFromJson(Map<String, dynamic> json) =>
    ComicVineImage(
      json['original_url'] as String,
    );

Map<String, dynamic> _$ComicVineImageToJson(ComicVineImage instance) =>
    <String, dynamic>{
      'original_url': instance.iconUrl,
    };

ComicVineComic _$ComicVineComicFromJson(Map<String, dynamic> json) =>
    ComicVineComic(
      json['name'] as String,
    );

Map<String, dynamic> _$ComicVineComicToJson(ComicVineComic instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ComicVinePerso _$ComicVinePersoFromJson(Map<String, dynamic> json) =>
    ComicVinePerso(
      json['name'] as String,
      json['id'] as int,
    );

Map<String, dynamic> _$ComicVinePersoToJson(ComicVinePerso instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ComicVineAuteur _$ComicVineAuteurFromJson(Map<String, dynamic> json) =>
    ComicVineAuteur(
      json['name'] as String,
      json['role'] as String,
      json['image'] == null
          ? null
          : ComicVineImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicVineAuteurToJson(ComicVineAuteur instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'image': instance.image,
    };

ComicVineWriters _$ComicVineWritersFromJson(Map<String, dynamic> json) =>
    ComicVineWriters(
      json['name'] as String,
    );

Map<String, dynamic> _$ComicVineWritersToJson(ComicVineWriters instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ComicVineProducers _$ComicVineProducersFromJson(Map<String, dynamic> json) =>
    ComicVineProducers(
      json['name'] as String,
    );

Map<String, dynamic> _$ComicVineProducersToJson(ComicVineProducers instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ComicVineStudios _$ComicVineStudiosFromJson(Map<String, dynamic> json) =>
    ComicVineStudios(
      json['name'] as String,
    );

Map<String, dynamic> _$ComicVineStudiosToJson(ComicVineStudios instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ComicVineCreator _$ComicVineCreatorFromJson(Map<String, dynamic> json) =>
    ComicVineCreator(
      json['name'] as String,
    );

Map<String, dynamic> _$ComicVineCreatorToJson(ComicVineCreator instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
