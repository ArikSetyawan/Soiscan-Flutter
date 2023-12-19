import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Resources/authentication_resource.dart';
import 'package:soiscan/Repositories/dio_exception.dart';

class AuthenticationRepository{
  final _authenticationResource = AuthenticationResource();

  Future<User> loginUser(String email, String password) async {
    try {
      final Response response = await _authenticationResource.loginUser(email, password);
      final Map<String, dynamic> data = response.data;
      final token = data['data']['Token'];
      final user = User.fromJson(data['data']['User']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("access_token", token['access_token']);
      prefs.setString("refresh_token", token['refresh_token']);
      prefs.setString("email", user.email);
      prefs.setString("password", user.password);
      return user;
    }on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    } catch (e) {
      throw(e.toString());
    }
  }

  Future<User> checkAccessToken() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String accessToken = prefs.getString("access_token")!;
      final Response response = await _authenticationResource.checkAccessToken(accessToken);
      final Map<String,dynamic> data = response.data;
      final User user = User.fromJson(data['data']['User']);
      return user;
    } on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    } catch (e) {
      throw(e.toString());
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    prefs.remove("refresh_token");
    prefs.remove("email");
    prefs.remove("password");
  }

}