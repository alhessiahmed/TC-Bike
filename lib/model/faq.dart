class Faq {
  late int id;
  late String title;
  late String description;

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}
