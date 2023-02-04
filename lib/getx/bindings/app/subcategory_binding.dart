import 'package:get/get.dart';

import '../../controllers/app/sub_category_controller.dart';

class SubCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubCategoryController());
  }
}
