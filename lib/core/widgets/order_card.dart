import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/colors_manager.dart';

enum OrderStatus { complete, pending, acceptance, reject }

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.orderName,
    // required this.cityName,
    required this.totalPrice,
    required this.orderStatus,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String orderName;
  // final String cityName;
  final String totalPrice;
  final String orderStatus;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'order'.tr}  #$orderName'),
                      SizedBox(
                        height: 2.h,
                      ),
                      // Text(cityName, style: TextStylesManager.subTitle),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: orderStatus == OrderStatus.complete.name
                          ? ColorsManager.success
                          : orderStatus == OrderStatus.acceptance.name
                              ? ColorsManager.primary
                              : orderStatus == OrderStatus.pending.name
                                  ? ColorsManager.disabled
                                  : ColorsManager.danger,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: 80.w,
                      minWidth: 80.w,
                      // maxHeight: 32.h,
                      minHeight: 32.h,
                    ),
                    child: Text(
                      orderStatus == 'complete'
                          ? 'order_completed'.tr
                          : 'delievered'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                height: 20.h,
              ),
              Row(
                children: [
                  Text('total'.tr),
                  const Spacer(),
                  Text(
                    totalPrice,
                    style: const TextStyle(
                      color: ColorsManager.primary,
                    ),
                  ),
                  Text(
                    '₪',
                    style: TextStyle(
                      color: ColorsManager.primary,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
