import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/base_bloc.dart';
import 'package:imdb_bloc/domain/event/favorite_movie_event.dart';
import 'package:imdb_bloc/domain/repositories/movie_repository.dart';
import 'package:imdb_bloc/domain/state/favorite_movie_state.dart';
import 'package:imdb_bloc/utils/debug_print.dart';

class FavoriteMovieBloc
    extends BaseBloc<FavoriteMovieEvent, FavoriteMovieState> {
  FavoriteMovieBloc(this._movieRepository)
      : super(InitialFavoriteMovieState()) {
    on<AddMovieToFavEvent>(_handleAddToFav);
    on<GetFavoriteMovieEvent>(_handleGetFavoriteMovies);
  }

  void _handleAddToFav(
      AddMovieToFavEvent event, Emitter<FavoriteMovieState> emit) async {
    emit(LoadingAddToFavState());
    try {
      await _movieRepository.addToFav(event.accountId,
          {"media_type": "movie", "media_id": event.movieId, "favorite": true});
      emit(SuccessAddToFavState());
    } catch (e, st) {
      emit(InitialFavoriteMovieState());
      AppPrint.debugPrint("ERROR FROM ADD TO FAV $e $st");
    }
  }

  void _handleGetFavoriteMovies(
      GetFavoriteMovieEvent event, Emitter<FavoriteMovieState> emit) async {
    emit(LoadingGetFavoriteMovieState());
    try {
      final results = await _movieRepository.getFavorites(event.accountId);
      emit(SuccessGetFavoriteMovieState(results));
      AppPrint.debugPrint("SUCCESS GET FAV");
    } catch (e, st) {
      AppPrint.debugPrint("ERROR FROM GET FAVO $e $st");
      emit(ErrorGetFavoriteMovieState());
    }
  }

  final MovieRepository _movieRepository;
}
