part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);
  @override
  List<Object> get props => [email,password];
}

class LogoutEvent extends AuthenticationEvent {}

class ValidationEvent extends AuthenticationEvent {}
