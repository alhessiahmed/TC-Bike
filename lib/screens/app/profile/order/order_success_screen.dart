import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 56.h),
        child: Column(
          children: [
            Text(
              'order_success'.tr,
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            Image.asset(ImagesManager.orderSuccess),
            SizedBox(
              height: 26.h,
            ),
            Text(
              'congrats'.tr,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.success,
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Text(
              'operation_success'.tr,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 56.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: ElevatedButton(
                onPressed: () {
                  HomeController().pageIndex(0);
                  Get.offAllNamed(RoutesManager.homeScreen);
                },
                child: Text(
                  'back_to_home'.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
