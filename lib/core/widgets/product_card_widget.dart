import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/constants_manager.dart';
import '../constants/colors_manager.dart';
import '../constants/images_manager.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.specialOffer = false,
    this.forCategories = false,
    this.isFavorite = false,
    required this.title,
    required this.subTitle,
    required this.price,
    this.oldPrice = '',
    required this.image,
    this.imageHeight,
    this.deleteFavorite,
  }) : super(key: key);
  final bool specialOffer;
  final bool forCategories;
  final bool isFavorite;
  final String title;
  final String subTitle;
  final String price;
  final String oldPrice;
  final String image;
  final double? imageHeight;
  final Function()? deleteFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 145.w,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: ConstantsManager.boxShadow,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              FadeInImage.assetNetwork(
                placeholder: ImagesManager.placeholder,
                image: image,
                fit: BoxFit.fill,
                height: imageHeight ?? (forCategories ? 138.h : 120.h),
                width: Get.width,
              ),
              // Image.network(
              //   image,
              //   fit: BoxFit.cover,
              //   height: imageHeight ?? (forCategories ? 138.h : 120.h),
              //   width: Get.width,
              // ),
              Visibility(
                visible: isFavorite,
                child: Positioned(
                  top: 10.r,
                  right: 10.r,
                  child: InkWell(
                    onTap: deleteFavorite,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: ColorsManager.pink,
                      foregroundColor: ColorsManager.white,
                      child: Icon(
                        Icons.favorite,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: specialOffer,
                child: Container(
                  height: 27.h,
                  width: forCategories ? 80.w : 64.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorsManager.danger,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(12.r)),
                  ),
                  child: Text(
                    'special_offer'.tr,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: forCategories ? 15.sp : 14.sp,
                            fontFamily: 'Almarai',
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Visibility(
                        visible: specialOffer,
                        child: Text(
                          oldPrice,
                          style: TextStyle(
                            // fontSize: 9.sp,
                            fontSize: forCategories ? 10.sp : 9.sp,
                            color: const Color(0xFFA0A0A0),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          // fontSize: 11.sp,
                          fontSize: forCategories ? 12.sp : 11.sp,
                          color: ColorsManager.primary,
                        ),
                      ),
                      Text(
                        '₪',
                        style: TextStyle(
                          // fontSize: 8.sp,
                          fontSize: forCategories ? 9.sp : 8.sp,
                          color: ColorsManager.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      // fontSize: 10.sp,
                      fontSize: forCategories ? 11.sp : 10.sp,
                      height: 1.4,
                      color: const Color(0xFFA0A0A0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
