import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final String _refreshTokenUrl = "https://soiscan.mastya.my.id/api/refresh_token";

  TokenInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String newAccessToken = await refreshAccessToken();
      
      // Update Access Token in Header with new Access Token
      err.requestOptions.headers['Token'] = newAccessToken;

      // Repeat the request with updated Access Token
      return handler.resolve(await _dio.fetch(err.requestOptions));
    }
    return handler.next(err);
  }

  Future<String> refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String refreshToken = prefs.getString("refresh_token")!;
    // Make Request for new Access Token
    var request = http.Request('GET',Uri.parse(_refreshTokenUrl));
    request.headers['Token'] = refreshToken;
    
    // Response
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200){
      final data = jsonDecode(await response.stream.bytesToString());
      final token = data['data']['Token'];
      prefs.setString("access_token", token['access_token']);
      prefs.setString("refresh_token", token['refresh_token']);
      return token['access_token'];
    }
    return 'oke';
  }
}