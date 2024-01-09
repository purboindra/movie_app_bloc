import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/base_bloc.dart';
import 'package:imdb_bloc/domain/event/auth_event.dart';
import 'package:imdb_bloc/domain/repositories/auth_repository.dart';
import 'package:imdb_bloc/domain/state/auth_state.dart';
import 'package:imdb_bloc/utils/debug_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<SignInEvent>(_handleSignIn);
    on<GetCurrentUserEvent>(_getUser);
  }

  void _getUser(GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final getUser = prefs.getString("token");
    AppPrint.debugPrint('GET USER $getUser');
    if (getUser != null) {
      final splitData = getUser.split("-");
      final user = {
        "email": splitData[0],
        "password": splitData[1],
      };
      emit(SuccessGetCurrentUserState(user));
      AppPrint.debugPrint('CURRENT USER $user');
    } else {
      AppPrint.debugPrint('USER NULL ');
    }
  }

  void _handleSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    final loginSuccess = await authRepository.signIn(
        email: event.email, password: event.password);
    if (loginSuccess && event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(AuthSuccessState(isLoggedin: loginSuccess, user: {
        "email": event.email,
        "password": event.password,
      }));
      AppPrint.debugPrint("USER ${event.email} ${event.password}");
    } else {
      emit(AuthInitialState());
    }
  }

  final AuthRepository authRepository;

  @override
  Future<void> close() {
    AppPrint.debugPrint('AUTH BLOC DISPOSE');
    return super.close();
  }
}
