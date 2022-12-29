import 'package:tcbike/model/product_color.dart';
import 'package:tcbike/model/product_image.dart';

class Product {
  late int id;
  late String name;
  late int categoryId;
  late String categoryName;
  late double price;
  late double offerPrice;
  late int quantity;
  late String description;
  late String status;
  late bool isOffer;
  late bool isFavorite;
  late List<ProductImage> images = [];
  late List<ProductColor> colors = [];

  // Product(
  //     {this.id,
  //     this.name,
  //     this.categoryId,
  //     this.categoryName,
  //     this.price,
  //     this.offerPrice,
  //     this.quantity,
  //     this.description,
  //     this.status,
  //     this.isOffer,
  //     this.images,
  //     this.colors});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    price = json['price'] / 1;
    offerPrice = json['offer_price'] / 1;
    quantity = json['quantity'];
    description = json['description'];
    status = json['status'];
    isOffer = json['is_offer'];
    isFavorite = json['isFavorite'];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        images.add(ProductImage.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      json['colors'].forEach((v) {
        colors.add(ProductColor.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['category_id'] = this.categoryId;
  //   data['category_name'] = this.categoryName;
  //   data['price'] = this.price;
  //   data['offer_price'] = this.offerPrice;
  //   data['quantity'] = this.quantity;
  //   data['description'] = this.description;
  //   data['status'] = this.status;
  //   data['is_offer'] = this.isOffer;
  //   if (this.images != null) {
  //     data['images'] = this.images!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.colors != null) {
  //     data['colors'] = this.colors!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

  @override
  String toString() {
    return '''
id = $id,
name = $name,
orderQuantity = $quantity,

''';
  }
}
