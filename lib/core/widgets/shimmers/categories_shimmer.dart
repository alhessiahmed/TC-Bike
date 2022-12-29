import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcbike/core/constants/colors_manager.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({
    Key? key,
    this.isCategory = false,
    this.enabled = true,
  }) : super(key: key);

  final bool enabled;
  final bool isCategory;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: enabled,
      baseColor: ColorsManager.shimmerBaseColor,
      highlightColor: ColorsManager.shimmerHighlightColor,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Visibility(
              visible: isCategory,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Container(
                      height: 40.h,
                      width: 80.w,
                      margin: EdgeInsets.only(left: 8.w, bottom: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: ColorsManager.shimmerBaseColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 167 / 174,
                ),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.shimmerHighlightColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
