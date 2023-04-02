// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:soiscan/Models/user_model.dart';

class AuthenticationResource {
  final Dio _dio = Dio();
  final String _loginUrl = "http://soiscan2.mastya.my.id/api/login/";
  final String _refreshTokenUrl = "http://soiscan2.mastya.my.id/api/refresh_token/";
  final String _validateAccessTokenUrl = "http://soiscan2.mastya.my.id/api/checkaccesstoken";
  // final String _validateRefreshTokenUrl = "http://soiscan2.mastya.my.id/api/checkrefreshtoken";

  // Login API
  Future loginUser(String email, String password) async {
    try {
      // Payload
      final data = {"Email":email,"Password":password};
      // Hit API
      Response response  = await _dio.post(_loginUrl,data: json.encode(data));
      // Check Response Body Status Code
      if (response.data['code'] == "400"){
        final result = {
          "success":false,
          "access_token":null,
          "refresh_token":null,
          "user":null,
          "message":response.data['message']
        };
        return result;
      }
      final token = response.data['data']['Token'];
      final user = UserModel.fromJson(response.data['data']['User']);
      final result = {
        "success":true,
        "access_token":token['access_token'],
        "refresh_token":token['refresh_token'],
        "user":user,
        "message":response.data['message']
      };
      return result;
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      final result = {
        "success":false,
        "access_token":null,
        "refresh_token":null,
        "user":null,
        "message":"Error"
      };
      return result;
    }
  }

  Future checkToken(String accessToken) async{
    try {
      // Set Token
      _dio.options.headers['Token'] = accessToken;
      // Hit Request
      Response response = await _dio.get(_validateAccessTokenUrl);
      if (response.data['code'] == "400") {
        final result = {
          "success":false,
          "user":null,
          "message":response.data['message']
        };
        return result;
      }
      final result = {
        "success":true,
        "user":UserModel.fromJson(response.data['data']['User']),
        "message":"Token Valid"
      };
      return result;
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      // check if error response exists
      if (error.response != null) {
        // check error statuscode
        if (error.response?.statusCode == 401) {
          // if statuscode 401 return Token invalid or expired
          final result = {
            "success":false,
            "user":null,
            "message":error.response?.data['message']
          };
          return result;
        } else {
          // if statuscode not 401 return something else
          final result = {
            "success":false,
            "user":null,
            "message":"Error something else"
          };
          return result;
        }
      } else {
        // if error response not exists 
        final result = {
          "success":false,
          "user":null,
          "message":"Error Check Your Internet Connection"
        };
        return result;
      }
    }
  }

  // Refresh Token
  Future refreshAccessToken(String refreshToken) async {
    try {
      // Set Token
      _dio.options.headers['Token'] = refreshToken;
      // Hit Request
      Response response = await _dio.get(_refreshTokenUrl);
      // Check if response data code is 400
      if (response.data['code'] == "400") {
        // return Token not included in header
        final result = {
          "success":false,
          "access_token":null,
          "refresh_token":null,
          "user":null,
          "message":response.data['message']
        };
        return result;
      }
      // Return Token
      final token = response.data['data']['Token'];
      final user = UserModel.fromJson(response.data['data']['User']);
      final result = {
        "success":true,
        "access_token":token['access_token'],
        "refresh_token":token['refresh_token'],
        "user":user,
        "message":response.data['message']
      };
      return result;
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      // check if error response exists
      if (error.response != null) {
        // check error statuscode
        if (error.response?.statusCode == 401) {
          // if statuscode 401 return Token invalid or expired
          final result = {
            "success":false,
            "access_token":null,
            "refresh_token":null,
            "user":null,
            "message":error.response?.data['message']
          };
          return result;
        } else {
          // if statuscode not 401 return something else
          final result = {
            "success":false,
            "access_token":null,
            "refresh_token":null,
            "user":null,
            "message":"Error something else"
          };
          return result;
        }
      } else {
        // if error response not exists 
        final result = {
          "success":false,
          "access_token":null,
          "refresh_token":null,
          "user":null,
          "message":"Error Check Your Internet Connection"
        };
        return result;
      }
    }
  }
}
