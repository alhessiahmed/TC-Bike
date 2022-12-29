import 'package:tcbike/model/product.dart';

class ProductDetails {
  late Product product;
  late List<Product> recommendedProducts = [];

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    if (json['recommended'] != null) {
      json['recommended'].forEach((v) {
        recommendedProducts.add(Product.fromJson(v));
      });
    }
  }
}
