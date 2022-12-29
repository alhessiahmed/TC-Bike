import 'dart:io';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';

mixin ApiHelper {
  ApiResponse get failedResponse => ApiResponse(
        message: 'Something went wrong!! try again later.',
        success: false,
      );

  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  Map<String, String> get languageHeaders {
    return {
      'Accept': 'application/json',
      'Accept-Language': SharedPrefController().lang,
    };
  }

  Map<String, String> get acceptHeader {
    return {
      'Accept': 'application/json',
    };
  }
}
