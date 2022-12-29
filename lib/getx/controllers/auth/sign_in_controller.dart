import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/auth_api_controller.dart';
import 'package:tcbike/model/api_response.dart';

class SignInController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final passwordVisible = false.obs;
  final isLoading = false.obs;
  final isIgnoring = false.obs;
  final rememberMe = false.obs;

  Future<ApiResponse> signIn() async {
    return await AuthApiController().login(
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
