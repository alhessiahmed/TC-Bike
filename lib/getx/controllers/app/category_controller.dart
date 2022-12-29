import 'dart:async';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/content_api_controller.dart';
import 'package:tcbike/model/category.dart';
import 'package:tcbike/model/product.dart';

class CategoryController extends GetxController {
  CategoryController._();
  static CategoryController? _instance;
  factory CategoryController() {
    return _instance ??= CategoryController._();
  }
  final catIndex = 0.obs;
  final isLoading = false.obs;
  final isProductsLoading = false.obs;
  final categories = <Category>[].obs;
  final products = <Product>[].obs;

  @override
  void onInit() async {
    isLoading(products.isEmpty);
    await readCategories();
    if (products.isEmpty) {
      await readCategoryProducts(id: -1);
    }
    isLoading(false);
    super.onInit();
  }

  Future<void> readCategories() async {
    categories.value = [
      Category(id: -1, name: 'الكل'),
    ];
    categories.addAll(await ContentApiController().readCategories());
  }

  Future<void> readCategoryProducts({required int id}) async {
    isProductsLoading(true);
    products.value =
        await ContentApiController().readProductsByCategory(id: id);
    isProductsLoading(false);
  }
}
