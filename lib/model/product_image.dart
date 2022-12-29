class ProductImage {
  late int id;
  late int productId;
  late String imageUrl;
  late int status;

  // ProductImage({this.id, this.productId, this.imageUrl, this.status});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imageUrl = json['image_url'];
    status = json['status'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['product_id'] = this.productId;
  //   data['image_url'] = this.imageUrl;
  //   data['status'] = this.status;
  //   return data;
  // }
}
