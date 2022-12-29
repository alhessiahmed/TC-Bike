import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

import '../../../api/controllers/user_api_controller.dart';
import '../../../model/api_response.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final oldPasswordVisible = false.obs;
  final newPasswordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<ApiResponse> changePassword() async {
    return await UserApiController().changePassword(
      oldPassword: oldPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );
  }
}
