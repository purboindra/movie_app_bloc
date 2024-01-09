import 'package:equatable/equatable.dart';

class MovieData with EquatableMixin {
  MovieData(
      {required this.id,
      required this.title,
      required this.rating,
      required this.posterUrl,
      required this.overview});

  final int id;
  final String title;
  final double rating;
  final String posterUrl;
  final String overview;

  @override
  List<Object> get props => [id, title, rating, posterUrl, overview];
}
