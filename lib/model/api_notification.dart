class ApiNotification {
  late String id;
  late String title;
  late String body;
  late String clickAction;
  late bool isRead;
  late String time;
  late int type;
  late int dateId;

  ApiNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    // clickAction = json['click_action'];
    // isRead = json['is_read'];
    time = json['time'];
    // type = json['type'];
    // dateId = json['date_id'];
  }
}
