import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/constants_manager.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('support_center'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: ConstantsManager.boxShadow,
              ),
              child: ExpansionTile(
                collapsedBackgroundColor: ColorsManager.white,
                backgroundColor: ColorsManager.secondary,
                textColor: ColorsManager.white,
                iconColor: ColorsManager.white,
                title: Text(
                  'who_are_we'.tr,
                ),
                tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                childrenPadding: EdgeInsets.zero,
                initiallyExpanded: false,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.h, 20.h),
                      color: ColorsManager.white,
                      child: Text('fill'.tr)),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: ConstantsManager.boxShadow,
              ),
              child: ExpansionTile(
                collapsedBackgroundColor: ColorsManager.white,
                backgroundColor: ColorsManager.secondary,
                textColor: ColorsManager.white,
                iconColor: ColorsManager.white,
                title: Text(
                  'what_we_do'.tr,
                ),
                tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                childrenPadding: EdgeInsets.zero,
                initiallyExpanded: false,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.h, 20.h),
                      color: ColorsManager.white,
                      child: Text('fill'.tr)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
