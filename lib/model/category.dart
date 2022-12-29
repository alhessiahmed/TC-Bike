class Category {
  late int id;
  late String name;
  late String iconUrl;

  Category({
    required this.id,
    required this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = json['icon_url'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['icon_url'] = this.iconUrl;
  //   return data;
  // }
}
