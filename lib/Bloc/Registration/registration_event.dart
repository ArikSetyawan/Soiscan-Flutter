part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class UserSignup extends RegistrationEvent {
  final String name;
  final String email;
  final String password;

  const UserSignup({required this.name, required this.email, required this.password});
  @override
  List<Object> get props => [name, email, password];
}