import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';

import '../../../api/controllers/content_api_controller.dart';
import '../../../model/product.dart';

class SearchController extends GetxController {
  final searchController = TextEditingController().obs;
  final empty = true.obs;
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final isSearched = false.obs;
  List<String> suggestionsList = [];

  Future<void> search() async {
    isSearched(true);
    isLoading.toggle();
    addSuggestion();
    products.value = await ContentApiController()
        .searchProducts(searchController.value.text);
    isLoading.toggle();
  }

  @override
  void onInit() {
    readSuggesions();
    super.onInit();
  }

  void readSuggesions() {
    suggestionsList = SharedPrefController().readLatestSearchList();
  }

  void addSuggestion() async {
    await SharedPrefController()
        .addToLatestSearchList(searchController.value.text);
  }
}
