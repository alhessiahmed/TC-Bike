import 'package:get/get.dart';
import '../../controllers/auth/verification_controller.dart';

class VerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController());
  }
}
