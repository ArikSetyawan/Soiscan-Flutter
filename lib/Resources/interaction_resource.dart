import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soiscan/Resources/token_interceptor.dart';

class InteractionResource {
  final Dio _dio = Dio();
  final String _baseURL = dotenv.env['APIURL']!;
  Future<Response> getUserByUserID(String userID) async {
    final Response request = await _dio.get("${_baseURL}users", queryParameters: {"UserID":userID});
    return request;
  }

  Future<Response> interactWithOtherUser(String accessToken, int nik, double latitude, double longitude) async {
    _dio.interceptors.addAll([
      TokenInterceptor(_dio)
    ]);
    // set Token
    _dio.options.headers['Token'] = accessToken;

    // set Payload
    final Map<String,dynamic> payload = {
      "NIK":nik,
      "lat":latitude.toString(),
      "lng":longitude.toString()
    };

    final Response request = await _dio.post("${_baseURL}scan", data: payload);
    return request;
  }

  Future<Response> getInteractionsHistory(String accessToken) async {
    _dio.interceptors.addAll([
      TokenInterceptor(_dio)
    ]);
    
    // set Token
    _dio.options.headers['Token'] = accessToken;
    final Response request = await _dio.get("${_baseURL}interactions");
    return request;
  }
}