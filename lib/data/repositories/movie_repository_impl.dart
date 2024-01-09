import 'package:imdb_bloc/app/utils/app_util.dart';
import 'package:imdb_bloc/data/mappers/movie_mapper.dart';
import 'package:imdb_bloc/data/remote/movie_api.dart';
import 'package:imdb_bloc/data/remote/responses/favorite_movie_response.dart';
import 'package:imdb_bloc/domain/entities/detail_movie_data.dart';
import 'package:imdb_bloc/domain/entities/movie_data.dart';
import 'package:imdb_bloc/domain/repositories/movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(this._movieApi);

  final MovieApi _movieApi;

  @override
  Future<List<MovieData>> getTrendingMovieOfThisWeek() async {
    final paginatedResponse = await _movieApi.getTrendingMoviesOfThisWeek();
    final movies = paginatedResponse.results;
    final data = movies.map((movie) => movie.toData).toList();
    return data;
  }

  @override
  Future<List<MovieData>> getNowPlayingMovie() async {
    final paginatedResponse = await _movieApi.getNowPlayingMovies();
    final movies = paginatedResponse.results;
    final data = movies.map((e) => e.toData).toList();
    return data;
  }

  @override
  Future<DetailMovieData> getDetailMovie(String id) async {
    final data = await _movieApi.getDetailMovie(id);
    final dataDetail = DetailMovieData(
        id: data.id ?? 0,
        title: data.title ?? "",
        backdropUrl: AppUtils.addBaseImageUrl(data.backdropPath ?? ""),
        rating: data.voteAverage ?? 0,
        posterUrl: AppUtils.addBaseImageUrl(data.posterPath ?? ""),
        overview: data.overview ?? "",
        genres: data.genres ?? <Map<String, dynamic>>[],
        runTime: data.runTime ?? 0,
        status: data.status ?? "",
        voteAverage: data.voteAverage ?? 0,
        voteCount: data.voteCount?.toDouble() ?? 0);
    return dataDetail;
  }

  @override
  Future<void> addToFav(String accountId, Map<String, dynamic> body) async {
    await _movieApi.addToFav(accountId, body);
  }

  @override
  Future<List<FavoriteMovieResponse>> getFavorites(String accountId) async {
    final response = await _movieApi.getFavoriteMovie(accountId);
    return response.results;
  }

  @override
  Future<void> addToWatchList(
      String accountId, Map<String, dynamic> body) async {
    await _movieApi.addToWatchlist(accountId, body);
  }

  @override
  Future<List<FavoriteMovieResponse>> getWatchlist(String accountId) async {
    final response = await _movieApi.getWatchlistMovie(accountId);
    return response.results;
  }
}
