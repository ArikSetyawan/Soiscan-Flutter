part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends AuthenticationEvent {
  final User user;

  const UserLoginEvent(this.user);
  @override
  List<Object> get props => [user];
}

class LogoutEvent extends AuthenticationEvent {}

class ValidationEvent extends AuthenticationEvent {}
