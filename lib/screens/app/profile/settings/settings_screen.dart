import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/getx/controllers/app/settings_controller.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgColor,
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w, bottom: 12.h),
              child: Text(
                'general'.tr,
                style: const TextStyle(color: Color(0xFF9EA3AE)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      // Get.lazyPut(() => SettingsController());
                      log(Get.deviceLocale.toString().substring(0, 2));
                      log(SharedPrefController().lang);

                      Get.defaultDialog(
                        title: 'change_language'.tr,
                        contentPadding: EdgeInsets.zero,
                        titlePadding: EdgeInsets.symmetric(vertical: 20.r),
                        backgroundColor: ColorsManager.white,
                        content: SizedBox(
                          width: Get.width,
                          child: Obx(
                            () => Column(
                              children: [
                                const Divider(
                                  thickness: 1,
                                  height: 0,
                                ),
                                SizedBox(height: 10.h),
                                // RadioListTile(
                                //   title: Text('arabic'.tr),
                                //   secondary: Icon(
                                //     Icons.check,
                                //     size: 16.r,
                                //   ),
                                //   value: 'ar',
                                //   groupValue: 'ar',
                                //   onChanged: (value) {},
                                // ),
                                InkWell(
                                  onTap: () {
                                    controller.isArabic(true);
                                    SharedPrefController().saveLang(lang: 'ar');
                                  },
                                  child: ListTile(
                                    title: const Text('العربية'),
                                    // minVerticalPadding: 0,
                                    trailing: controller.isArabic.value
                                        ? CircleAvatar(
                                            radius: 10.r,
                                            backgroundColor:
                                                ColorsManager.secondary,
                                            foregroundColor:
                                                ColorsManager.white,
                                            child: Icon(
                                              Icons.check,
                                              size: 14.r,
                                            ),
                                          )
                                        : Container(
                                            height: 20.r,
                                            width: 20.r,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      ColorsManager.disabled),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  height: 20.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.isArabic(false);
                                    SharedPrefController().saveLang(lang: 'en');
                                  },
                                  child: ListTile(
                                    title: const Text('עִברִית'),
                                    // minVerticalPadding: 0,
                                    trailing: !controller.isArabic.value
                                        ? CircleAvatar(
                                            radius: 10.r,
                                            backgroundColor:
                                                ColorsManager.secondary,
                                            foregroundColor:
                                                ColorsManager.white,
                                            child: Icon(
                                              Icons.check,
                                              size: 14.r,
                                            ),
                                          )
                                        : Container(
                                            height: 20.r,
                                            width: 20.r,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      ColorsManager.disabled),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).then(
                        (value) => Get.updateLocale(
                          controller.isArabic.value
                              ? const Locale('ar')
                              : const Locale('he'),
                        ),
                      );
                    },
                    title: Text('language'.tr),
                    trailing: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            SharedPrefController().lang == 'ar'
                                ? 'العربية'
                                : 'עִברִית',
                            style: const TextStyle(color: Color(0xFF9EA3AE)),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xFF9EA3AE),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: ColorsManager.dividerColor,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text('notifications'.tr),
                    ),
                    subtitle: Text(
                      'activate_notifications_please'.tr,
                      style: const TextStyle(color: Color(0xFF9EA3AE)),
                    ),
                    trailing: Obx(() => CupertinoSwitch(
                          activeColor: ColorsManager.secondary,
                          value: controller.enableNotifications.value,
                          onChanged: (checked) {
                            controller.enableNotifications.toggle();
                          },
                        )),
                  ),
                  const Divider(
                    color: ColorsManager.dividerColor,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('privacy_policy'.tr),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF9EA3AE),
                    ),
                    onTap: () => Get.toNamed(RoutesManager.privacyPolicyScreen),
                  ),
                  const Divider(
                    color: ColorsManager.dividerColor,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('contact_us'.tr),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF9EA3AE),
                    ),
                    onTap: () => Get.toNamed(RoutesManager.contactUsScreen),
                  ),
                  const Divider(
                    color: ColorsManager.dividerColor,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('support_center'.tr),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF9EA3AE),
                    ),
                    onTap: () => Get.toNamed(RoutesManager.supportCenterScreen),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
