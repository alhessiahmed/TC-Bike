class OrderItem {
  late int id;
  late int productId;
  late String productName;
  late int price;
  late int quantity;
  late String imageUrl;

  // OrderItem(
  //     {this.id,
  //     this.productId,
  //     this.productName,
  //     this.price,
  //     this.quantity,
  //     this.imageUrl});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    imageUrl = json['image_url'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['product_id'] = this.productId;
  //   data['product_name'] = this.productName;
  //   data['price'] = this.price;
  //   data['quantity'] = this.quantity;
  //   data['image_url'] = this.imageUrl;
  //   return data;
  // }
}
