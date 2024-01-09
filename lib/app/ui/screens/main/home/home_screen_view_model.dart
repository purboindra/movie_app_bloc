import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/home_bloc.dart';
import 'package:imdb_bloc/domain/event/home_event.dart';

class HomeScreenViewModel {
  void fetchTrendingAndNowPlayingMovies(BuildContext context) {
    context.read<HomeBloc>().add(FetchTrendingMovieHomeEvent());
    context.read<HomeBloc>().add(FetchNowPlayingMovieHomeEvent());
  }
}
