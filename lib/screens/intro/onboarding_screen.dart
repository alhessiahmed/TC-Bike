import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/constants_manager.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/routes/routes_manager.dart';
import '../../core/constants/images_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: ConstantsManager.introAppBar,
      body: SafeArea(
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          itemCount: 2,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Visibility(
                      visible: index == 1,
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: IconButton(
                          onPressed: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            );
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        ImagesManager.logo,
                        height: 62.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                SvgPicture.asset(
                  index == 0
                      ? ImagesManager.onboarding1
                      : ImagesManager.onboarding2,
                  height: 300.h,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  height: 140.h,
                  child: Column(
                    children: [
                      Text(
                        index == 0
                            ? 'boarding1_title'.tr
                            : 'boarding2_title'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        index == 0 ? 'boarding1_info'.tr : 'boarding2_info'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorsManager.textColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (index == 0) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Get.toNamed(RoutesManager.signUpScreen);
                    }
                  },
                  child: Text(index == 0 ? 'next'.tr : 'start_now'.tr),
                ),
                SizedBox(
                  height: 16.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutesManager.signInScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.buttonBg,
                    foregroundColor: ColorsManager.primary,
                  ),
                  child: Text('sign_in'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
