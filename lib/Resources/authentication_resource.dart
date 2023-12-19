import 'package:dio/dio.dart';
import 'package:soiscan/Resources/token_interceptor.dart';

class AuthenticationResource {
  final Dio _dio = Dio();
  final String _loginUrl = "https://soiscan.mastya.my.id/api/login";
  final String _validateAccessTokenUrl = "https://soiscan.mastya.my.id/api/checkaccesstoken";

  // Login API
  Future<Response> loginUser(String email, String password) async {
    // Payload
    final data = {"Email":email,"Password":password};
    final Response response = await _dio.post(_loginUrl,data: data);
    return response;
  }

  Future<Response> checkAccessToken(String accessToken) async {
    _dio.interceptors.addAll([
      TokenInterceptor(_dio)
    ]);
    // set Token
    _dio.options.headers['Token'] = accessToken;
    // Hit Request
    final Response response = await _dio.get(_validateAccessTokenUrl);
    return response;
  }
}
