import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_bloc/app/navigation/app_router.dart';
import 'package:imdb_bloc/app/ui/screens/details/detail_screen.dart';
import 'package:imdb_bloc/app/ui/screens/main/main_screen.dart';
import 'package:imdb_bloc/app/ui/screens/main/main_view_model.dart';
import 'package:imdb_bloc/app/ui/screens/sign_in/sign_in_screen.dart';
import 'package:imdb_bloc/app/ui/screens/splash/splash_screen.dart';
import 'package:imdb_bloc/di/inject.dart';
import 'package:imdb_bloc/domain/bloc/home_bloc.dart';

class AppRouterConfig {
  // static String? _redirect(BuildContext context) {
  //   final userState = context.watch<AuthBloc>().state;
  //   if (userState is SuccessGetCurrentUserState ||
  //       userState is AuthSuccessState) {
  //     return AppRouter.main;
  //   } else {
  //     return AppRouter.signIn;
  //   }
  // }

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRouter.root,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouter.signIn,
        name: AppRouter.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRouter.main,
        name: AppRouter.main,
        builder: (_, state) {
          return MultiBlocProvider(providers: [
            BlocProvider(
              lazy: false,
              create: (_) => HomeBloc(
                inject(),
              ),
            ),
          ], child: const MainScreen(viewModel: MainScreenViewModel()));
        },
        routes: [
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return DetailScreen(
                id: data["id"],
              );
            },
          ),
        ],
      ),
    ],
    initialLocation: AppRouter.root,
  );
}
