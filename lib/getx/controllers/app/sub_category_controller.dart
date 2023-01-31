import 'dart:async';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/content_api_controller.dart';
import 'package:tcbike/model/product.dart';

class SubCategoryController extends GetxController {
  SubCategoryController._();
  static SubCategoryController? _instance;
  factory SubCategoryController() {
    return _instance ??= SubCategoryController._();
  }
  final catIndex = 0.obs;
  final isLoading = false.obs;
  final isProductsLoading = false.obs;
  // final subCategories = <SubCategory>[].obs;
  final products = <Product>[].obs;

  @override
  void onInit() async {
    isLoading(products.isEmpty);
    // await readSubCategories();
    if (products.isEmpty) {
      // await readCategoryProducts(id: -1);
    }
    isLoading(false);
    super.onInit();
  }

  // Future<void> readCategories() async {
  //   subCategories.value = [
  //     SubCategory(id: -1, name: 'الكل'),
  //   ];
  //   SubCategories.addAll(await ContentApiController().readSubCategories());
  // }

  Future<void> readSubCategoryProducts({required int id}) async {
    isProductsLoading(true);
    products.value =
        await ContentApiController().readProductsByCategory(id: id);
    isProductsLoading(false);
  }
}
