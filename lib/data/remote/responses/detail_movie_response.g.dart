// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMovieResponse _$DetailMovieResponseFromJson(Map<String, dynamic> json) =>
    DetailMovieResponse(
      json['adult'] as bool?,
      json['backdrop_path'] as String?,
      json['id'] as int?,
      json['title'] as String?,
      json['original_language'] as String?,
      json['original_title'] as String?,
      json['overview'] as String?,
      json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      json['poster_path'] as String?,
      (json['vote_average'] as num?)?.toDouble(),
      json['vote_count'] as int?,
      (json['genres'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      json['run_time'] as int?,
      json['status'] as String?,
    );

Map<String, dynamic> _$DetailMovieResponseToJson(
        DetailMovieResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'title': instance.title,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'release_date': instance.releaseDate?.toIso8601String(),
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genres': instance.genres,
      'status': instance.status,
      'run_time': instance.runTime,
    };
