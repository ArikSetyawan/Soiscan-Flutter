import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {

    final authRepository = AuthenticationRepository();

    on<UserLoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      emit(AuthenticationAutenticated(event.user));
    });

    on<ValidationEvent>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        final User authenticatedUser =  await authRepository.checkAccessToken();
        emit(AuthenticationAutenticated(authenticatedUser));
      } catch (e) {
        // Token Expired and Failed to Refresh Token. User Logged Out.
        await authRepository.logoutUser();
        emit(AuthenticationUnautenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthenticationLoading());
      // Remove Token from saved Shared Preferences
      await authRepository.logoutUser();
      emit(AuthenticationUnautenticated());
    });
  }
}
