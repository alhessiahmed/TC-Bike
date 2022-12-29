import 'package:get/get.dart';
import '../../controllers/auth/sign_up_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
