import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soiscan/Repositories/authentication_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  RegistrationBloc() : super(RegistrationInitial()) {
    on<UserSignup>((event, emit) async {
      emit(RegistrationLoading());
      try {
        await _authenticationRepository.signupUser(event.name, event.email, event.password);
        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailed(message: e.toString()));
      }
    });
  }
}
