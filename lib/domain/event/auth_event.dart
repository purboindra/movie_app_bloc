import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GetCurrentUserEvent extends AuthEvent {
  GetCurrentUserEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AuthEvent {}
