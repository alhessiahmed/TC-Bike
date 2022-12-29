import 'package:get/get.dart';
import '../../controllers/auth/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
