import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/api/controllers/order_api_controller.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/shimmers/ordrers_shimmer.dart';
import 'package:tcbike/model/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({required this.id, super.key});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('order_details'.tr),
      ),
      body: FutureBuilder<Order?>(
        future: OrderApiController().orderDetails(orderId: id),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const OrdersShimmer(isDetails: true)
              : !snapshot.hasData
                  ? const NoDataWidget()
                  : Column(
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 20.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20.r),
                                child: Row(
                                  children: [
                                    Text(
                                      "${'order_number'.tr}  : ",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      '${snapshot.data!.id}',
                                      style: const TextStyle(
                                        color: ColorsManager.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 0,
                              ),
                              // Padding(
                              //   padding:
                              //       EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
                              //   child: Row(
                              //     children: [
                              //       Text('total'.tr),
                              //       const Spacer(),
                              //       const Text('20.00'),
                              //       Text(
                              //         ' ₪',
                              //         style: TextStyle(
                              //           color: ColorsManager.secondary,
                              //           fontSize: 10.sp,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // const Divider(
                              //   thickness: 1,
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 13.h, horizontal: 16.w),
                                child: Row(
                                  children: [
                                    Text(
                                      'total'.tr,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    const Spacer(),
                                    Text('${snapshot.data!.total}'),
                                    Text(
                                      ' ₪',
                                      style: TextStyle(
                                        color: ColorsManager.secondary,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 13.h, horizontal: 16.w),
                                child: Row(
                                  children: [
                                    Text(
                                      'coupon'.tr,
                                      style: TextStyle(
                                        color: ColorsManager.secondary,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '- ${snapshot.data!.discount}',
                                      style: const TextStyle(
                                        color: ColorsManager.secondary,
                                      ),
                                    ),
                                    Text(
                                      ' ₪',
                                      style: TextStyle(
                                        color: ColorsManager.secondary,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .',
                                  maxLines: 1,
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12.sp,
                                    color: ColorsManager.disabled,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.r),
                                child: Row(
                                  children: [
                                    Text(
                                      'total'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${snapshot.data!.subTotal}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      ' ₪',
                                      style: TextStyle(
                                        color: ColorsManager.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}
