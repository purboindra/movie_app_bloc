import 'package:imdb_bloc/data/remote/responses/favorite_movie_response.dart';
import 'package:imdb_bloc/domain/entities/detail_movie_data.dart';
import 'package:imdb_bloc/domain/entities/movie_data.dart';

abstract class MovieRepository {
  Future<List<MovieData>> getTrendingMovieOfThisWeek();
  Future<List<MovieData>> getNowPlayingMovie();
  Future<DetailMovieData> getDetailMovie(String id);
  Future<void> addToFav(String accountId, Map<String, dynamic> body);
  Future<List<FavoriteMovieResponse>> getFavorites(String accountId);
  Future<void> addToWatchList(String accountId, Map<String, dynamic> body);
  Future<List<FavoriteMovieResponse>> getWatchlist(String accountId);
}
