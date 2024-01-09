import 'package:equatable/equatable.dart';
import 'package:imdb_bloc/data/remote/responses/favorite_movie_response.dart';

sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class InitialWatchlistMovieState extends WatchlistMovieState {}

class LoadingAddToWatchlistState extends WatchlistMovieState {}

class SuccessAddToWatchlist extends WatchlistMovieState {}

class LoadingGetWatchlistState extends WatchlistMovieState {}

class SuccessGetWatchlistState extends WatchlistMovieState {
  final List<FavoriteMovieResponse> favoriteMovies;

  const SuccessGetWatchlistState(this.favoriteMovies);

  @override
  List<Object> get props => [favoriteMovies];
}

class ErrorGetWatchlistState extends WatchlistMovieState {}
