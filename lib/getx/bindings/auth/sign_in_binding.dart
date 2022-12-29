import 'package:get/get.dart';
import '../../controllers/auth/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
