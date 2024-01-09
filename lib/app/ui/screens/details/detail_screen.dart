import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_bloc/domain/bloc/detail_movie_bloc.dart';
import 'package:imdb_bloc/domain/bloc/favorite_movie_bloc.dart';
import 'package:imdb_bloc/domain/bloc/watchlist_movie_bloc.dart';
import 'package:imdb_bloc/domain/event/detail_movie_event.dart';
import 'package:imdb_bloc/domain/event/favorite_movie_event.dart';
import 'package:imdb_bloc/domain/event/watchlist_movie_event.dart';
import 'package:imdb_bloc/domain/state/detail_movie_state.dart';
import 'package:imdb_bloc/domain/state/favorite_movie_state.dart';
import 'package:imdb_bloc/domain/state/watchlist_move_state.dart';
import 'package:imdb_bloc/utils/colors.dart';
import 'package:imdb_bloc/utils/extensions.dart';
import 'package:imdb_bloc/utils/typography.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});

  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    context.read<DetailMovieBloc>().add(FetchDetailMovieEvent(widget.id));
    context
        .read<FavoriteMovieBloc>()
        .add(const GetFavoriteMovieEvent("533899"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is LoadingDetailMovieState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is SuccessDetailMovieState) {
            final movie = state.detailMovieData;
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(Rect.fromLTRB(
                              0, rect.height / 3, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.network(
                          movie.posterUrl,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 10,
                        right: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: AppTypography.text.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              5.h,
                              Text(
                                movie.overview,
                                style: AppTypography.smallText.copyWith(
                                  color: AppColors.grey.shade700,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                              10.h,
                              Text(
                                "Genres",
                                style: AppTypography.text.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              5.h,
                              Wrap(
                                runSpacing: 5.0,
                                spacing: 5.0,
                                direction: Axis.horizontal,
                                children: List.generate(
                                  movie.genres.length,
                                  (index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 9),
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      movie.genres[index]["name"],
                                      style: AppTypography.text.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white.withOpacity(0.5),
                                ),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.chevron_left,
                                    size: 18,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // FAVORITE SECTION
                                BlocConsumer<FavoriteMovieBloc,
                                    FavoriteMovieState>(
                                  listener: (context, state) {
                                    if (state is SuccessAddToFavState) {
                                      context.read<FavoriteMovieBloc>().add(
                                          const GetFavoriteMovieEvent(
                                              "533899"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Berhasil menambahkan ke favorite")));
                                    } else if (state
                                        is InitialFavoriteMovieState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Maaf, terjadi kesalahan. Silahkan coba lagi...")));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoadingGetFavoriteMovieState) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    }
                                    return IconButton(
                                      onPressed: () async {
                                        context.read<FavoriteMovieBloc>().add(
                                            AddMovieToFavEvent(
                                                "533899", movie.id));
                                      },
                                      icon: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                                  .withOpacity(0.8)),
                                          child: (() {
                                            if (state
                                                is SuccessGetFavoriteMovieState) {
                                              if (state.favoriteMovies.any(
                                                  (element) =>
                                                      element.id == movie.id)) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons.favorite,
                                                    size: 28,
                                                    color: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                            return const Center(
                                              child: Icon(
                                                Icons.favorite_outline,
                                                size: 28,
                                                color: Colors.black,
                                              ),
                                            );
                                          }())),
                                    );
                                  },
                                ),
                                10.w,
                                // WATCH LIST SECTION
                                BlocConsumer<WatchlistMovieBloc,
                                    WatchlistMovieState>(
                                  listener: (context, state) {
                                    if (state is SuccessAddToWatchlist) {
                                      context.read<WatchlistMovieBloc>().add(
                                          const GetWatchlistMovieEvent(
                                              "533899"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Berhasil menambahkan ke watchlist")));
                                    } else if (state
                                        is InitialWatchlistMovieState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Maaf, terjadi kesalahan. Silahkan coba lagi...")));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoadingGetWatchlistState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                        padding: const EdgeInsets.all(5),
                                        child: const CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    }
                                    return IconButton(
                                      onPressed: () async {
                                        context.read<WatchlistMovieBloc>().add(
                                            AddMovieToWatchlistEvent(
                                                "533899", movie.id));
                                      },
                                      icon: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                                  .withOpacity(0.8)),
                                          child: (() {
                                            if (state
                                                is SuccessGetWatchlistState) {
                                              if (state.favoriteMovies.any(
                                                  (element) =>
                                                      element.id == movie.id)) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons.bookmark,
                                                    size: 28,
                                                    color: Colors.orange,
                                                  ),
                                                );
                                              }
                                            }
                                            return const Center(
                                              child: Icon(
                                                Icons.bookmark_add_outlined,
                                                size: 28,
                                                color: Colors.black,
                                              ),
                                            );
                                          }())),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text("Maaf, terjadi kesalahan..."),
          );
        },
      ),
    );
  }
}
