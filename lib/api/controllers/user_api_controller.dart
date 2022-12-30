import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tcbike/api/api_helper.dart';
import 'package:tcbike/api/api_settings.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';

class UserApiController with ApiHelper {
  Future<ApiResponse> updateUserProfile({
    String? imgPath,
    required String name,
  }) async {
    Uri uri = Uri.parse(ApiSettings.updateProfile);
    var request = http.MultipartRequest('POST', uri);
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    if (imgPath != null) {
      var file = await http.MultipartFile.fromPath('icon_url', imgPath);
      request.files.add(file);
    }
    request.fields['name'] = name;
    request.fields['phone'] =
        SharedPrefController().getByKey(key: UserInfo.phone.name);
    // request.fields['_method'] = 'put';
    var response = await request.send();
    // print('---------------------${response.statusCode}---------------------');
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 422) {
      var body = await response.stream.transform(utf8.decoder).first;
      var jsonResponse = jsonDecode(body);
      // print(jsonResponse['data']['icon_url']);
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
        object: response.statusCode == 200
            ? jsonResponse['data']['icon_url']
            : null,
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Uri uri = Uri.parse(ApiSettings.changePassword);
    var response = await http.post(
      uri,
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
      headers: headers,
    );
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
}
