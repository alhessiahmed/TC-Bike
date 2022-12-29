import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tcbike/api/api_helper.dart';
import 'package:tcbike/api/api_settings.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/model/category.dart';
import 'package:tcbike/model/product.dart';
import 'package:tcbike/model/product_details.dart';

import '../../model/api_notification.dart';

class ContentApiController with ApiHelper {
  Future<List<ApiNotification>> readNotifications() async {
    List<ApiNotification> notifications = [];
    Uri uri = Uri.parse(ApiSettings.getNotifications);
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dataList = jsonResponse['data'] as List;
      for (var element in dataList) {
        ApiNotification not = ApiNotification();
        not.id = element['id'];
        not.time = element['time'];
        not.body = element['body'];
        not.data = element['data'];
        not.title = element['title'];
        notifications.add(not);
      }
    }
    return notifications;
  }

  Future<List<Category>> readCategories() async {
    List<Category> categories = [];
    Uri uri = Uri.parse(ApiSettings.categories);
    var response = await http.get(
      uri,
      headers: acceptHeader,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dataList = jsonResponse['data'] as List;
      categories = dataList.map((e) => Category.fromJson(e)).toList();
    }
    return categories;
  }

  Future<List<Product>> readProductsByCategory({required int id}) async {
    List<Product> products = [];
    Uri uri = Uri.parse(ApiSettings.categoryProducts);
    var response = await http.post(
      uri,
      headers: acceptHeader,
      body: {'category_id': id.toString()},
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dataList = jsonResponse['data'] as List;
      products = dataList.map((e) => Product.fromJson(e)).toList();
    }
    return products;
  }

  Future<ProductDetails?> getProductDetails({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.productDetails);
    var response = await http.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: {'product_id': '$id'},
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final jsonObject = jsonResponse['data'];
      return ProductDetails.fromJson(jsonObject);
    }
    return null;
  }

  Future<ApiResponse> toggleFavorite({required int productId}) async {
    Uri uri = Uri.parse(ApiSettings.toggleFavorite);
    var response = await http.post(
      uri,
      headers: headers,
      body: {'product_id': '$productId'},
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
      );
    }
    return failedResponse;
  }

  Future<List<Product>> readFavoriteProducts() async {
    List<Product> products = [];
    Uri uri = Uri.parse(ApiSettings.readFavorites);
    var response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dataList = jsonResponse['data'] as List;
      products = dataList.map((e) => Product.fromJson(e)).toList();
    }
    return products;
  }

  Future<List<Product>> searchProducts(String text) async {
    List<Product> products = [];
    Uri uri = Uri.parse(ApiSettings.categoryProducts);
    var response = await http.post(
      uri,
      headers: acceptHeader,
      body: {
        'category_id': '-1',
        'search_name': text,
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dataList = jsonResponse['data'] as List;
      products = dataList.map((e) => Product.fromJson(e)).toList();
    }
    return products;
  }
}
