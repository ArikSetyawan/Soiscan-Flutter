import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soiscan/Models/user_model.dart';
import 'package:soiscan/Resources/authentication_resource.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    
    final authenticationRepository = AuthenticationResource();

    on<SignInEvent>((event, emit) async {
      try {
        emit(AuthenticationLoading());
        
        // Hit API for login user
        final authentication = await authenticationRepository.loginUser(event.email, event.password);
        
        if (authentication['success'] == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("access_token", authentication['access_token']);
          prefs.setString("refresh_token", authentication['refresh_token']);
          prefs.setString("email", event.email);
          prefs.setString("password", event.password);
          emit(AuthenticationAutenticated(authentication["user"]));
        } else {
          emit(AuthenticationFailed(authentication['message']));
        }
      } catch (error) {
        emit(AuthenticationError(error.toString()));
      }
    });

    on<ValidationEvent>((event, emit) async {
      emit(AuthenticationLoading());
      // Initiate SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      // Get data from shared preferences
      String? accessToken = prefs.getString('access_token');
      String? refreshToken = prefs.getString('refresh_token');
      
      if (accessToken == null && refreshToken == null) {
        emit(AuthenticationUnautenticated());
      } else {
        final validation = await authenticationRepository.checkToken(accessToken!);
        if (validation['success']) {
          emit(AuthenticationAutenticated(validation['user']));
        } else{
          // Trying to refresh token
          final refresh = await authenticationRepository.refreshAccessToken(refreshToken!);
          if (refresh['success']) {
            prefs.remove("access_token");
            prefs.remove("refresh_token");
            prefs.setString('access_token', refresh['access_token']);
            prefs.setString('refresh_token', refresh['refresh_token']);
            emit(AuthenticationAutenticated(refresh['user']));
          } else {
            prefs.remove("access_token");
            prefs.remove("refresh_token");
            prefs.remove("email");
            prefs.remove("password");
            emit(AuthenticationUnautenticated());
          }
        }
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("access_token");
      prefs.remove("refresh_token");
      prefs.remove("email");
      prefs.remove("password");
      emit(AuthenticationUnautenticated());
    });
  }
}
