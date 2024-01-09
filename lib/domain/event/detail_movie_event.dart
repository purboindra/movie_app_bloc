import 'package:equatable/equatable.dart';

sealed class DetailMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDetailMovieEvent extends DetailMovieEvent {
  final int id;

  FetchDetailMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}
