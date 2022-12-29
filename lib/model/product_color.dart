class ProductColor {
  late int id;
  late String name;
  late String code;

  // ProductColor({this.id, this.name, this.code});

  ProductColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['code'] = this.code;
  //   return data;
  // }
}
