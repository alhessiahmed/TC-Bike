import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/extensions/color_extension.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/shimmers/product_details_shimmer.dart';
import 'package:tcbike/database/controllers/cart_db_controller.dart';
import 'package:tcbike/getx/controllers/app/cart_controller.dart';
import 'package:tcbike/getx/controllers/app/product_details_controller.dart';
import 'package:tcbike/model/cart.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/images_manager.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(
        () => controller.isLoading.value
            ? const ProductDetailsShimmer()
            : controller.productDetails == null
                ? const NoDataWidget()
                : Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.4,
                        child: PageView.builder(
                          onPageChanged: (index) {
                            controller.bannerIndex.value = index;
                          },
                          itemCount:
                              controller.productDetails!.product.images.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              controller.productDetails!.product.images[index]
                                  .imageUrl,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: Get.height * 0.08,
                        child: InkWell(
                          onTap: () async {
                            final response = await controller.toggleFavorite(
                                id: controller.productId);
                            showSnackbar(
                              message: response.message,
                              success: response.success,
                            );
                          },
                          child: Container(
                            width: 38.r,
                            height: 38.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: controller.isFavorite.value
                                  ? ColorsManager.white
                                  : ColorsManager.secondary,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20.r,
                              color: controller.isFavorite.value
                                  ? ColorsManager.danger
                                  : ColorsManager.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: Get.height * 0.08,
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 38.r,
                            height: 38.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: const Color(0xFFF7F7F7),
                            ),
                            child: SvgPicture.asset(
                              ImagesManager.arrow,
                              height: 14.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.66,
                        child: Center(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller
                                .productDetails!.product.images.length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => CircleAvatar(
                                  radius: index == controller.bannerIndex.value
                                      ? 5.r
                                      : 3.5.r,
                                  backgroundColor: index ==
                                          controller.bannerIndex.value
                                      ? ColorsManager.white
                                      : ColorsManager.white.withOpacity(0.73),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: Get.height * 0.65,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.r),
                            ),
                            border: Border.all(
                              width: 2,
                              color: ColorsManager.white,
                              // strokeAlign: StrokeAlign.outside,
                            ),
                            color: ColorsManager.white,
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(16.w, 30.w, 16.w, 200),
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.productDetails!.product.name,
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                    const Spacer(),
                                    Visibility(
                                      visible: controller
                                              .productDetails!.product.price !=
                                          controller.productDetails!.product
                                              .offerPrice,
                                      child: Text(
                                        '${controller.productDetails!.product.price}',
                                        // textAlign: TextAlign.center,
                                        // textWidthBasis:
                                        //     TextWidthBasis.parent,
                                        // textScaleFactor: 1.2,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.disabled,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      controller
                                          .productDetails!.product.offerPrice
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.primary,
                                      ),
                                    ),
                                    Text(
                                      ' ₪',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: ColorsManager.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                const Text('اللون'),
                                SizedBox(height: 8.h),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      controller.productDetails!.product.colors
                                          .length,
                                      (index) => Padding(
                                        padding: EdgeInsets.only(left: 10.r),
                                        child: CircleAvatar(
                                          radius: 18.r,
                                          backgroundColor: controller
                                              .productDetails!
                                              .product
                                              .colors[index]
                                              .code
                                              .toColor(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                const Text('الوصف'),
                                SizedBox(height: 8.h),
                                Text(
                                  controller
                                      .productDetails!.product.description,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    height: 1.3,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                // SizedBox(
                                //   height: 38.h,
                                //   child: ListView.separated(
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 16.sp),
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: 5,
                                //     itemBuilder: (context, index) {
                                //       return InkWell(
                                //         onTap: () {
                                //           controller.catIndex(index);
                                //         },
                                //         child: Obx(
                                //           () => AnimatedContainer(
                                //             padding: EdgeInsets.symmetric(
                                //               horizontal: index ==
                                //                       controller
                                //                           .catIndex.value
                                //                   ? 16.w
                                //                   : 24.w,
                                //             ),
                                //             alignment: Alignment.center,
                                //             decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(12.r),
                                //               color: index ==
                                //                       controller
                                //                           .catIndex.value
                                //                   ? ColorsManager.secondary
                                //                   : const Color(0xFFF1F1F1),
                                //             ),
                                //             duration: const Duration(
                                //                 milliseconds: 300),
                                //             curve: Curves.fastOutSlowIn,
                                //             child: Text(
                                //               index == 0 ? 'الكل' : 'عجلات',
                                //               style: TextStyle(
                                //                 fontSize: 12.sp,
                                //                 fontWeight: FontWeight.bold,
                                //                 color: index ==
                                //                         controller
                                //                             .catIndex.value
                                //                     ? ColorsManager.white
                                //                     : null,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //     separatorBuilder: (context, index) {
                                //       return SizedBox(
                                //         width: 5.w,
                                //       );
                                //     },
                                //   ),
                                // ),
                                // SizedBox(height: 16.h),
                                Text(
                                  'منتجات موصى بها',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                SizedBox(height: 16.h),
                                ListView.separated(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.productDetails!
                                      .recommendedProducts.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {
                                      // final nav = Navigator.of(context);
                                      controller.productId = controller
                                          .productDetails!
                                          .recommendedProducts[index]
                                          .id;
                                      controller.isLoading(true);
                                      await controller.readProductDetails();
                                      controller.isLoading(false);
                                      // nav.pushReplacement(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const ProductDetailsScreen(),
                                      //   ),
                                      // );
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 67.r,
                                          height: 67.r,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            color: ColorsManager.secondary,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                controller
                                                    .productDetails!
                                                    .recommendedProducts[index]
                                                    .images
                                                    .first
                                                    .imageUrl,
                                              ),
                                              // AssetImage(
                                              //   ImagesManager.test[1],
                                              // ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.h),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // 'بدالات',
                                              controller
                                                  .productDetails!
                                                  .recommendedProducts[index]
                                                  .name,
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              // 'بدالات مميزة',
                                              controller
                                                  .productDetails!
                                                  .recommendedProducts[index]
                                                  .description,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(
                                                  0xFFA2A2A2,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              '${controller.productDetails!.recommendedProducts[index].price} ₪',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: ColorsManager.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            _performAddToCart(
                                                isRecommended: true,
                                                index: index);
                                          },
                                          iconSize: 30.r,
                                          color: ColorsManager.primary,
                                          icon: const Icon(
                                              Icons.add_circle_outline),
                                        ),
                                      ],
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => Divider(
                                    color: const Color(0xFFE2E2E2),
                                    thickness: 1,
                                    height: 20.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF6F6F6),
                                  foregroundColor: ColorsManager.textColor,
                                  shadowColor: ColorsManager.shadow2,
                                  elevation: 5,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (controller.orderQuantity.value <
                                            controller.productDetails!.product
                                                .quantity) {
                                          controller.orderQuantity(
                                              controller.orderQuantity.value +
                                                  1);
                                        }
                                      },
                                      icon: const Icon(Icons.add),
                                      color: ColorsManager.primary,
                                    ),
                                    Text(
                                      '${controller.orderQuantity.value}',
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (controller.orderQuantity.value >
                                            1) {
                                          controller.orderQuantity(
                                              controller.orderQuantity.value -
                                                  1);
                                        }
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              flex: 5,
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _performAddToCart();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: ColorsManager.shadow2,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Almarai',
                                      fontSize: 16.sp,
                                    ),
                                    elevation: 5,
                                  ),
                                  icon: Text(
                                      '₪ ${controller.productDetails!.product.offerPrice * controller.orderQuantity.value}'),
                                  label: const Text(' اضف الى السلة'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  void _performAddToCart({bool isRecommended = false, int index = 0}) async {
    if (await _checkOrderExist(isRecommended, index)) {
      showSnackbar(
          message: 'المنتج موجود بالسلة مسبقا', success: false, duration: 2);
    } else {
      await CartDbController().create(cart(isRecommended, index));
      await CartController().updateCartOrders();
      showSnackbar(message: 'تم إضافة المنتج للسلة بنجاح', duration: 2);
    }
    // CartDbController().clear();
  }

  Future<bool> _checkOrderExist(bool isRecommended, int index) async {
    final orders = await CartDbController().read();
    log(isRecommended.toString());
    final isRecommendedExists = orders
        .where((order) =>
            controller.productDetails!.recommendedProducts.where((product) {
              log(product.toString());
              // return order.productId == product.id;
              return order.productId ==
                  controller.productDetails!.recommendedProducts[index].id;
            }).isNotEmpty)
        .isNotEmpty;

    final isExists = orders
        .where(
            (order) => order.productId == controller.productDetails!.product.id)
        .isNotEmpty;
    log(isRecommended.toString());
    log(isRecommendedExists.toString());
    log(isExists.toString());
    return isRecommended ? isRecommendedExists : isExists;
  }

  Cart cart(bool isRecommended, int index) {
    final product = isRecommended
        ? controller.productDetails!.recommendedProducts[index]
        : controller.productDetails!.product;

    Cart cart = Cart();
    cart.name = product.name;
    cart.imageUrl = product.images[0].imageUrl;
    cart.productQuantity = product.quantity;
    cart.orderQuantity = isRecommended ? 1 : controller.orderQuantity.value;
    cart.price = product.price;
    cart.offerPrice = product.offerPrice;
    cart.productId = product.id;
    cart.userId = SharedPrefController().getByKey<int>(key: UserInfo.id.name)!;
    return cart;
  }
}
