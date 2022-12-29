import 'package:tcbike/model/order_item.dart';

class Order {
  late int id;
  late int userId;
  late int subTotal;
  late int discount;
  late int total;
  late String storeStatusName;
  late String storeStatus;
  late String paymentMethod;
  late List<OrderItem> orderItems = [];
  late String orderDate;

  // Order(
  //     {this.id,
  //     this.userId,
  //     this.subTotal,
  //     this.discount,
  //     this.total,
  //     this.storeStatusName,
  //     this.storeStatus,
  //     this.paymentMethod,
  //     this.orderItem,
  //     this.orderDate});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    total = json['total'];
    storeStatusName = json['store_status_name'];
    storeStatus = json['store_status'];
    paymentMethod = json['payment_method'];
    if (json['order_item'] != null) {
      json['order_item'].forEach((v) {
        orderItems.add(OrderItem.fromJson(v));
      });
    }
    orderDate = json['order_date'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['user_id'] = this.userId;
  //   data['sub_total'] = this.subTotal;
  //   data['discount'] = this.discount;
  //   data['total'] = this.total;
  //   data['store_status_name'] = this.storeStatusName;
  //   data['store_status'] = this.storeStatus;
  //   data['payment_method'] = this.paymentMethod;
  //   if (this.orderItem != null) {
  //     data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
  //   }
  //   data['order_date'] = this.orderDate;
  //   return data;
  // }
}
