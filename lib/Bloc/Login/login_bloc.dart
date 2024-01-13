import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    
    // final authenticationRepository = AuthenticationResource();
    final authRepository = AuthenticationRepository();
    
    on<LoginWithEmailPasswordEvent>((event, emit) async {
      emit(LoginLoading());
      try {

        // Hit API for login user
        // final authentication = await authenticationRepository.loginUser(event.email, event.password);
        final User user = await authRepository.loginUser(event.email, event.password);
        emit(LoginSuccess(user));
        emit(LoginInitial());
      } catch (error) {
        emit(LoginFailure(error.toString()));
      }
    });
  }
}
