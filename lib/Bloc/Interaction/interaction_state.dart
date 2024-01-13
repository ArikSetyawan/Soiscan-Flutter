part of 'interaction_bloc.dart';

sealed class InteractionState extends Equatable {
  const InteractionState();
  
  @override
  List<Object> get props => [];
}

class InteractionInitial extends InteractionState {}

class InteractionLoading extends InteractionState{}

class InteractionUserLoaded extends InteractionState{
  final User user;

  const InteractionUserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class InteractionCreated extends InteractionState{}

class InteractionError extends InteractionState{
  final String message;

  const InteractionError({required this.message});
  @override
  List<Object> get props => [message];
}
