import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/auth/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
