import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/content_api_controller.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/model/product_details.dart';

class ProductDetailsController extends GetxController {
  final bannerIndex = 0.obs;
  final catIndex = 0.obs;
  final isLoading = false.obs;
  final orderQuantity = 1.obs;
  final isFavorite = false.obs;
  late int productId;
  ProductDetails? productDetails;

  @override
  void onInit() async {
    log('--------');
    log(HomeController().productId.toString());
    productId = HomeController().productId!;
    isLoading(true);
    await readProductDetails();
    isFavorite.value = productDetails?.product.isFavorite ?? false;
    isLoading(false);
    super.onInit();
  }

  Future<void> readProductDetails() async {
    productDetails =
        await ContentApiController().getProductDetails(id: productId);
  }

  Future<ApiResponse> toggleFavorite({required int id}) async {
    isFavorite.toggle();
    return await ContentApiController().toggleFavorite(productId: productId);
  }
}
