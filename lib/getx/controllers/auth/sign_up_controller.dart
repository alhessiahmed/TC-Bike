import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/auth_api_controller.dart';
import 'package:tcbike/model/api_response.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final passwordVisible = false.obs;
  final agreeConditions = false.obs;
  final isLoading = false.obs;
  final isIgnoring = false.obs;

  Future<ApiResponse> signUp() async {
    return await AuthApiController().register(
      name: nameController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );
  }
}
