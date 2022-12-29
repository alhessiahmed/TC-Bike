import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcbike/core/constants/colors_manager.dart';

class HomesShimmer extends StatelessWidget {
  const HomesShimmer({
    Key? key,
    this.enabled = true,
  }) : super(key: key);

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: enabled,
      baseColor: ColorsManager.shimmerBaseColor,
      highlightColor: ColorsManager.shimmerHighlightColor,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16.r),
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: ColorsManager.shimmerBaseColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Padding(
                padding:
                    EdgeInsets.only(right: index == 0 ? 0 : 8.w, bottom: 10.h),
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.shimmerBaseColor,
                ),
              ),
            ),
          ),
          const _Section(),
          const _Section(),
          const _Section(),
          // GridView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: 6,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 16.h,
          //     crossAxisSpacing: 8.w,
          //     childAspectRatio: 167 / 174,
          //   ),
          //   itemBuilder: (context, index) => Container(
          //     decoration: BoxDecoration(
          //       color: ColorsManager.shimmerHighlightColor,
          //       borderRadius: BorderRadius.circular(12.r),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 20.h,
              width: 60.w,
              margin: EdgeInsets.only(right: 16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorsManager.shimmerBaseColor,
              ),
            ),
            Container(
              height: 16.h,
              width: 40.w,
              margin: EdgeInsets.only(left: 16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorsManager.shimmerBaseColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                height: 150.h,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: ColorsManager.shimmerBaseColor,
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
      ],
    );
  }
}
