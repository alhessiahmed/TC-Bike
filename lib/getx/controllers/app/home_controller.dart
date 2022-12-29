import 'dart:async';
import 'package:get/state_manager.dart';
import 'package:tcbike/api/controllers/home_api_controller.dart';

class HomeController extends GetxController {
  HomeController._();
  static HomeController? _instance;
  factory HomeController() {
    return _instance ??= HomeController._();
  }
  final pageIndex = 0.obs;
  final bannerIndex = 0.obs;
  // final catIndex = 0.obs;
  final isLoading = false.obs;
  final isLoggingOut = false.obs;

  // final StreamController<int> _streamController = StreamController();

  int? productId;
  HomeModel? homeModel;

  @override
  void onInit() async {
    // _streamController.add(pageIndex.value);
    // _streamController.stream.listen((event) {
    //   if (event == 2) {
    //     CartController().updateCartOrders();
    //   }
    // });
    isLoading(true);
    await readHomeData();
    isLoading(false);
    super.onInit();
  }

  Future<void> readHomeData() async {
    homeModel = await HomeApiController().read();
  }
}
