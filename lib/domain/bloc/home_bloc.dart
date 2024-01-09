import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/base_bloc.dart';
import 'package:imdb_bloc/domain/event/home_event.dart';
import 'package:imdb_bloc/domain/repositories/movie_repository.dart';
import 'package:imdb_bloc/domain/state/home_state.dart';
import 'package:imdb_bloc/utils/debug_print.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._movieRepository) : super(InitialHomeState()) {
    on<FetchTrendingMovieHomeEvent>(_handleFetchTrendingMovies);
    on<FetchNowPlayingMovieHomeEvent>(_handleFetchNowPlayingMovies);
  }

  final MovieRepository _movieRepository;

  void _handleFetchTrendingMovies(
      FetchTrendingMovieHomeEvent event, Emitter<HomeState> emit) async {
    emit(InitialHomeState());
    try {
      final data = await _movieRepository.getTrendingMovieOfThisWeek();
      emit(FetchedTrendingMoviesHomeState(data));
    } catch (e, st) {
      AppPrint.debugPrint("ERROR FROM HANDLE FETCH TRENDING HOME BLOC $e $st");
      emit(FetchFailTrendingMoviesHomeState());
    }
  }

  void _handleFetchNowPlayingMovies(
      FetchNowPlayingMovieHomeEvent event, Emitter<HomeState> emit) async {
    emit(InitialHomeState());
    try {
      final data = await _movieRepository.getNowPlayingMovie();
      emit(FetchedNowPlayingMoviesHomeState(data));
    } catch (e, st) {
      AppPrint.debugPrint(
          "ERROR FROM HANDLE FETCH NOW PLAYING HOME BLOC $e $st");
      emit(FetchFailNowPlayingMoviesHomeState());
    }
  }
}
