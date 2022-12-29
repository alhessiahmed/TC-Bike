import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/constants_manager.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';
import '../../core/constants/images_manager.dart';
import '../../core/routes/routes_manager.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        log('${SharedPrefController().loggedIn} -  ${SharedPrefController().rememberMe}  -  ${SharedPrefController().firstVisit}');
        Get.offNamed(
          SharedPrefController().loggedIn && SharedPrefController().rememberMe
              ? RoutesManager.homeScreen
              : SharedPrefController().firstVisit
                  ? RoutesManager.onboardingScreen
                  : RoutesManager.signInScreen,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstantsManager.introAppBar,
      body: Center(
        child: SvgPicture.asset(
          ImagesManager.logo,
          height: 124.h,
        ),
      ),
    );
  }
}
