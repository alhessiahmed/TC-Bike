import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/colors_manager.dart';

class ThemeManager {
  static ThemeData light() {
    return ThemeData(
      fontFamily: 'Almarai',
      colorScheme: const ColorScheme.light(primary: ColorsManager.primary),
      scaffoldBackgroundColor: ColorsManager.bgColor,
      appBarTheme: AppBarTheme(
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24.r),
          ),
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Almarai',
        ),
        elevation: 0,
        foregroundColor: ColorsManager.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Almarai',
        ),
        bodyText2: TextStyle(
          color: ColorsManager.textColor,
          fontSize: 14.sp,
          fontFamily: 'Almarai',
        ),
      ),
      // dialogBackgroundColor: Colors.orange,
      dividerColor: ColorsManager.dividerColor,
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontFamily: 'Almarai',
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Get.width, 56.h),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Almarai',
          ),
          foregroundColor: ColorsManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          fixedSize: Size(Get.width, 48.h),
          foregroundColor: ColorsManager.textColor,
          textStyle: const TextStyle(
            fontFamily: 'Almarai',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: const BorderSide(
              color: ColorsManager.outlineBorder,
            ),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorsManager.white,
        elevation: 0,
        // backgroundColor: ColorsManager.white,
        selectedLabelStyle: TextStyle(fontSize: 10.sp),
        unselectedLabelStyle: TextStyle(fontSize: 10.sp),
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: ColorsManager.disabled,
        showUnselectedLabels: true,
      ),
    );
  }
  // static ThemeData dark() {
  //   return ThemeData.dark().copyWith(
  //     scaffoldBackgroundColor: ColorsManager.scaffoldBg,
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         fixedSize: Size(Get.width, 100.h),
  //         textStyle: TextStyle(
  //           fontSize: 26.sp,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         backgroundColor: ColorsManager.purble,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(100.r),
  //         ),
  //       ),
  //     ),
  //     outlinedButtonTheme: OutlinedButtonThemeData(
  //       style: OutlinedButton.styleFrom(
  //         fixedSize: Size(Get.width / 4, 60.h),
  //         foregroundColor: ColorsManager.danger,
  //         side: const BorderSide(
  //           color: ColorsManager.danger,
  //           width: 2,
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(100.r),
  //         ),
  //       ),
  //     ),
  //     textButtonTheme: TextButtonThemeData(
  //       style: TextButton.styleFrom(
  //         textStyle: const TextStyle(
  //           // fontSize: 18.sp,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         foregroundColor: ColorsManager.white,
  //       ),
  //     ),
  //     appBarTheme: AppBarTheme(
  //       centerTitle: true,
  //       titleTextStyle: TextStyle(
  //         fontSize: 30.sp,
  //         fontWeight: FontWeight.w500,
  //         color: ColorsManager.white,
  //       ),
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //     ),
  //     textTheme: TextTheme(
  //       bodyText2: TextStyle(
  //         color: ColorsManager.white,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 28.sp,
  //       ),
  //     ),
  //   );
  // }
}
