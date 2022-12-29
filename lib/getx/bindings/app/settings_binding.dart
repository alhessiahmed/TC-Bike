import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
