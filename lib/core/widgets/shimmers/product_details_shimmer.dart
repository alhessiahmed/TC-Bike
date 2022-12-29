import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcbike/core/constants/colors_manager.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.shimmerBaseColor,
      highlightColor: ColorsManager.shimmerHighlightColor,
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: Get.height * 0.08,
            child: Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorsManager.shimmerBaseColor,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: Get.height * 0.08,
            child: Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorsManager.shimmerBaseColor,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      right: index == 0 ? 0 : 8.w, bottom: 10.h),
                  child: CircleAvatar(
                    radius: 5.r,
                    backgroundColor: ColorsManager.shimmerBaseColor,
                  ),
                ),
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
                color: ColorsManager.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
