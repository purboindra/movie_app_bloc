import 'package:dio/dio.dart';
import 'package:imdb_bloc/data/remote/responses/detail_movie_response.dart';
import 'package:imdb_bloc/data/remote/responses/favorite_movie_response.dart';
import 'package:imdb_bloc/data/remote/responses/movie_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'responses/paginated_response.dart';

part 'movie_api.g.dart';

@RestApi()
@singleton
abstract class MovieApi {
  @factoryMethod
  factory MovieApi(Dio dio) = _MovieApi;

  @GET('/trending/movie/week')
  Future<PaginatedResponse<MovieResponse>> getTrendingMoviesOfThisWeek();

  @GET('/movie/now_playing')
  Future<PaginatedResponse<MovieResponse>> getNowPlayingMovies();

  @GET('/movie/{id}')
  Future<DetailMovieResponse> getDetailMovie(@Path('id') String id);

  @POST('/account/{account_id}/favorite')
  Future<void> addToFav(
      @Path('account_id') String accountId, @Body() Map<String, dynamic> body);

  @GET('/account/{account_id}/favorite/movies')
  Future<PaginatedResponse<FavoriteMovieResponse>> getFavoriteMovie(
      @Path("account_id") String accountId);

  @POST('/account/{account_id}/watchlist')
  Future<void> addToWatchlist(
      @Path('account_id') String accountId, @Body() Map<String, dynamic> body);

  @GET('/account/{account_id}/watchlist/movies')
  Future<PaginatedResponse<FavoriteMovieResponse>> getWatchlistMovie(
      @Path("account_id") String accountId);
}
