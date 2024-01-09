import 'package:json_annotation/json_annotation.dart';

part 'detail_movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailMovieResponse {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  DateTime? releaseDate;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  List<Map<String, dynamic>>? genres;
  String? status;
  int? runTime;

  DetailMovieResponse(
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.genres,
    this.runTime,
    this.status,
  );

  factory DetailMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailMovieResponseFromJson(json);
}
