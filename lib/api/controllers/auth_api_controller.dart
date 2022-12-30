import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tcbike/api/api_helper.dart';
import 'package:tcbike/api/api_settings.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/model/user.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> register({
    required String name,
    required String phone,
    required String password,
  }) async {
    Uri uri = Uri.parse(ApiSettings.register);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    // log('uri: $uri');
    var response = await http.post(
      uri,
      body: {
        'name': name,
        'phone': '972$phone',
        'password': password,
        'password_confirmation': password,
        'fcm': fcmToken,
      },
      headers: languageHeaders,
    );
    log('response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> login({
    required String phone,
    required String password,
  }) async {
    Uri uri = Uri.parse(ApiSettings.login);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var response = await http.post(
      uri,
      body: {
        'phone': '972$phone',
        'password': password,
        'fcm': fcmToken,
      },
      headers: languageHeaders,
    );
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data'] != null) {
        var jsonObject = jsonResponse['data'];
        User user = User.fromJson(jsonObject);
        user.id = jsonObject['id'];
        await SharedPrefController().saveUser(user: user);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> verify({
    required String phone,
    required String code,
    required bool isSignUp,
  }) async {
    Uri uri = Uri.parse(ApiSettings.verify);
    var response = await http.post(
      uri,
      headers: languageHeaders,
      body: {
        'phone': '972$phone',
        'code': code,
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && isSignUp) {
        var jsonObject = jsonResponse['data'];
        User user = User.fromJson(jsonObject);
        user.id = jsonObject['id'];
        await SharedPrefController().saveUser(user: user);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> resendCode({
    required String phone,
  }) async {
    Uri uri = Uri.parse(ApiSettings.resendCode);
    var response = await http.post(
      uri,
      headers: languageHeaders,
      body: {
        'phone': '972$phone',
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
        // object: jsonResponse['code'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> resetPassword({
    required String phone,
    required String code,
    required String password,
  }) async {
    Uri uri = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(uri, body: {
      'phone': '972$phone',
      'code': code,
      'new_password': password,
      'new_password_confirmation': password,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);

      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse?> signInWithGoogle() async {
    try {
      final isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      GoogleSignInAccount? googleUser;
      if (isInternetConnected) {
        googleUser = await GoogleSignIn().signIn();
      } else {
        return ApiResponse(message: 'لا يوجد إتصال إنترنت', success: false);
      }

      if (googleUser != null) {
        Uri uri = Uri.parse(ApiSettings.googleLogin);
        // log('000');
        final response = await http.post(
          uri,
          headers: languageHeaders,
          body: {
            'google_id': googleUser.id,
            'name': googleUser.displayName,
            'email': googleUser.email,
            'avatar': googleUser.photoUrl.toString(),
          },
        );
        if (response.statusCode == 200 ||
            response.statusCode == 400 ||
            response.statusCode == 422) {
          var jsonResponse = jsonDecode(response.body);
          final jsonObject = jsonResponse['data'];
          User user = User();
          user.id = jsonObject['id'];
          user.name = jsonObject['name'] ?? 'google user';
          user.imageUrl = jsonObject['icon_url'];
          user.phone = jsonObject['phone'] ?? '';
          user.token = jsonObject['token'];
          log(user.toString());
          await SharedPrefController().saveUser(
            user: user,
            provider: Providers.google.name,
            email: googleUser.email,
          );
          await SharedPrefController().setRememberMeStatus(true);
          return ApiResponse(
            message: jsonResponse['message'],
            success: jsonResponse['success'],
          );
        }
        return failedResponse;
      }
      return null;
    } catch (e) {
      return ApiResponse(message: e.toString(), success: false);
    }
  }
}
