// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMovieResponse _$FavoriteMovieResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteMovieResponse(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: json['vote_average'] as num?,
      voteCount: json['vote_count'] as num?,
    );

Map<String, dynamic> _$FavoriteMovieResponseToJson(
        FavoriteMovieResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'popularity': instance.popularity,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
