import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Resources/authentication_resource.dart';
import 'package:soiscan/Repositories/dio_exception.dart';

class AuthenticationRepository{
  final _authenticationResource = AuthenticationResource();
  final Isar _isar = Isar.getInstance()!;

  Future<User> loginUser(String email, String password) async {
    try {
      final Response response = await _authenticationResource.loginUser(email, password);
      final Map<String, dynamic> data = response.data;
      final token = data['data']['Token'];
      final User user = User.fromJson(data['data']['User']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("access_token", token['access_token']);
      prefs.setString("refresh_token", token['refresh_token']);
      prefs.setString("email", user.email);
      prefs.setString("password", user.password);

      // insert user to Isar
      await _isar.writeTxn(() async {
        await _isar.users.put(user);
      });

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

    // Remove user from Isar
    await _isar.writeTxn(()async {
      await _isar.users.where().deleteAll();
    });
  }

  Future<User> getUser() async {
    User user = await _isar.users.where().findFirst() as User;
    return user;
  }

  Future<void> signupUser(String name, String email, String password) async {
    try{
      await _authenticationResource.signupUser(name, email, password);
    } on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    } catch (e) {
      throw(e.toString());
    }
  }

}