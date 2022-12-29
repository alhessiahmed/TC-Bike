import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/colors_manager.dart';

class ConstantsManager {
  static final authAppBar = AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: ColorsManager.textColor,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
  );
  static final introAppBar = AppBar(
    toolbarHeight: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
  );
  static final boxShadow = [
    BoxShadow(
      color: ColorsManager.shadow,
      blurRadius: 4.r,
      offset: Offset(0, 2.h),
    ),
  ];
}
