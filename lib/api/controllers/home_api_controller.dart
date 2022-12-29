import 'dart:convert';

import 'package:tcbike/api/api_helper.dart';
import 'package:tcbike/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:tcbike/model/category.dart';
import 'package:tcbike/model/product.dart';
import 'package:tcbike/model/slider.dart';

class HomeApiController with ApiHelper {
  Future<HomeModel?> read() async {
    HomeModel homeModel = HomeModel();
    Uri uri = Uri.parse(ApiSettings.home);
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final data = jsonResponse['data'];

      final sliderArray = data['sliders'] as List;
      homeModel.sliders = sliderArray.map((e) => Slider.fromJson(e)).toList();

      final categoriesArray = data['categories'] as List;
      homeModel.categories =
          categoriesArray.map((e) => Category.fromJson(e)).toList();

      final offers = data['offers'] as List;
      homeModel.offers = offers.map((e) => Product.fromJson(e)).toList();

      final products = data['products'] as List;
      homeModel.products = products.map((e) => Product.fromJson(e)).toList();

      final mostSoldProduct = Product.fromJson(data['mostSoldProduct']);
      homeModel.mostSoldProduct = mostSoldProduct;

      return homeModel;
    }
    return null;
  }
}

class HomeModel {
  late List<Slider> sliders;
  late List<Category> categories;
  late List<Product> offers;
  late List<Product> products;
  late Product mostSoldProduct;
}
