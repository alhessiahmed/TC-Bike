import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/about_api_controller.dart';
import 'package:tcbike/model/api_response.dart';

class ContactController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final notesController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  Future<ApiResponse> sendTicket() async {
    return await AboutApiController().contactUs(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      message: notesController.text,
    );
  }
}
