import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/auth_api_controller.dart';
import 'package:tcbike/model/api_response.dart';

class ForgetPasswordController extends GetxController {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  Future<ApiResponse> forgetPassword() async {
    return await AuthApiController().resendCode(phone: phoneController.text);
  }
}
