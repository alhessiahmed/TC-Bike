import 'package:get/get.dart';
import '../../controllers/app/cart_controller.dart';
import '../../controllers/app/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CartController());
  }
}
