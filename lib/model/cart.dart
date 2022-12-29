class Cart {
  late int id;
  late String name;
  late String imageUrl;
  late int orderQuantity;
  late int productQuantity;
  late double price;
  late double offerPrice;
  late int userId;
  late int productId;

  static const tableName = 'cart';

  Cart();

  Cart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    imageUrl = map['image_url'];
    orderQuantity = map['order_quantity'];
    productQuantity = map['product_quantity'];
    price = map['price'];
    offerPrice = map['offer_price'];
    userId = map['user_id'];
    productId = map['product_id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['order_quantity'] = orderQuantity;
    data['product_quantity'] = productQuantity;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['user_id'] = userId;
    data['product_id'] = productId;
    return data;
  }

  @override
  String toString() {
    return '''
id = $id,
name = $name,
orderQuantity = $orderQuantity,

''';
  }
}
