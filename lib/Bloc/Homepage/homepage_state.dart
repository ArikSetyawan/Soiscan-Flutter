part of 'homepage_bloc.dart';

sealed class HomepageState extends Equatable {
  const HomepageState();
  
  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {
  final User user;

  const HomepageLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class HomepageError extends HomepageState {
  final String message;

  const HomepageError({required this.message});

  @override
  List<Object> get props => [message];
}