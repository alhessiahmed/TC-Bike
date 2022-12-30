import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import 'package:tcbike/core/utils/view_logout_dialog.dart';
import 'package:tcbike/getx/controllers/app/home_controller.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';
import '../../../core/routes/routes_manager.dart';

class ProfileTab extends GetView<HomeController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      physics: const BouncingScrollPhysics(),
      // mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.max,
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(12.r),
        //   ),
        //   child: Row(
        //     children: [
        //       CircleAvatar(
        //         radius: 28.r,
        //         backgroundColor: ColorsManager.secondary,
        //         foregroundColor: ColorsManager.white,
        //         backgroundImage: (SharedPrefController()
        //                         .getByKey(key: UserInfo.image.name) !=
        //                     null &&
        //                 SharedPrefController()
        //                     .getByKey<String>(key: UserInfo.image.name)!
        //                     .isNotEmpty)
        //             ? NetworkImage(SharedPrefController()
        //                 .getByKey(key: UserInfo.image.name))
        //             : const AssetImage(ImagesManager.avatar) as ImageProvider,
        //         // child:
        //         //     SharedPrefController().getByKey(key: UserInfo.image.name) !=
        //         //             null
        //         //         ? Image.network(SharedPrefController()
        //         //             .getByKey(key: UserInfo.image.name))
        //         //         : Icon(
        //         //             Icons.person,
        //         //             size: 36.r,
        //         //           ),
        //       ),
        //       SizedBox(
        //         width: 16.w,
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             SharedPrefController()
        //                 .getByKey(key: UserInfo.name.name)
        //                 .toString(),
        //             style: const TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(height: 6.h),
        //           Text(
        //             SharedPrefController()
        //                 .getByKey(key: UserInfo.phone.name)
        //                 .toString(),
        //             style: const TextStyle(color: Color(0xFF9CA3AF)),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: ColorsManager.disabled,
                foregroundColor: ColorsManager.white,
                backgroundImage: (SharedPrefController()
                                .getByKey(key: UserInfo.image.name) !=
                            null &&
                        SharedPrefController()
                            .getByKey<String>(key: UserInfo.image.name)!
                            .isNotEmpty)
                    ? NetworkImage(SharedPrefController()
                        .getByKey(key: UserInfo.image.name))
                    : const AssetImage(ImagesManager.avatar) as ImageProvider,
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SharedPrefController()
                        .getByKey(key: UserInfo.name.name)
                        .toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    SharedPrefController().provider == 'phone'
                        ? SharedPrefController()
                            .getByKey(key: UserInfo.phone.name)
                            .toString()
                        : SharedPrefController()
                            .getByKey(key: UserInfo.email.name)
                            .toString(),
                    style: const TextStyle(color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              ProfileTile(
                iconName: 'ic_profile_filled',
                title: 'my_account'.tr,
                onTap: () {
                  Get.toNamed(RoutesManager.editProfileScreen);
                },
              ),
              const ProfileDivider(),
              ProfileTile(
                iconName: 'ic_orders',
                title: 'my_orders'.tr,
                onTap: () {
                  Get.toNamed(RoutesManager.orderScreen);
                },
              ),
              const ProfileDivider(),
              ProfileTile(
                iconName: 'ic_setting',
                title: 'settings'.tr,
                onTap: () {
                  Get.toNamed(RoutesManager.settingsScreen);
                },
              ),
              const ProfileDivider(),
              ProfileTile(
                iconName: 'ic_notifications',
                title: 'notifications'.tr,
                onTap: () {
                  Get.toNamed(RoutesManager.notificationsScreen);
                },
              ),
              const ProfileDivider(),
              ProfileTile(
                iconName: 'ic_favorite',
                title: 'favorite'.tr,
                onTap: () {
                  Get.toNamed(RoutesManager.favoriteScreen);
                },
              ),
              const ProfileDivider(),
              ProfileTile(
                iconName: 'ic_about',
                title: 'about_us'.tr,
                onTap: () {
                  Get.toNamed(RoutesManager.aboutUsScreen);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: ProfileTile(
            iconName: 'ic_sign_out',
            title: 'sign_out'.tr,
            titleColor: ColorsManager.pink,
            backgroundColor: const Color(0xFFFF4074).withOpacity(0.2),
            onTap: () {
              viewLogoutDialog(
                message: 'logout_message'.tr,
                context: context,
                onConfirm: () {
                  _performLogout();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _performLogout() async {
    controller.isLoggingOut(true);
    Get.back();
    await SharedPrefController().logout();
    await GoogleSignIn().disconnect().catchError((e) {});
    controller.isLoggingOut(false);
    Get.offAllNamed(RoutesManager.signInScreen);
    HomeController().pageIndex(0);
    showSnackbar(message: 'تم تسجيل الخروج بنجاح');
  }
}

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorsManager.dividerColor,
      thickness: 1,
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.iconName,
    required this.title,
    this.titleColor,
    required this.onTap,
    this.backgroundColor = const Color(0xFFF0F5FF),
    Key? key,
  }) : super(key: key);

  final String iconName;
  final String title;
  final Color? titleColor;
  final Color backgroundColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.r,
        backgroundColor: backgroundColor,
        child: SvgPicture.asset('assets/images/icons/$iconName.svg'),
      ),
      title: Text(title, style: TextStyle(color: titleColor)),
      trailing: iconName == 'ic_sign_out'
          ? null
          : Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 28.r,
              color: const Color(0xFF9CA3AF),
            ),
      onTap: onTap,
    );
  }
}
