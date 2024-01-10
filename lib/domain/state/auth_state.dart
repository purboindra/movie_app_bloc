import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  AuthSuccessState({
    this.isLoggedin = false,
    this.user = const {},
  });
  final bool isLoggedin;
  final Map<String, dynamic> user;

  @override
  List<Object> get props => [];
}

class AuthGetUserState extends AuthState {
  AuthGetUserState({
    this.user = const {},
  });
  final Map<String, dynamic> user;

  @override
  List<Object> get props => [user];
}

class SuccessGetCurrentUserState extends AuthState {
  final Map<String, dynamic> user;

  SuccessGetCurrentUserState(
    this.user,
  );

  @override
  List<Object?> get props => [
        user,
      ];
}

class LoadingLogOutState extends AuthState {}

class SuccessLogOutState extends AuthState {}

class ErrorLogOutState extends AuthState {
  final String errorMessage;

  ErrorLogOutState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
