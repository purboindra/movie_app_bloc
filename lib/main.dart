import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_bloc/app_bloc_observer.dart';
import 'package:imdb_bloc/data/repositories/auth_repository_impl.dart';
import 'package:imdb_bloc/di/di_container.dart';
import 'package:imdb_bloc/di/inject.dart';
import 'package:imdb_bloc/domain/bloc/auth_bloc.dart';
import 'package:imdb_bloc/domain/bloc/detail_movie_bloc.dart';
import 'package:imdb_bloc/domain/bloc/favorite_movie_bloc.dart';
import 'package:imdb_bloc/domain/bloc/main_bloc.dart';
import 'package:imdb_bloc/domain/bloc/watchlist_movie_bloc.dart';
import 'package:imdb_bloc/domain/event/auth_event.dart';

import 'app/navigation/app_router_config.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  final authRepository = AuthRepositoryImpl();
  runApp(MyApp(
    authRepositoryImpl: authRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required AuthRepositoryImpl authRepositoryImpl})
      : _authRepositoryImpl = authRepositoryImpl;

  final AuthRepositoryImpl _authRepositoryImpl;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepositoryImpl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (_) =>
                  AuthBloc(AuthRepositoryImpl())..add(GetCurrentUserEvent())),
          BlocProvider<MainBloc>(create: (_) => MainBloc()),
          BlocProvider(
            create: (_) => DetailMovieBloc(inject()),
          ),
          BlocProvider(
            create: (_) => FavoriteMovieBloc(inject()),
          ),
          BlocProvider(
            create: (_) => WatchlistMovieBloc(inject()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRouterConfig.router,
        ),
      ),
    );
  }
}
