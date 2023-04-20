import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soiscan/Models/user_model.dart';
import 'package:soiscan/Resources/authentication_resource.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    
    final authenticationRepository = AuthenticationResource();
    
    on<LoginWithEmailPasswordEvent>((event, emit) async {
      emit(LoginLoading());
      try {

        // Hit API for login user
        final authentication = await authenticationRepository.loginUser(event.email, event.password);
        
        if (authentication['success'] == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("access_token", authentication['access_token']);
          prefs.setString("refresh_token", authentication['refresh_token']);
          prefs.setString("email", event.email);
          prefs.setString("password", event.password);
          emit(LoginSuccess(authentication["user"]));
          emit(LoginInitial());
        } else {
          emit(LoginFailure(authentication['message']));
        }

      } catch (error) {
        emit(LoginFailure(error.toString()));
      }
    });
  }
}
