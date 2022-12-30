import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import 'package:tcbike/core/widgets/text_field_widget.dart';
import 'package:tcbike/getx/controllers/app/edit_profile_controller.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../pref/shared_pref_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('my_account'.tr),
          ),
          body: ListView(
            padding: EdgeInsets.all(24.r),
            children: [
              GetBuilder<EditProfileController>(
                  builder: (EditProfileController controller) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 58.r,
                      backgroundColor: ColorsManager.disabled,
                      foregroundColor: ColorsManager.white,
                      backgroundImage: controller.imageIsUpdated
                          ? FileImage(
                              File(controller.pickedImage!.path),
                            )
                          : SharedPrefController()
                                      .getByKey(key: UserInfo.image.name) !=
                                  null
                              ? NetworkImage(
                                  SharedPrefController()
                                      .getByKey(key: UserInfo.image.name),
                                )
                              : const AssetImage(ImagesManager.avatar)
                                  as ImageProvider,
                      // child: controller.imageIsUpdated
                      //     ? Image.file(
                      //         File(
                      //           controller.pickedImage!.path,
                      //         ),
                      //       )
                      //     : SharedPrefController()
                      //                 .getByKey(key: UserInfo.image.name) !=
                      //             null
                      //         ? Image.network(
                      //             SharedPrefController()
                      //                 .getByKey(key: UserInfo.image.name),
                      //           )
                      //         : Icon(
                      //             Icons.person,
                      //             size: 70.r,
                      //           ),

                      // SharedPrefController()
                      //             .getByKey(key: UserInfo.image.name) !=
                      //         null
                      //     ? Image.network(SharedPrefController()
                      //         .getByKey(key: UserInfo.image.name))
                      //     : Icon(
                      //         Icons.person,
                      //         size: 70.r,
                      //       ),
                    ),
                    PositionedDirectional(
                      bottom: 4.r,
                      start: Get.width / 2,
                      child: InkWell(
                        onTap: () async {
                          await _performPickImage();
                        },
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: ColorsManager.white,
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: ColorsManager.primary,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: ColorsManager.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 8.h),
              Text(
                'change_image'.tr,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: ColorsManager.secondary, fontSize: 16.sp),
              ),
              SizedBox(height: Get.height / 17),
              Obx(() => TextFieldWidget(
                    label: 'full_name'.tr,
                    hintText: 'full_name'.tr,
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.profile,
                      color: ColorsManager.primary,
                    ),
                    canClear: controller.canClear.value,
                    onTap: () => controller.canClear(true),
                    onChange: (value) => value.isEmpty
                        ? controller.canClear(false)
                        : controller.canClear(true),
                    controller: controller.nameController,
                  )),
              SizedBox(height: 16.h),
              TextFieldWidget(
                label: SharedPrefController().provider == 'phone'
                    ? 'phone_number'.tr
                    : 'email'.tr,
                hintText: SharedPrefController().provider == 'phone'
                    ? 'phone_number'.tr
                    : 'email'.tr,
                readOnly: true,
                prefixIcon: SharedPrefController().provider == 'phone'
                    ? SvgPicture.asset(
                        ImagesManager.call,
                        color: ColorsManager.primary,
                      )
                    : Icon(
                        Icons.mail_outline_rounded,
                        size: 22.r,
                        color: ColorsManager.primary,
                      ),
                controller: controller.phoneController,
                // suffixIcon: Center(
                //   child: InkWell(
                //     onTap: () {},
                //     child: const Text(
                //       'تغيير',
                //       style: TextStyle(color: ColorsManager.secondary),
                //     ),
                //   ),
                // ),
              ),

              // TextFieldWidget(
              //   label: 'phone_number'.tr,
              //   hintText: 'phone_number'.tr,
              //   readOnly: true,
              //   prefixIcon: SvgPicture.asset(
              //     ImagesManager.call,
              //     color: ColorsManager.primary,
              //   ),
              //   controller: controller.phoneController,
              //   // suffixIcon: Center(
              //   //   child: InkWell(
              //   //     onTap: () {},
              //   //     child: const Text(
              //   //       'تغيير',
              //   //       style: TextStyle(color: ColorsManager.secondary),
              //   //     ),
              //   //   ),
              //   // ),
              // ),
              SizedBox(height: 16.h),
              Visibility(
                visible: SharedPrefController().provider == 'phone',
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                child: Obx(
                  () => TextFieldWidget(
                    label: 'password'.tr,
                    hintText: 'password'.tr,
                    readOnly: true,
                    suffixIcon: Center(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RoutesManager.changePasswordScreen);
                        },
                        child: const Text(
                          'تغيير',
                          style: TextStyle(color: ColorsManager.secondary),
                        ),
                      ),
                    ),
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.lock,
                      color: ColorsManager.primary,
                    ),
                    obscureText: !controller.passwordVisible.value,
                    controller: controller.passwordController,
                    // isPassword: true,
                  ),
                ),
              ),
              // SizedBox(height: 104.h),
              SizedBox(height: Get.height / 9),
              ElevatedButton(
                onPressed: () async {
                  await _performUpdateProfile();
                },
                child: Text(
                  'save_changes'.tr,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoading.value,
            child: const LoadingWidget(),
          ),
        ),
      ],
    );
  }

  Future<void> _performUpdateProfile() async {
    controller.isLoading(true);
    final response = await controller.updateUserProfile();
    controller.isLoading(false);
    if (response.success) {
      Get.back();
    }
    showSnackbar(message: response.message, success: response.success);
  }

  Future<void> _performPickImage() async {
    await controller.pickImageFrom(ImageSource.gallery);
  }
}
