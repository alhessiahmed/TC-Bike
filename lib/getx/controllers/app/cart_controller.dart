import 'package:get/state_manager.dart';
import 'package:tcbike/model/cart.dart';
import '../../../database/controllers/cart_db_controller.dart';

class CartController extends GetxController {
  static CartController? _instance;
  CartController._();
  factory CartController() {
    return _instance ??= CartController._();
  }
  late RxList<Cart> cartOrders = <Cart>[].obs;
  final orderQuantitites = <int>[].obs;
  final realPrice = 0.0.obs;
  final offerPrice = 0.0.obs;
  final totalPrice = 0.0.obs;
  final isLoading = false.obs;

  static final _cartDbController = CartDbController();

  @override
  void onInit() async {
    isLoading(true);
    await updateCartOrders();
    isLoading(false);
    super.onInit();
  }

  Future<void> updateCartOrders() async {
    cartOrders.value = await _cartDbController.read();
    // cartOrders.every(
    //   (element) {
    //     log(element.toString());
    //     return true;
    //   },
    // );
    realPrice(0);
    offerPrice(0);
    orderQuantitites.value = [];
    for (Cart order in cartOrders) {
      orderQuantitites.add(order.orderQuantity);
      realPrice.value += order.price * order.orderQuantity;
      offerPrice.value +=
          (order.price - order.offerPrice) * order.orderQuantity;
      // log('------------');
      // log(order.toString());
    }
    // log(orderQuantitites.toString());
    calculateTotalPrice();
  }

  void clearCart() async {
    await CartDbController().clear();
    cartOrders.value = [];
  }

  void calculatePrices() {
    realPrice(0);
    offerPrice(0);
    for (int i = 0; i < cartOrders.length; i++) {
      offerPrice.value += (cartOrders[i].price - cartOrders[i].offerPrice) *
          orderQuantitites[i];
      realPrice.value += cartOrders[i].price * orderQuantitites[i];
    }
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice(realPrice.value - offerPrice.value);
  }

  void adobtQuantities() {
    for (var i = 0; i < cartOrders.length; i++) {
      cartOrders[i].orderQuantity = orderQuantitites[i];
      _cartDbController.update(cartOrders[i]);
    }
  }
}
