import '../Resources/authentication_resource.dart';

class AuthentificationRepository {
  final _resource = AuthenticationResource();

  Future loginUser(String email, String password){
    return  _resource.loginUser(email, password);
  }

  Future checkToken(String accessToken) {
    return _resource.checkToken(accessToken);
  }

  Future refreshAccessToken(String refreshToken) {
    return _resource.refreshAccessToken(refreshToken);
  }
}
