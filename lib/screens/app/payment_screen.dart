import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import 'package:tcbike/getx/controllers/app/cart_controller.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import 'package:tcbike/getx/controllers/app/payment_controller.dart';

import '../../core/constants/colors_manager.dart';
import '../../core/constants/constants_manager.dart';
import '../../core/constants/images_manager.dart';
import '../../core/routes/routes_manager.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          'السلة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          'تأكيد الطلب',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        height: 2.h,
                        width: 32.w,
                        color: ColorsManager.primary,
                      ),
                      Container(
                        width: 32.r,
                        height: 32.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: ColorsManager.primary,
                        ),
                        child: SvgPicture.asset(ImagesManager.shop),
                      ),
                      Expanded(
                        child: Container(
                          height: 2.h,
                          width: 40,
                          color: ColorsManager.primary,
                        ),
                      ),
                      Container(
                        width: 40.r,
                        height: 40.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: ColorsManager.primary.withOpacity(0.2),
                        ),
                        child: Container(
                          width: 32.r,
                          height: 32.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: ColorsManager.primary,
                          ),
                          child: SvgPicture.asset(ImagesManager.confirm),
                        ),
                      ),
                      Container(
                        height: 2.h,
                        width: 30.w,
                        color: ColorsManager.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: ConstantsManager.boxShadow,
                color: ColorsManager.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Row(
                      children: [
                        Container(
                          height: 32.r,
                          width: 32.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: const Color(0xFFF1F1F1),
                          ),
                          child: SvgPicture.asset(
                            ImagesManager.confirm,
                            color: const Color(0xFF6F6F6F),
                            height: 14.h,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          'طريقة الدفع',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1,
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Row(
                      children: [
                        Stack(
                          alignment: const Alignment(-1.3, 0),
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: ColorsManager.white,
                                backgroundColor: ColorsManager.secondary,
                                fixedSize: Size(Get.width * 0.24, 44.h),
                              ),
                              icon: SvgPicture.asset(ImagesManager.cash),
                              label: const Text('نقدي'),
                            ),
                            CircleAvatar(
                              radius: 12.r,
                              backgroundColor: ColorsManager.white,
                              child: CircleAvatar(
                                radius: 10.r,
                                backgroundColor: ColorsManager.success,
                                foregroundColor: ColorsManager.white,
                                child: Icon(
                                  Icons.check,
                                  size: 14.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 24.w),
                        ElevatedButton(
                          onPressed: () {
                            Future.delayed(const Duration(seconds: 2))
                                .then((value) => Get.back());
                            Get.defaultDialog(
                              barrierDismissible: false,
                              title: 'نعتذر',
                              content: Row(
                                children: [
                                  const Text('وسيلة الدفع'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(ImagesManager.visa),
                                  ),
                                  const Text('غير متوفرة حالياً'),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF9F9FA),
                            foregroundColor: ColorsManager.disabled,
                            fixedSize: Size(Get.width * 0.24, 44.h),
                          ),
                          child: SvgPicture.asset(
                            ImagesManager.visa,
                            // color: ColorsManager.disabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: ConstantsManager.boxShadow,
                color: ColorsManager.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 16.h),
                    child: Text(
                      'ملخص الدفع',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFF6F6F6),
                    thickness: 1,
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'المجموع',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(controller.realPrice.toString()),
                          Text(
                            ' ₪',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'الكوبون',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorsManager.secondary,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '- ${controller.offerPrice.toString()}',
                            style: const TextStyle(
                              color: ColorsManager.secondary,
                            ),
                          ),
                          Text(
                            ' ₪',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.secondary,
                            ),
                          ),
                        ],
                      ),
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
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'المجموع',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.totalPrice.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ₪',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6F6F6),
                      foregroundColor: ColorsManager.primary,
                    ),
                    child: const Text('رجوع'),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final response = await controller.createOrder();
                      if (response.success) {
                        CartController().clearCart();
                        HomeController().pageIndex(0);
                        Get.offNamedUntil(RoutesManager.orderSuccessScreen,
                            (route) => route.isFirst);
                      } else {
                        showSnackbar(message: response.message, success: false);
                      }
                    },
                    child: const Text('تأكيد الطلب'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
