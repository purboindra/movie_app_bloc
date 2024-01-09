import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/base_bloc.dart';
import 'package:imdb_bloc/domain/event/watchlist_movie_event.dart';
import 'package:imdb_bloc/domain/repositories/movie_repository.dart';
import 'package:imdb_bloc/domain/state/watchlist_move_state.dart';
import 'package:imdb_bloc/utils/debug_print.dart';

class WatchlistMovieBloc
    extends BaseBloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistMovieBloc(this._movieRepository)
      : super(InitialWatchlistMovieState()) {
    on<AddMovieToWatchlistEvent>(_handleAddToWatchlist);
    on<GetWatchlistMovieEvent>(_handleGetWatchlistMovies);
  }

  void _handleAddToWatchlist(
      AddMovieToWatchlistEvent event, Emitter<WatchlistMovieState> emit) async {
    emit(LoadingAddToWatchlistState());
    try {
      await _movieRepository.addToWatchList(event.accountId, {
        "media_type": "movie",
        "media_id": event.movieId,
        "watchlist": true,
      });
      emit(SuccessAddToWatchlist());
    } catch (e, st) {
      emit(InitialWatchlistMovieState());
      AppPrint.debugPrint("ERROR FROM ADD TO WATCHLIST $e $st");
    }
  }

  void _handleGetWatchlistMovies(
      GetWatchlistMovieEvent event, Emitter<WatchlistMovieState> emit) async {
    emit(LoadingGetWatchlistState());
    try {
      final results = await _movieRepository.getWatchlist(event.accountId);
      emit(SuccessGetWatchlistState(results));
      AppPrint.debugPrint("SUCCESS GET WATCHLIST");
    } catch (e, st) {
      AppPrint.debugPrint("ERROR FROM GET WATCHLIST $e $st");
      emit(ErrorGetWatchlistState());
    }
  }

  final MovieRepository _movieRepository;
}
