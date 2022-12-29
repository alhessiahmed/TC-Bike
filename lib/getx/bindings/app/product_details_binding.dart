import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/product_details_controller.dart';

class ProductDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
