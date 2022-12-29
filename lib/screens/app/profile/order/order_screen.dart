import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/api/controllers/order_api_controller.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/shimmers/ordrers_shimmer.dart';
import 'package:tcbike/model/order.dart';
import '../../../../core/widgets/order_card.dart';
import 'order_details_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_orders'.tr),
      ),
      body: FutureBuilder<List<Order>>(
        future: OrderApiController().readOrders(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const OrdersShimmer()
              : !snapshot.hasData ||
                      (snapshot.hasData && snapshot.data!.isEmpty)
                  ? const NoDataWidget()
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return OrderCard(
                          onTap: () {
                            Get.to(
                              () => OrderDetailsScreen(
                                  id: snapshot.data![index].id),
                            );
                          },
                          orderName: '${snapshot.data![index].id}',
                          // cityName: 'غزة',
                          totalPrice: '${snapshot.data![index].subTotal}',
                          orderStatus: snapshot.data![index].storeStatus,
                        );
                      },
                    );
        },
      ),
    );
  }
}
