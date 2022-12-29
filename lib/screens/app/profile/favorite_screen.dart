import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/shimmers/categories_shimmer.dart';
import 'package:tcbike/getx/controllers/app/favorite_controller.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import '../../../core/widgets/product_card_widget.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('favorite'.tr)),
      body: Obx(
        () => controller.isLoading.value
            ? const CategoriesShimmer()
            : controller.products.isEmpty
                ? const NoDataWidget(message: 'لم يتم اضافة اي منتج للمفضلة')
                : GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    itemCount: controller.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          Get.toNamed(RoutesManager.productDetailsScreen);
                        },
                        child: ProductCard(
                          title: product.name,
                          subTitle: product.description,
                          price: product.offerPrice.toString(),
                          oldPrice: product.price.toString(),
                          specialOffer: product.isOffer,
                          image: product.images.first.imageUrl,
                          isFavorite: true,
                          deleteFavorite: () => controller.removeFromFavorite(
                              productId: product.id),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
