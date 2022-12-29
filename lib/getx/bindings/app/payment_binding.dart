import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/payment_controller.dart';

class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}
