import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/base_bloc.dart';
import 'package:imdb_bloc/domain/event/detail_movie_event.dart';
import 'package:imdb_bloc/domain/repositories/movie_repository.dart';
import 'package:imdb_bloc/domain/state/detail_movie_state.dart';
import 'package:imdb_bloc/utils/debug_print.dart';

class DetailMovieBloc extends BaseBloc<DetailMovieEvent, DetailMovieState> {
  DetailMovieBloc(this._movieRepository) : super(InitialDetailMovieState()) {
    on<FetchDetailMovieEvent>(_getDetailMovie);
  }

  void _getDetailMovie(
      FetchDetailMovieEvent event, Emitter<DetailMovieState> emit) async {
    emit(LoadingDetailMovieState());
    try {
      final response =
          await _movieRepository.getDetailMovie(event.id.toString());
      emit(SuccessDetailMovieState(response));
    } catch (e) {
      AppPrint.debugPrint('ERROR FROM GET DETIAL MOVIE $e');
      emit(InitialDetailMovieState());
    }
  }

  final MovieRepository _movieRepository;
}
