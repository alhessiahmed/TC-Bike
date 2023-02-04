import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/product_card_widget.dart';
import 'package:tcbike/core/widgets/shimmers/categories_shimmer.dart';
import 'package:tcbike/getx/controllers/app/category_controller.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import '../../../core/routes/routes_manager.dart';

class CategoriesTab extends GetView<CategoryController> {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const CategoriesShimmer(isCategory: true)
          : controller.categories.isEmpty
              ? const NoDataWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 17.h, 16.w, 0),
                      child: Text('all_categories'.tr),
                    ),
                    Expanded(
                      child: controller.isLoading.value
                          ? const CategoriesShimmer()
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                              itemCount: controller.categories.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 9.r,
                                mainAxisSpacing: 11.r,
                                crossAxisCount: 3,
                                childAspectRatio: 108 / 80,
                                // mainAxisExtent: 195.h,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    /// TODO: FIX THIS
                                    Get.toNamed(
                                        RoutesManager.subCategoryScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: ImagesManager.placeholder,
                                      image:
                                          controller.categories[index].iconUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}
