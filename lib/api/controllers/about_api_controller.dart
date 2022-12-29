import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tcbike/api/api_settings.dart';
import 'package:tcbike/model/api_response.dart';
import '../api_helper.dart';

class AboutApiController with ApiHelper {
  Future<ApiResponse> contactUs({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    Uri uri = Uri.parse(ApiSettings.contactUs);
    final response = await http.post(
      uri,
      headers: headers,
      body: {
        'name': name,
        'email': email,
        'phone': phone,
        'message': message,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], success: jsonResponse['success']);
    }
    return failedResponse;
  }

  Future<AboutData?> readAboutData() async {
    AboutData data = AboutData();
    Uri uri = Uri.parse(ApiSettings.about);
    final response = await http.get(
      uri,
      headers: acceptHeader,
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      data.aboutUs = jsonResponse['data']['about_us'];
      data.privacyPolicy = jsonResponse['data']['privacy_policy'];
      data.helpCenter = jsonResponse['data']['help_center'];
      data.termsConditions = jsonResponse['data']['terms_conditions'];
      return data;
    }
    return null;
  }
}

class AboutData {
  late String aboutUs;
  late String privacyPolicy;
  late String helpCenter;
  late String termsConditions;
}
