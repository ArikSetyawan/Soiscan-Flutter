part of 'interaction_bloc.dart';

sealed class InteractionEvent extends Equatable {
  const InteractionEvent();

  @override
  List<Object> get props => [];
}

class GetInteractedUser extends InteractionEvent{
  final String userID;

  const GetInteractedUser({required this.userID});
  @override
  List<Object> get props => [userID];
}

class InteractWithOtherUser extends InteractionEvent{
  final int nik;
  final double latitude;
  final double longitude;

  const InteractWithOtherUser({required this.nik, required this.latitude, required this.longitude});

  @override
  List<Object> get props => [nik, latitude, longitude];
}