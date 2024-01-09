import 'package:equatable/equatable.dart';

class DetailMovieData with EquatableMixin {
  DetailMovieData({
    required this.id,
    required this.title,
    required this.rating,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.runTime,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropUrl,
  });

  final int id;
  final String title;
  final double rating;
  final String posterUrl;
  final String backdropUrl;
  final String overview;
  final double voteAverage;
  final double voteCount;
  final int runTime;
  final String status;
  final List<Map<String, dynamic>> genres;

  @override
  List<Object> get props => [
        id,
        title,
        rating,
        posterUrl,
        overview,
        voteAverage,
        voteCount,
        runTime,
        status,
        backdropUrl,
        genres
      ];
}
