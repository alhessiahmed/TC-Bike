import 'package:get/get.dart';
import 'package:tcbike/getx/controllers/app/favorite_controller.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }
}
