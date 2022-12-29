import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/screens/app/tabs/cart_tab.dart';
import 'package:tcbike/screens/app/tabs/categories_tab.dart';
import 'package:tcbike/screens/app/tabs/home_tab.dart';
import 'package:tcbike/screens/app/tabs/profile_tab.dart';
import '../../core/widgets/loading_widget.dart';
import '../../getx/controllers/app/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static final List<Widget> _listScreens = [
    const HomeTab(),
    const CategoriesTab(),
    const CartTab(),
    const ProfileTab(),
  ];
  static final List<String> _listTitles = [
    'home'.tr,
    'categories'.tr,
    'cart'.tr,
    'profile'.tr,
  ];

  Future<bool> _onWillPop(BuildContext context) async {
    if (controller.pageIndex.value != 0) {
      controller.pageIndex.value = 0;
      return false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: ColorsManager.bgColor,
              titlePadding: EdgeInsets.fromLTRB(20.w, 40.h, 30.w, 10.h),
              actionsPadding: EdgeInsets.fromLTRB(20.w, 0.h, 30.w, 10.h),
              contentPadding: EdgeInsets.fromLTRB(20.w, 0.h, 40.w, 60.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: Get.width),
                  Text('are_you_sure'.tr),
                  Divider(
                    thickness: 1,
                    color: ColorsManager.dividerColor,
                    endIndent: 70.w,
                    height: 32.h,
                  ),
                ],
              ),
              content: Text('exit_the_app'.tr),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false), //<-- SEE HERE
                  child: Text(
                    'no'.tr,
                    style: TextStyle(
                      color: ColorsManager.success,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true), // <-- SEE HERE
                  child: Text(
                    'yes'.tr,
                    style: TextStyle(
                      color: ColorsManager.danger,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          return await _onWillPop(context);
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(_listTitles[controller.pageIndex.value]),
                leadingWidth: 88.w,
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  child: InkWell(
                      onTap: () {
                        controller.pageIndex(0);
                      },
                      child: SvgPicture.asset(ImagesManager.icLogo)),
                ),
                actions: [
                  Visibility(
                    visible: controller.pageIndex.value <= 1,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(RoutesManager.searchScreen);
                      },
                      icon: SvgPicture.asset(ImagesManager.search),
                    ),
                  ),
                ],
              ),
              body: _listScreens[controller.pageIndex.value],
              bottomNavigationBar: Container(
                height: 80.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.shadow,
                      blurRadius: 4.r,
                      offset: Offset(0, -1.h),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: controller.pageIndex.value,
                  onTap: (value) => controller.pageIndex.value = value,
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset(
                          controller.pageIndex.value == 0
                              ? ImagesManager.homeFilled
                              : ImagesManager.home,
                          color: controller.pageIndex.value == 0
                              ? ColorsManager.primary
                              : ColorsManager.disabled,
                        ),
                      ),
                      label: 'home'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset(
                          controller.pageIndex.value == 1
                              ? ImagesManager.categoriesFilled
                              : ImagesManager.categories,
                          color: controller.pageIndex.value == 1
                              ? ColorsManager.primary
                              : ColorsManager.disabled,
                        ),
                      ),
                      label: 'categories'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset(
                          controller.pageIndex.value == 2
                              ? ImagesManager.cartFilled
                              : ImagesManager.cart,
                          color: controller.pageIndex.value == 2
                              ? ColorsManager.primary
                              : ColorsManager.disabled,
                        ),
                      ),
                      label: 'cart'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset(
                          controller.pageIndex.value == 3
                              ? ImagesManager.profileFilled
                              : ImagesManager.profile,
                          color: controller.pageIndex.value == 3
                              ? ColorsManager.primary
                              : ColorsManager.disabled,
                        ),
                      ),
                      label: 'profile'.tr,
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isLoggingOut.value,
                child: const LoadingWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
