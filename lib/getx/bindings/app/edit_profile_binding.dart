import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/edit_profile_controller.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
