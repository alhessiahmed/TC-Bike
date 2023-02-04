import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/core/widgets/product_card_widget.dart';
import 'package:tcbike/core/widgets/shimmers/categories_shimmer.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import 'package:tcbike/getx/controllers/app/sub_category_controller.dart';
import '../../../core/routes/routes_manager.dart';

class SubCategoriesScreen extends GetView<SubCategoryController> {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('العجلات'),
      ),

//     body: Obx(
//       () => controller.isLoading.value
//           ? const CategoriesShimmer(isCategory: true)
//           : controller.subCategories.isEmpty
//               ? const NoDataWidget()
//               : Column(
//                   children: [
//                     SizedBox(
//                       height: 74.h,
//                       child: ListView.separated(
//                         padding:
//                             EdgeInsets.fromLTRB(16.sp, 20.sp, 16.sp, 16.sp),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: controller.subCategories.length,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () async {
//                               controller.catIndex(index);
//                               await controller.readCategoryProducts(
//                                   id: controller.subCategories[index].id,);
//                             },
//                             child: Obx(
//                               () => AnimatedContainer(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: index == controller.catIndex.value
//                                       ? 16.w
//                                       : 24.w,
//                                 ),
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                   color: index == controller.catIndex.value
//                                       ? ColorsManager.secondary
//                                       : const Color(0xFFF1F1F1),
//                                 ),
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.fastOutSlowIn,
//                                 child: Text(
//                                   // index == 0 ? 'الكل' : 'عجلات',
//                                   controller.subCategories[index].name,
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: index == controller.catIndex.value
//                                         ? ColorsManager.white
//                                         : null,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return SizedBox(
//                             width: 5.w,
//                           );
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: controller.isProductsLoading.value
//                           ? const CategoriesShimmer()
//                           : GridView.builder(
//                               physics: const BouncingScrollPhysics(),
//                               padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
//                               itemCount: controller.products.length,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisSpacing: 10.r,
//                                 mainAxisSpacing: 20.r,
//                                 crossAxisCount: 2,
//                                 // childAspectRatio: 167 / 174,
//                                 mainAxisExtent: 195.h,
//                               ),
//                               itemBuilder: (context, index) {
//                                 final product = controller.products[index];
//                                 return InkWell(
//                                   onTap: () {
//                                     HomeController().productId = product.id;
//                                     Get.toNamed(
//                                         RoutesManager.productDetailsScreen);
//                                   },
//                                   child: ProductCard(
//                                     title: product.name,
//                                     subTitle: product.description,
//                                     oldPrice: product.price.toString(),
//                                     price: product.offerPrice.toString(),
//                                     image: product.images.first.imageUrl,
//                                     specialOffer: product.isOffer,
//                                     forCategories: true,
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ],
//                 ),
//     )
    );
  }
}
