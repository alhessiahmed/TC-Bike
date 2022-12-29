import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/auth_api_controller.dart';
import 'package:tcbike/model/api_response.dart';

class VerificationController extends GetxController {
  final firstCodeTextController = TextEditingController();
  final secondCodeTextController = TextEditingController();
  final thirdCodeTextController = TextEditingController();
  final fourthCodeTextController = TextEditingController();

  final firstFocusNode = FocusNode();
  final secondFocusNode = FocusNode();
  final thirdFocusNode = FocusNode();
  final fourthFocusNode = FocusNode();

  final isloading = false.obs;
  final code = ''.obs;

  late Timer timer;
  final counter = 0.obs;

  void updateCode() {
    code.value = firstCodeTextController.text +
        secondCodeTextController.text +
        thirdCodeTextController.text +
        fourthCodeTextController.text;
  }

  void setTimer() {
    counter(90);
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (counter.value == 0) {
          timer.cancel();
        } else {
          counter.value--;
        }
      },
    );
  }

  Future<ApiResponse> resendCode({required String phone}) async {
    return await AuthApiController().resendCode(phone: phone);
  }

  Future<ApiResponse> verifyCode(
      {required String phone, required bool isSignUp}) async {
    return await AuthApiController().verify(
      phone: phone,
      code: code.value,
      isSignUp: isSignUp,
    );
  }

  @override
  void onInit() {
    setTimer();
    super.onInit();
  }
}
