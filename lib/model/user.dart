class User {
  late int id;
  late String name;
  late String phone;
  late String password;
  String? imageUrl;
  late String token;
  String? fcmToken;
  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    imageUrl = json['icon_url'];
    token = json['token'];
  }
}
