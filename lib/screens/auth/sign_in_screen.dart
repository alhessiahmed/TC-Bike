// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';
// import '../../api/controllers/auth_api_controller.dart';
import '../../core/constants/constants_manager.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/images_manager.dart';
import '../../core/constants/text_styles_manager.dart';
import '../../core/routes/routes_manager.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/text_field_widget.dart';
import '../../getx/controllers/auth/sign_in_controller.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

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
                  'sign_in'.tr,
                  style: TextStylesManager.title,
                ),
                SizedBox(height: 14.h),
                Text(
                  'sign_in_subtitle'.tr,
                  style: TextStylesManager.subTitle,
                ),
                SizedBox(height: 24.h),
                Obx(() => IgnorePointer(
                      ignoring: controller.isIgnoring.value,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await _performLoginWithGoogle();
                        },
                        icon: SvgPicture.asset(
                          ImagesManager.google,
                          height: 26.h,
                        ),
                        label: Text('google_sign_in'.tr),
                      ),
                    )),
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
                SizedBox(height: 16.h),
                GetBuilder<SignInController>(builder: (context) {
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
                }),
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
                    isPassword: true,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe(!controller.rememberMe.value);
                          },
                        )),
                    Text('remember_me'.tr),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RoutesManager.forgetPasswordScreen);
                      },
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 14.sp),
                      ),
                      child: Text('forget_password'.tr),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      controller.isLoading(true);
                      await _performLogin();
                    }
                  },
                  child: Text('sign_in'.tr),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have_no_account'.tr,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(RoutesManager.signUpScreen);
                      },
                      child: Text(
                        'sign'.tr,
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

  Future<void> _performLogin() async {
    var response = await controller.signIn();
    controller.isLoading(false);
    SharedPrefController().setRememberMeStatus(controller.rememberMe.value);
    showSnackbar(
      message: response.message,
      success: response.success,
    );
    if (response.success) {
      Get.offAllNamed(RoutesManager.homeScreen);
    }
  }

  Future<void> _performLoginWithGoogle() async {
    // GoogleSignIn().disconnect();

    // log('message');
    // controller.isLoading(true);
    // final response = await AuthApiController().signInWithGoogle();
    // controller.isLoading(false);
    // log('message2');
    // log('response: ${response?.message} ${response?.success}');
    // if (response != null) {
    //   log(response.message);
    //   showSnackbar(
    //     message: response.message,
    //     success: response.success,
    //   );
    //   if (!(await InternetConnectionChecker().hasConnection)) {
    //     controller.isIgnoring(true);
    //     Future.delayed(const Duration(seconds: 3))
    //         .then((value) => controller.isIgnoring(false));
    //   }
    //   if (response.success) {
    //     Get.offAllNamed(RoutesManager.homeScreen);
    //   }
    // } // l
  }
}
