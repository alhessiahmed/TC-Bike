import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/constants_manager.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/core/widgets/loading_widget.dart';
import 'package:tcbike/database/controllers/cart_db_controller.dart';
import 'package:tcbike/getx/controllers/app/cart_controller.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/images_manager.dart';

class CartTab extends GetView<CartController> {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.isTrue
          ? const LoadingWidget()
          : controller.cartOrders.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      SvgPicture.asset(ImagesManager.emptyCart),
                      const Spacer(flex: 3),
                      Text(
                        'السلة فارغة',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        'لا يوجد أي منتجات في سلة المشتريات',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () {
                          HomeController().pageIndex(0);
                        },
                        child: const Text('عودة الى الرئيسية'),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.h),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: Text(
                                          'تأكيد الطلب',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsManager.disabled,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 2.h,
                                      width: 30.w,
                                      color: ColorsManager.primary,
                                    ),
                                    Container(
                                      width: 40.r,
                                      height: 40.r,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: ColorsManager.primary
                                            .withOpacity(0.2),
                                      ),
                                      child: Container(
                                        width: 32.r,
                                        height: 32.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: ColorsManager.primary,
                                        ),
                                        child: SvgPicture.asset(
                                            ImagesManager.shop),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 2.h,
                                        width: 40,
                                        color: ColorsManager.disabled,
                                      ),
                                    ),
                                    Container(
                                      width: 32.r,
                                      height: 32.r,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: ColorsManager.disabled,
                                      ),
                                      child: SvgPicture.asset(
                                          ImagesManager.confirm),
                                    ),
                                    Container(
                                      height: 2.h,
                                      width: 32.w,
                                      color: ColorsManager.disabled,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.cartOrders.length,
                              itemBuilder: (context, index) {
                                final order = controller.cartOrders[index];
                                return Slidable(
                                  key: Key(index.toString()),
                                  closeOnScroll: true,
                                  startActionPane: ActionPane(
                                    extentRatio: 0.2,
                                    motion: InkWell(
                                      onTap: () async {
                                        final x = await CartDbController()
                                            .delete(controller
                                                .cartOrders[index].id);
                                        controller.cartOrders.removeAt(index);
                                        log(x.toString());
                                      },
                                      child: Container(
                                        width: 200,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(12.r)),
                                          gradient: const LinearGradient(
                                            colors: ColorsManager.pinkGradient,
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                            ImagesManager.delete),
                                      ),
                                    ),
                                    children: const [],
                                  ),
                                  child: InkWell(
                                    onLongPress: () {},
                                    child: Card(
                                      elevation: 8,
                                      shadowColor: ColorsManager.shadow,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      margin: EdgeInsets.zero,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 4.h),
                                        leading: Stack(
                                          alignment:
                                              const Alignment(-0.8, -0.8),
                                          children: [
                                            Container(
                                              width: 60.r,
                                              height: 60.r,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      order.imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: order.price !=
                                                  order.offerPrice,
                                              child: Icon(
                                                Icons.local_offer,
                                                color: ColorsManager.pink,
                                                size: 20.r,
                                              ),
                                            ),
                                          ],
                                        ),
                                        title: Text(order.name),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            text: '₪',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: ColorsManager.primary,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    order.offerPrice.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: Visibility(
                                                  visible: order.price !=
                                                      order.offerPrice,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w),
                                                    child: Text(
                                                        order.price.toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: ColorsManager
                                                              .disabled,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: SizedBox(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _performIncrement(index);
                                                },
                                                child: Container(
                                                  width: 24.r,
                                                  height: 24.r,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    color:
                                                        ColorsManager.primary,
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 18.r,
                                                    color: ColorsManager.white,
                                                  ),
                                                ),
                                              ),
                                              Obx(() => Text(controller
                                                  .orderQuantitites[index]
                                                  .toString())),
                                              InkWell(
                                                onTap: () {
                                                  _performDecrement(index);
                                                },
                                                child: Container(
                                                  width: 24.r,
                                                  height: 24.r,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    color:
                                                        const Color(0xFFF3F3F3),
                                                  ),
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 18.r,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 10.h),
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
                                  padding: EdgeInsets.fromLTRB(
                                      20.w, 6.h, 20.w, 16.h),
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
                                          '- ${controller.offerPrice.value}',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
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
                                          controller.totalPrice.value
                                              .toString(),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.adobtQuantities();
                          Get.toNamed(RoutesManager.paymentScreen);
                        },
                        child: const Text('التالي'),
                      ),
                    ),
                  ],
                ),
    );
  }

  void _performIncrement(int index) async {
    if (controller.orderQuantitites[index] <
        controller.cartOrders[index].productQuantity) {
      controller.orderQuantitites[index]++;
      controller.calculatePrices();
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) => Get.back());
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
    }
  }

  void _performDecrement(int index) {
    if (controller.orderQuantitites[index] > 1) {
      controller.orderQuantitites[index]--;
      controller.calculatePrices();
    }
  }
}

/*
Dismissible(
              key: Key(index.toString()),
              direction: DismissDirection.startToEnd,
              background: Container(
                width: 200,
                height: 200,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    colors: ColorsManager.pinkGradient,
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: SvgPicture.asset(ImagesManager.delete),
              ),

*/
