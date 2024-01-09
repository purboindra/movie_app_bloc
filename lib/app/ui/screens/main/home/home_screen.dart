import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/app/ui/screens/main/home/home_screen_view_model.dart';
import 'package:imdb_bloc/app/ui/screens/main/home/widgets/movie_item.dart';
import 'package:imdb_bloc/domain/bloc/home_bloc.dart';
import 'package:imdb_bloc/domain/state/home_state.dart';
import 'package:imdb_bloc/utils/extensions.dart';
import 'package:imdb_bloc/utils/typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.homeScreenViewModel});

  final HomeScreenViewModel homeScreenViewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.homeScreenViewModel.fetchTrendingAndNowPlayingMovies(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.h,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Trending Minggu Ini",
              style: AppTypography.title.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          10.h,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (_, state) => state is TrendingMoviesHomeState,
            builder: (context, state) {
              if (state is FetchedTrendingMoviesHomeState) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.movies.length,
                    separatorBuilder: (_, __) {
                      return 8.h;
                    },
                    itemBuilder: (_, index) {
                      final movie = state.movies[index];
                      return MovieItem(movie: movie, index: index);
                    },
                  ),
                );
              }
              if (state is FetchFailTrendingMoviesHomeState) {
                return const Expanded(
                  child: Center(
                    child: Text("Maaf, terjadi kesalahan..."),
                  ),
                );
              }
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          ),
          20.h,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Sedang Tayang",
              style: AppTypography.title.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          10.h,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (_, state) => state is NowPlayingMoviesHomeState,
            builder: (context, state) {
              if (state is FetchedNowPlayingMoviesHomeState) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.movies.length,
                    separatorBuilder: (_, __) {
                      return 8.h;
                    },
                    itemBuilder: (_, index) {
                      final movie = state.movies[index];
                      return MovieItem(movie: movie, index: index);
                    },
                  ),
                );
              }
              if (state is FetchFailTrendingMoviesHomeState) {
                return const Expanded(
                  child: Center(
                    child: Text("Maaf, terjadi kesalahan..."),
                  ),
                );
              }
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
