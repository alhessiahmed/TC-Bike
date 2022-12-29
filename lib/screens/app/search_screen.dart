import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/shimmers/categories_shimmer.dart';
import 'package:tcbike/getx/controllers/app/search_controller.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/images_manager.dart';
import '../../core/routes/routes_manager.dart';
import '../../core/widgets/product_card_widget.dart';
import '../../getx/controllers/app/home_controller.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: controller.searchController.value,
                textInputAction: TextInputAction.search,
                autofocus: true,
                onChanged: (value) {
                  value.isNotEmpty
                      ? controller.empty(false)
                      : controller.empty(true);
                },
                onTap: () {
                  // controller.searchController.
                },
                onFieldSubmitted: (value) {
                  controller.search();
                },
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 24.h),
                  hintText: 'search'.tr,
                  hintStyle: TextStyle(
                    color: ColorsManager.subtitleColor,
                    fontSize: 16.sp,
                  ),
                  prefixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.search();
                        },
                        child: SvgPicture.asset(
                          ImagesManager.search,
                          color: ColorsManager.disabled,
                          // height: ,
                        ),
                      ),
                      const VerticalDivider(
                        color: ColorsManager.disabled,
                        thickness: 1,
                        width: 0,
                      ),
                    ],
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 40.h,
                    maxWidth: 60.w,
                    minWidth: 60.w,
                  ),
                  suffixIcon: controller.empty.value
                      ? null
                      : IconButton(
                          onPressed: () =>
                              controller.searchController.value.clear(),
                          icon: Icon(
                            Icons.close_rounded,
                            size: 28.r,
                            color: ColorsManager.disabled,
                          ),
                        ),
                  filled: true,
                  fillColor: ColorsManager.white,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                        const BorderSide(color: ColorsManager.outlineBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: ColorsManager.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                        const BorderSide(color: ColorsManager.outlineBorder),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Visibility(
                visible: !controller.isSearched.value,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'عمليات البحث الاخيرة',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          itemCount: controller.suggestionsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                controller.searchController.value.text =
                                    controller.suggestionsList[index];
                                controller.search();
                              },
                              child: Text(
                                controller.suggestionsList[index],
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10.h);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: controller.isSearched.value,
                  child: controller.isLoading.value
                      ? const CategoriesShimmer()
                      : controller.products.isEmpty
                          ? const NoDataWidget()
                          : GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 20.h),
                              itemCount: controller.products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 16.r,
                                mainAxisSpacing: 16.r,
                                crossAxisCount: 2,
                                // childAspectRatio: 167 / 174,
                                mainAxisExtent: 174.h,
                              ),
                              itemBuilder: (context, index) {
                                final product = controller.products[index];
                                return InkWell(
                                  onTap: () {
                                    HomeController().productId = product.id;
                                    Get.toNamed(
                                        RoutesManager.productDetailsScreen);
                                  },
                                  child: ProductCard(
                                    title: product.name,
                                    subTitle: product.description,
                                    price: product.offerPrice.toString(),
                                    oldPrice: product.price.toString(),
                                    specialOffer: product.isOffer,
                                    image: product.images.first.imageUrl,
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
