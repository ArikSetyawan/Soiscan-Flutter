import 'package:dio/dio.dart';
import 'package:soiscan/Resources/token_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationResource {
  final Dio _dio = Dio();
  final String apiURL = dotenv.env['APIURL']!;

  // Login API
  Future<Response> loginUser(String email, String password) async {
    // Payload
    final data = {"Email":email,"Password":password};
    final Response response = await _dio.post("${apiURL}login",data: data);
    return response;
  }

  Future<Response> checkAccessToken(String accessToken) async {
    _dio.interceptors.addAll([
      TokenInterceptor(_dio)
    ]);
    // set Token
    _dio.options.headers['Token'] = accessToken;
    // Hit Request
    final Response response = await _dio.get("${apiURL}checkaccesstoken");
    return response;
  }

  Future<Response> signupUser(String name, String email, String password) async {
    // payload
    final Map<String,dynamic> payload = {
      "Name":name,
      "Email":email,
      "Password":password
    };

    // Hit Request
    final Response response = await _dio.post("${apiURL}registration", data: payload);
    return response;
  }
}
