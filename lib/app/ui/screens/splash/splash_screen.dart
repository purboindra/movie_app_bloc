import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_bloc/app/navigation/app_router.dart';
import 'package:imdb_bloc/domain/bloc/auth_bloc.dart';
import 'package:imdb_bloc/domain/event/auth_event.dart';
import 'package:imdb_bloc/domain/state/auth_state.dart';
import 'package:imdb_bloc/utils/colors.dart';
import 'package:imdb_bloc/utils/typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetCurrentUserEvent());
    _timerSplash();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _timerSplash() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) {
      final userState = context.read<AuthBloc>().state;
      if (userState is SuccessGetCurrentUserState) {
        context.go(AppRouter.main);
      } else {
        context.go(AppRouter.signIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            'WELCOME',
            style: AppTypography.title.copyWith(
              fontSize: 32,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
