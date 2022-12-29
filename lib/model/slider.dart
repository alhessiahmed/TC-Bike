class Slider {
  late int id;
  late String title;
  // int? status;
  late String imageUrl;

  // Slider({this.id, this.title, this.status, this.imageUrl});

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    // status = json['status'];
    imageUrl = json['image_url'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['status'] = this.status;
  //   data['image_url'] = this.imageUrl;
  //   return data;
  // }
}
