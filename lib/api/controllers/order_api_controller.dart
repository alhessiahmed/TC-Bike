import 'dart:convert';

import 'package:tcbike/api/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:tcbike/api/api_settings.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/model/order.dart';

class OrderApiController with ApiHelper {
  Future<List<Order>> readOrders() async {
    List<Order> orders = [];
    Uri uri = Uri.parse(ApiSettings.orders);
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dataList = jsonResponse['data'] as List;
      orders = dataList.map((e) => Order.fromJson(e)).toList();
    }
    return orders;
  }

  Future<ApiResponse> createOrder({
    required String subTotal,
    required String discount,
    required String total,
    required String paymentMethod,
    required List<Map<String, dynamic>> orderItems,
  }) async {
    Uri uri = Uri.parse(ApiSettings.createOrders);

    final response = await http.post(
      uri,
      headers: headers,
      body: {
        'sub_total': subTotal,
        'discount': discount,
        'total': total,
        'payment_method': paymentMethod,
        'order_item': jsonEncode(orderItems),
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ApiResponse(
        message: jsonResponse['message'],
        success: jsonResponse['success'],
      );
    }
    return failedResponse;
  }

  Future<Order?> orderDetails({required int orderId}) async {
    Uri uri = Uri.parse(ApiSettings.orderDetails);
    final response = await http.post(
      uri,
      headers: headers,
      body: {
        'order_id': '$orderId',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Order.fromJson(jsonResponse['data']);
    }
    return null;
  }
}
