import 'package:equatable/equatable.dart';
import 'package:imdb_bloc/data/remote/responses/favorite_movie_response.dart';

sealed class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

class InitialFavoriteMovieState extends FavoriteMovieState {}

class LoadingAddToFavState extends FavoriteMovieState {}

class SuccessAddToFavState extends FavoriteMovieState {}

class LoadingGetFavoriteMovieState extends FavoriteMovieState {}

class SuccessGetFavoriteMovieState extends FavoriteMovieState {
  final List<FavoriteMovieResponse> favoriteMovies;

  const SuccessGetFavoriteMovieState(this.favoriteMovies);

  @override
  List<Object> get props => [favoriteMovies];
}

class ErrorGetFavoriteMovieState extends FavoriteMovieState {}
