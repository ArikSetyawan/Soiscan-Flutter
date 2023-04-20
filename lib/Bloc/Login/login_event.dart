part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailPasswordEvent(this.email, this.password);
  @override
  List<Object> get props => [email,password];
}
