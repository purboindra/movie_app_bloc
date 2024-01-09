import 'package:equatable/equatable.dart';

sealed class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class AddMovieToWatchlistEvent extends WatchlistMovieEvent {
  final String accountId;
  final int movieId;

  const AddMovieToWatchlistEvent(this.accountId, this.movieId);

  @override
  List<Object> get props => [accountId, movieId];
}

class GetWatchlistMovieEvent extends WatchlistMovieEvent {
  final String accountId;

  const GetWatchlistMovieEvent(this.accountId);

  @override
  List<Object> get props => [accountId];
}
