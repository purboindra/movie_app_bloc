import 'package:equatable/equatable.dart';
import 'package:imdb_bloc/domain/entities/movie_data.dart';

sealed class HomeState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class InitialHomeState extends HomeState {}

sealed class NowPlayingMoviesHomeState extends HomeState {}

sealed class TrendingMoviesHomeState extends HomeState {}

class FetchFailTrendingMoviesHomeState extends TrendingMoviesHomeState {}

class FetchedTrendingMoviesHomeState extends TrendingMoviesHomeState {
  FetchedTrendingMoviesHomeState(this.movies);

  final List<MovieData> movies;

  @override
  List<Object> get props => [movies];
}

class FetchFailNowPlayingMoviesHomeState extends NowPlayingMoviesHomeState {}

class FetchedNowPlayingMoviesHomeState extends NowPlayingMoviesHomeState {
  FetchedNowPlayingMoviesHomeState(this.movies);

  final List<MovieData> movies;

  @override
  List<Object> get props => [movies];
}
