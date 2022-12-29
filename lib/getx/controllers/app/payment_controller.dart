import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/order_api_controller.dart';
import 'package:tcbike/getx/controllers/app/cart_controller.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/model/cart.dart';

class PaymentController extends GetxController {
  static final _controller = CartController();
  final realPrice = _controller.realPrice.value;
  final offerPrice = _controller.offerPrice.value;
  final totalPrice = _controller.totalPrice.value;
  final isLoading = false.obs;

  List<Map<String, dynamic>> getOrderItems() {
    List<Map<String, dynamic>> map = [];
    for (Cart cartOrder in _controller.cartOrders) {
      map.add(
        {
          'product_id': cartOrder.productId,
          'product_name': cartOrder.name,
          'quantity': cartOrder.orderQuantity,
          'price': cartOrder.offerPrice,
        },
      );
    }
    return map;
  }

  Future<ApiResponse> createOrder() async {
    isLoading(true);
    final response = await OrderApiController().createOrder(
      subTotal: '$totalPrice',
      discount: '$offerPrice',
      total: '$realPrice',
      paymentMethod: 'cod',
      orderItems: getOrderItems(),
    );
    isLoading(false);
    return response;
  }
}
