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

    on<UserLoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      emit(AuthenticationAutenticated(event.user));
    });

    on<ValidationEvent>((event, emit) async {
      emit(AuthenticationLoading());
      // Initiate SharedPreferences
      final prefs = await SharedPreferences.getInstance();
     
      // Get data from shared preferences
      String? accessToken = prefs.getString('access_token');
      String? refreshToken = prefs.getString('refresh_token');
      
      // Check if Access & Refresh Token is exists
      if (accessToken == null && refreshToken == null) {
        // Access & Refresh Token Not Found.
        emit(AuthenticationUnautenticated());
        return;
      } 
      
      // Validate AccessToken
      final validation = await authenticationRepository.checkToken(accessToken!);
      if (validation['success']) {
        emit(AuthenticationAutenticated(validation['user']));
        return;
      }

      // Access Token Invalid/Expire. Trying to refresh token
      final refresh = await authenticationRepository.refreshAccessToken(refreshToken!);
      if (refresh['success']) {
        prefs.remove("access_token");
        prefs.remove("refresh_token");
        prefs.setString('access_token', refresh['access_token']);
        prefs.setString('refresh_token', refresh['refresh_token']);
        emit(AuthenticationAutenticated(refresh['user']));
        return;
      }
      
      // Failed to Refresh Token. User Logged Out.
      prefs.remove("access_token");
      prefs.remove("refresh_token");
      prefs.remove("email");
      prefs.remove("password");
      emit(AuthenticationUnautenticated());
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
