import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/colors_manager.dart';

class TextStylesManager {
  static final TextStyle title = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle subTitle = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.subtitleColor,
  );
}
