part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
  
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<UserInteraction> interactions;

  const HistoryLoaded({required this.interactions});
  @override
  List<Object> get props => [interactions];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError({required this.message});
  @override
  List<Object> get props => [message];
}