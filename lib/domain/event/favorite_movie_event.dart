import 'package:equatable/equatable.dart';

sealed class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();

  @override
  List<Object> get props => [];
}

class AddMovieToFavEvent extends FavoriteMovieEvent {
  final String accountId;
  final int movieId;

  const AddMovieToFavEvent(this.accountId, this.movieId);

  @override
  List<Object> get props => [accountId, movieId];
}

class GetFavoriteMovieEvent extends FavoriteMovieEvent {
  final String accountId;

  const GetFavoriteMovieEvent(this.accountId);

  @override
  List<Object> get props => [accountId];
}
