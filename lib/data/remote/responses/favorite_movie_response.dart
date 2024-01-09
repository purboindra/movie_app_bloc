import 'package:json_annotation/json_annotation.dart';

part 'favorite_movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FavoriteMovieResponse {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  double? popularity;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;
  FavoriteMovieResponse({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.popularity,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory FavoriteMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMovieResponseFromJson(json);
}
