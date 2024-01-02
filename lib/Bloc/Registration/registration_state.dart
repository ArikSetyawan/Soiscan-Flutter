part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
  
  @override
  List<Object> get props => [];
}

final class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailed extends RegistrationState {
  final String message;

  const RegistrationFailed({required this.message});
  @override
  List<Object> get props => [message];
}