import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/colors_manager.dart';

class SectionBarWidget extends StatelessWidget {
  const SectionBarWidget({
    Key? key,
    required this.title,
    this.onTap,
    this.viewAll = false,
  }) : super(key: key);
  final String title;
  final bool viewAll;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Visibility(
            visible: viewAll,
            child: InkWell(
              onTap: onTap,
              child: Text(
                'view_all'.tr,
                style: TextStyle(
                  color: ColorsManager.primary,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
