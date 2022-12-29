import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/content_api_controller.dart';
import 'package:tcbike/model/product.dart';

class FavoriteController extends GetxController {
  final isLoading = false.obs;
  final products = <Product>[].obs;

  @override
  void onInit() async {
    isLoading(true);
    await readFavorites();
    log(products.length.toString());

    isLoading(false);
    super.onInit();
  }

  Future<void> readFavorites() async {
    products.value = await ContentApiController().readFavoriteProducts();
  }

  Future<void> removeFromFavorite({required int productId}) async {
    final response =
        await ContentApiController().toggleFavorite(productId: productId);
    if (response.success) {
      products.removeWhere((element) => element.id == productId);
    }
  }
}
