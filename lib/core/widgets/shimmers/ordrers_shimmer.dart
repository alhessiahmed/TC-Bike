import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcbike/core/constants/colors_manager.dart';

class OrdersShimmer extends StatelessWidget {
  const OrdersShimmer({
    Key? key,
    this.isDetails = false,
  }) : super(key: key);

  final bool isDetails;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.shimmerBaseColor,
      highlightColor: ColorsManager.shimmerHighlightColor,
      child: ListView.builder(
        padding: EdgeInsets.all(20.r),
        itemCount: isDetails ? 1 : 5,
        itemBuilder: (context, index) => Container(
          height: isDetails ? 250.h : 120.h,
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: ColorsManager.shimmerHighlightColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
