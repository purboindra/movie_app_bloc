import 'package:equatable/equatable.dart';
import 'package:imdb_bloc/domain/entities/detail_movie_data.dart';

sealed class DetailMovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDetailMovieState extends DetailMovieState {}

class LoadingDetailMovieState extends DetailMovieState {}

class SuccessDetailMovieState extends DetailMovieState {
  final DetailMovieData detailMovieData;

  SuccessDetailMovieState(this.detailMovieData);

  @override
  List<Object> get props => [detailMovieData];
}
