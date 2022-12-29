import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
