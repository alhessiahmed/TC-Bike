import 'dart:async';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/content_api_controller.dart';
import 'package:tcbike/model/category.dart';
import 'package:tcbike/model/product.dart';

class SubCategoryController extends GetxController {
  SubCategoryController._();
  static SubCategoryController? _instance;
  factory SubCategoryController() {
    return _instance ??= SubCategoryController._();
  }
  RxInt categoryID = 0.obs;
  RxString categoryName = ''.obs;
  final catIndex = 0.obs;
  final isLoading = false.obs;
  final isProductsLoading = false.obs;
  final subCategories = <Category>[].obs;
  final products = <Product>[].obs;

  // @override
  // void dispose() {
  //   catIndex(0);
  //   super.dispose();
  // }

  // @override
  // void onInit() async {
  //   isLoading(products.isEmpty);
  //   await readSubCategories();
  //   if (products.isEmpty && subCategories.isNotEmpty) {
  //     await readSubCategoryProducts(id: subCategories[0].id);
  //   }
  //   isLoading(false);
  //   super.onInit();
  // }

  Future<void> readSubCategories() async {
    // subCategories.value = [
    //   Category(id: -1, name: 'الكل'),
    // ];
    // subCategories.addAll(await ContentApiController().readSubCategories());
    subCategories.value = await ContentApiController()
        .readSubCategories(categoryId: categoryID.value);
  }

  Future<void> readSubCategoryProducts({required int id}) async {
    isProductsLoading(true);
    products.value =
        await ContentApiController().readProductsByCategory(id: id);
    isProductsLoading(false);
  }
}
