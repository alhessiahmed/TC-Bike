import 'package:get/get.dart';

import '../../controllers/app/sub_category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubCategoryController());
  }
}
