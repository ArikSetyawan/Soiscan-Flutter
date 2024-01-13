import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Repositories/interaction_repository.dart';

part 'interaction_event.dart';
part 'interaction_state.dart';

class InteractionBloc extends Bloc<InteractionEvent, InteractionState> {
  final InteractionRepository _interactionRepository = InteractionRepository();
  InteractionBloc() : super(InteractionInitial()) {
    on<GetInteractedUser>((event, emit) async {
      emit(InteractionLoading());
      try {
        // Get InteractedUser
        final User interactedUser = await _interactionRepository.getInteractedUser(event.userID);
        emit(InteractionUserLoaded(user: interactedUser));
      } catch (e) {
        emit(InteractionError(message: e.toString()));
      }
    });

    on<InteractWithOtherUser>((event, emit) async {
      emit(InteractionLoading());
      try {
        // Get InteractedUser
        await _interactionRepository.interactWithOtherUser(event.nik, event.latitude, event.longitude);
        emit(InteractionCreated());
      } catch (e) {
        emit(InteractionError(message: e.toString()));
      }
    });
  }
}
