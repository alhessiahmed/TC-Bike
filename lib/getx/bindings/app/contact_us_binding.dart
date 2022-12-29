import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/contact_controller.dart';

class ContactUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactController());
  }
}
