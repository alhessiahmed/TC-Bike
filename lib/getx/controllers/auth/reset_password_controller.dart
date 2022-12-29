import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/auth_api_controller.dart';
import 'package:tcbike/model/api_response.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final newPasswordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<ApiResponse> resetPassword({
    required String phone,
    required String code,
  }) async {
    return await AuthApiController().resetPassword(
      phone: phone,
      code: code,
      password: newPasswordController.text.trim(),
    );
  }
}
