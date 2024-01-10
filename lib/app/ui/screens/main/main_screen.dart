import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_bloc/app/navigation/app_router.dart';
import 'package:imdb_bloc/app/ui/screens/main/home/home_screen.dart';
import 'package:imdb_bloc/app/ui/screens/main/home/home_screen_view_model.dart';
import 'package:imdb_bloc/app/ui/screens/main/main_view_model.dart';
import 'package:imdb_bloc/app/ui/screens/main/widgets/bottom_navbar_item.dart';
import 'package:imdb_bloc/app/utils/app_util.dart';
import 'package:imdb_bloc/domain/bloc/auth_bloc.dart';
import 'package:imdb_bloc/domain/bloc/favorite_movie_bloc.dart';
import 'package:imdb_bloc/domain/bloc/home_bloc.dart';
import 'package:imdb_bloc/domain/bloc/main_bloc.dart';
import 'package:imdb_bloc/domain/bloc/watchlist_movie_bloc.dart';
import 'package:imdb_bloc/domain/event/auth_event.dart';
import 'package:imdb_bloc/domain/event/favorite_movie_event.dart';
import 'package:imdb_bloc/domain/event/watchlist_movie_event.dart';
import 'package:imdb_bloc/domain/state/auth_state.dart';
import 'package:imdb_bloc/domain/state/favorite_movie_state.dart';
import 'package:imdb_bloc/domain/state/main_state.dart';
import 'package:imdb_bloc/domain/state/watchlist_move_state.dart';
import 'package:imdb_bloc/utils/colors.dart';
import 'package:imdb_bloc/utils/extensions.dart';
import 'package:imdb_bloc/utils/typography.dart';

List<Widget> _buildBody = [
  const _BuildHomeWidget(),
  const _BuildFavoriteWidget(),
  const _BuildWatchlistWidget(),
  const _BuildProfileWidget(),
];

const List<IconData> _icons = [
  CupertinoIcons.home,
  CupertinoIcons.heart,
  CupertinoIcons.film,
  CupertinoIcons.person,
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.viewModel});

  final MainScreenViewModel viewModel;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    context.read<AuthBloc>().close();
    context.read<HomeBloc>().close();

    super.dispose();
  }

  @override
  void initState() {
    context
        .read<FavoriteMovieBloc>()
        .add(const GetFavoriteMovieEvent("533899"));
    context
        .read<WatchlistMovieBloc>()
        .add(const GetWatchlistMovieEvent("533899"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 65,
            padding:
                const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 5),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _icons.length,
                  (index) => BottomNavbarItem(
                      isSelected: index == state.tabIndex,
                      index: index,
                      icon: _icons[index]),
                ),
              ),
            ),
          ),
          extendBody: true,
          body: _buildBody[state.tabIndex],
        );
      },
    );
  }
}

class _BuildProfileWidget extends StatelessWidget {
  const _BuildProfileWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoadingLogOutState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign Out"),
              10.h,
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                  child: const Text("Sign out"))
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessLogOutState) {
          context.pushReplacement(AppRouter.signIn);
        } else if (state is ErrorLogOutState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }
      },
    );
  }
}

class _BuildWatchlistWidget extends StatelessWidget {
  const _BuildWatchlistWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            const Text(
              "Watchlist",
              style: AppTypography.title,
            ),
            20.h,
            BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state is LoadingGetWatchlistState) {
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ));
                } else if (state is SuccessGetWatchlistState) {
                  return Expanded(
                    child: state.favoriteMovies.isEmpty
                        ? const Center(
                            child: Text("Belum ada favorite list"),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.8),
                            itemCount: state.favoriteMovies.length,
                            itemBuilder: (context, index) {
                              final movie = state.favoriteMovies[index];
                              return InkWell(
                                onTap: () {
                                  context.push('/main/${AppRouter.detail}',
                                      extra: {
                                        "id": movie.id,
                                      });
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                AppUtils.addBaseImageUrl(
                                                    movie.posterPath!),
                                              ),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          movie.title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: AppTypography.text.copyWith(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                }
                return const Expanded(
                    child: Center(
                  child: Text("Maaf, terjadi kesalahan"),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class _BuildFavoriteWidget extends StatelessWidget {
  const _BuildFavoriteWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            const Text(
              "Favorite",
              style: AppTypography.title,
            ),
            20.h,
            BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state is LoadingGetFavoriteMovieState) {
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ));
                } else if (state is SuccessGetFavoriteMovieState) {
                  return Expanded(
                    child: state.favoriteMovies.isEmpty
                        ? const Center(
                            child: Text("Belum ada favorite list"),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.8),
                            itemCount: state.favoriteMovies.length,
                            itemBuilder: (context, index) {
                              final movie = state.favoriteMovies[index];
                              return InkWell(
                                onTap: () {
                                  context.push('/main/${AppRouter.detail}',
                                      extra: {
                                        "id": movie.id,
                                      });
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                AppUtils.addBaseImageUrl(
                                                    movie.posterPath!),
                                              ),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          movie.title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: AppTypography.text.copyWith(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                }
                return const Expanded(
                    child: Center(
                  child: Text("Maaf, terjadi kesalahan"),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class _BuildHomeWidget extends StatelessWidget {
  const _BuildHomeWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (_, state) {
              if (state is SuccessGetCurrentUserState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTypography.text.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: "Selamat datang kembali, ",
                              style: AppTypography.text.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                                text: "${state.user["email"].split("@")[0]}"),
                          ],
                        ),
                      ),
                      Text(
                        "Mau nonton apa hari ini?",
                        style: AppTypography.smallText.copyWith(
                          fontSize: 14,
                          color: AppColors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                HomeScreen(
                  homeScreenViewModel: HomeScreenViewModel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
