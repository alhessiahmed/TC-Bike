// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
// import '../../api/controllers/auth_api_controller.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/constants_manager.dart';
import '../../core/routes/routes_manager.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/text_field_widget.dart';
import '../../getx/controllers/auth/sign_up_controller.dart';

import '../../core/constants/images_manager.dart';
import '../../core/constants/text_styles_manager.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: ConstantsManager.authAppBar,
          body: Form(
            key: controller.formKey,
            child: ListView(
              padding: EdgeInsets.all(24.w),
              children: [
                Text(
                  'create_account'.tr,
                  style: TextStylesManager.title,
                ),
                SizedBox(height: 14.h),
                Text(
                  'sign_up_subtitle'.tr,
                  style: TextStylesManager.subTitle,
                ),
                SizedBox(height: 24.h),
                OutlinedButton.icon(
                  onPressed: () async {
                    await _performLoginWithGoogle();
                  },
                  icon: SvgPicture.asset(
                    ImagesManager.google,
                    height: 26.h,
                  ),
                  label: Text('google_sign_in'.tr),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'or'.tr,
                        style: TextStyle(
                          color: ColorsManager.subtitleColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                TextFieldWidget(
                  label: 'full_name'.tr,
                  hintText: 'full_name'.tr,
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.profile,
                  ),
                  controller: controller.nameController,
                ),
                SizedBox(height: 16.h),
                GetBuilder<SignUpController>(
                  builder: (context) {
                    return TextFieldWidget(
                      label: 'phone_number'.tr,
                      hintText: 'phone_number'.tr,
                      controller: controller.phoneController,
                      isPhone: true,
                      counterColor:
                          controller.phoneController.value.text.length == 12
                              ? ColorsManager.primary
                              : null,
                      counterText:
                          controller.phoneController.value.text.isNotEmpty
                              ? null
                              : '',
                      onChange: (value) {
                        controller.update();
                      },
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => TextFieldWidget(
                    label: 'password'.tr,
                    hintText: 'password'.tr,
                    suffixIcon: Obx(
                      () => IconButton(
                        onPressed: () {
                          controller.passwordVisible(
                              !controller.passwordVisible.value);
                        },
                        icon: controller.passwordVisible.value
                            ? Icon(
                                Icons.visibility_outlined,
                                color: ColorsManager.subtitleColor,
                                size: 24.h,
                              )
                            : Icon(
                                Icons.visibility_off_outlined,
                                color: ColorsManager.subtitleColor,
                                size: 24.h,
                              ),
                      ),
                    ),
                    obscureText: !controller.passwordVisible.value,
                    controller: controller.passwordController,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.agreeConditions.value,
                          onChanged: (value) {
                            controller.agreeConditions(
                                !controller.agreeConditions.value);
                          },
                        )),
                    Text(
                      'agree_with'.tr,
                      style:
                          const TextStyle(color: ColorsManager.subtitleColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RoutesManager.termsConditionsScreen);
                      },
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 14.sp),
                      ),
                      child: Text('terms_conditions'.tr),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Obx(() => IgnorePointer(
                      ignoring: !controller.agreeConditions.value,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            controller.isLoading(true);
                            await _performSignUp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.agreeConditions.value
                              ? ColorsManager.primary
                              : ColorsManager.disabled,
                        ),
                        child: Text('new_sign_in'.tr),
                      ),
                    )),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have_account'.tr,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(RoutesManager.signInScreen);
                      },
                      child: Text(
                        'sign_in'.tr,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

  Future<void> _performSignUp() async {
    var response = await controller.signUp();
    controller.isLoading(false);
    // print(response.message);

    if (response.success) {
      Get.toNamed(
        RoutesManager.verificationScreen,
        arguments: {
          'phone': controller.phoneController.text,
          'is_sign_up': true,
        },
      );
    }
    showSnackbar(
      message: response.message,
      success: response.success,
    );
  }

  Future<void> _performLoginWithGoogle() async {
    // log('message');
    // final response = await AuthApiController().signInWithGoogle();
    // log('message2');
    // if (response != null) {
    //   log(response.message);
    //   showSnackbar(
    //     message: response.message,
    //     success: response.success,
    //   );
    // }
  }
}
