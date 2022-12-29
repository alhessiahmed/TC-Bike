import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
