import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soiscan/Models/user_interaction.dart';
import 'package:soiscan/Repositories/interaction_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final InteractionRepository _interactionRepository = InteractionRepository();
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistory>((event, emit) async {
      emit(HistoryLoading());
      try {
        // Get User Interactions History from repository
        final List<UserInteraction> interactions = await _interactionRepository.getInteractionsHistory();
        emit(HistoryLoaded(interactions: interactions));
      } catch (e) {
        emit(HistoryError(message: e.toString()));
      }
    });
  }
}
