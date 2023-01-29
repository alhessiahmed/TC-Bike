import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/constants_manager.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/shimmers/home_shimmer.dart';
import 'package:tcbike/getx/controllers/app/category_controller.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/images_manager.dart';
import '../../../core/widgets/product_card_widget.dart';
import '../../../core/widgets/section_bar_widget.dart';
import '../../../getx/controllers/app/home_controller.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.isTrue
          ? const HomesShimmer()
          : controller.homeModel == null
              ? const NoDataWidget()
              : ListView(
                  children: [
                    // SLIDER
                    SizedBox(
                      height: 177.h,
                      width: Get.width,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          controller.bannerIndex.value = index;
                        },
                        itemCount: controller.homeModel!.sliders.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 150.h,
                            margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: ImagesManager.placeholder,
                              image:
                                  controller.homeModel!.sliders[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      child: Center(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.homeModel!.sliders.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => CircleAvatar(
                                radius: index == controller.bannerIndex.value
                                    ? 5.r
                                    : 3.5.r,
                                backgroundColor: index ==
                                        controller.bannerIndex.value
                                    ? ColorsManager.primary
                                    : ColorsManager.primary.withOpacity(0.73),
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
                    // CATEGORIES
                    SectionBarWidget(
                      title: 'categories'.tr,
                      viewAll: true,
                      onTap: () {
                        controller.pageIndex(1);
                      },
                    ),
                    SizedBox(
                      height: 80.h,
                      child: ListView.separated(
                        // padding: EdgeInsets.zero,
                        padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.homeModel!.categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              controller.pageIndex(1);
                              CategoryController().catIndex(index + 1);
                              CategoryController().isLoading(true);
                              await CategoryController().readCategoryProducts(
                                  id: controller
                                      .homeModel!.categories[index].id);
                              CategoryController().isLoading(false);
                            },
                            child: Container(
                              // width: 80.w,
                              padding: EdgeInsets.zero,
                              // constraints: BoxConstraints(
                              //   minWidth: 80.w,
                              // ),
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: ColorsManager.disabled,
                                // image: DecorationImage(
                                //   image: NetworkImage(
                                //     controller
                                //         .homeModel!.categories[index].iconUrl,
                                //   ),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 80.w,
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: ImagesManager.placeholder,
                                      image: controller
                                          .homeModel!.categories[index].iconUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    controller
                                        .homeModel!.categories[index].name,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 5.w,
                          );
                        },
                      ),
                    ),
                    // OFFERS
                    SectionBarWidget(
                      title: 'offers'.tr,
                    ),
                    SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.homeModel!.offers.length,
                        itemBuilder: (context, index) {
                          final product = controller.homeModel!.offers[index];
                          return InkWell(
                            onTap: () {
                              controller.productId = product.id;
                              Get.toNamed(RoutesManager.productDetailsScreen);
                            },
                            child: ProductCard(
                              title: product.name,
                              subTitle: product.description,
                              price: product.offerPrice.toString(),
                              oldPrice: '${product.price} ',
                              specialOffer: true,
                              image: product.images.first.imageUrl,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8.w,
                          );
                        },
                      ),
                    ),
                    // MOST POPULAR
                    SectionBarWidget(
                      title: 'most_popular'.tr,
                    ),
                    SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.homeModel!.products.length,
                        itemBuilder: (context, index) {
                          final product = controller.homeModel!.products[index];
                          return InkWell(
                            onTap: () {
                              controller.productId = product.id;
                              log('++++++++');
                              log(controller.productId.toString());
                              Get.toNamed(RoutesManager.productDetailsScreen);
                            },
                            // onTap: () => Get.toNamed(
                            //   RoutesManager.productDetailsScreen,
                            // arguments: {
                            //   'id': controller.homeModel!.products[index].id,
                            // },
                            // ),
                            child: ProductCard(
                              title: product.name,
                              subTitle: product.description,
                              price: product.price.toString(),
                              image: product.images.first.imageUrl,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 8.w);
                        },
                      ),
                    ),
                    // MOST SPECIAL
                    controller.homeModel!.mostSoldProduct != null ? SectionBarWidget(
                      title: 'most_special'.tr,
                    ) : Container(),

                    controller.homeModel!.mostSoldProduct != null ? InkWell(
                      onTap: () {
                        controller.productId =
                            controller.homeModel!.mostSoldProduct!.id;
                        Get.toNamed(RoutesManager.productDetailsScreen);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: ConstantsManager.boxShadow,
                        ),
                        width: Get.width,
                        height: 185.h,
                        child: ProductCard(
                          title: controller.homeModel!.mostSoldProduct!.name,
                          subTitle:
                              controller.homeModel!.mostSoldProduct!.description,
                          price: controller.homeModel!.mostSoldProduct!.price
                              .toString(),
                          image: controller
                              .homeModel!.mostSoldProduct!.images.first.imageUrl,
                        ),
                      ),
                      // child: Container(
                      //   margin: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     color: ColorsManager.white,
                      //     borderRadius: BorderRadius.circular(12.r),
                      //     boxShadow: ConstantsManager.boxShadow,
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Image.asset(
                      //         ImagesManager.test[3],
                      //         fit: BoxFit.cover,
                      //         height: 126.h,
                      //         width: Get.width,
                      //       ),
                      //       ListTile(
                      //         title: Padding(
                      //           padding: EdgeInsets.only(bottom: 5.h),
                      //           child: Text(
                      //             controller.homeModel!.mostSoldProduct.name,
                      //             maxLines: 1,
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ),
                      //         // subtitle: Row(
                      //         //   children: [
                      //         //     SvgPicture.asset(ImagesManager.site),
                      //         //     SizedBox(width: 12.w),
                      //         //     Text(
                      //         //       '0 كم',
                      //         //       style: TextStyle(
                      //         //         fontSize: 12.sp,
                      //         //       ),
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //         // trailing: SizedBox(
                      //         //   width: 80.w,
                      //         //   child: Row(
                      //         //     mainAxisAlignment:
                      //         //         MainAxisAlignment.spaceBetween,
                      //         //     children: [
                      //         //       SvgPicture.asset(ImagesManager.clock),
                      //         //       Text(
                      //         //         '5 دقيقة',
                      //         //         style: TextStyle(
                      //         //           fontSize: 12.sp,
                      //         //         ),
                      //         //       ),
                      //         //     ],
                      //         //   ),
                      //         // ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ) : Container(),
                  ],
                ),
    );
  }
}
