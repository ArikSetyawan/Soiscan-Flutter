part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAutenticated extends AuthenticationState {
  final UserModel user;

  const AuthenticationAutenticated(this.user);
  @override
  List<Object> get props => [user];
}

class AuthenticationUnautenticated extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);
  @override
  List<Object> get props => [message];
}
