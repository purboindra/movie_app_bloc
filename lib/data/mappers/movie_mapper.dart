import 'package:imdb_bloc/app/utils/app_util.dart';
import 'package:imdb_bloc/data/remote/responses/movie_response.dart';
import 'package:imdb_bloc/domain/entities/movie_data.dart';

extension MovieMapper on MovieResponse {
  MovieData get toData => MovieData(
        id: id ?? 0,
        title: title ?? "",
        overview: overview ?? "",
        rating: voteAverage ?? 0.0,
        posterUrl: AppUtils.addBaseImageUrl(posterPath ?? ""),
      );
}
