import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/routes/routes_manager.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import '../../core/widgets/text_field_widget.dart';
import '../../getx/controllers/auth/reset_password_controller.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/constants_manager.dart';
import '../../core/constants/text_styles_manager.dart';
import '../../core/widgets/loading_widget.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: ConstantsManager.authAppBar,
          body: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.all(24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'reset_password'.tr,
                    style: TextStylesManager.title,
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'reset_password_subtitle'.tr,
                    style: TextStylesManager.subTitle,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Obx(() => TextFieldWidget(
                        label: 'new_password'.tr,
                        hintText: 'new_password'.tr,
                        suffixIcon: Obx(
                          () => IconButton(
                            onPressed: () {
                              controller.newPasswordVisible(
                                  !controller.newPasswordVisible.value);
                            },
                            icon: controller.newPasswordVisible.value
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
                        obscureText: !controller.newPasswordVisible.value,
                        controller: controller.newPasswordController,
                        isPassword: true,
                      )),
                  SizedBox(height: 20.h),
                  Obx(() => TextFieldWidget(
                        label: 'confirm_passwoed'.tr,
                        hintText: 'confirm_passwoed'.tr,
                        suffixIcon: Obx(
                          () => IconButton(
                            onPressed: () {
                              controller.confirmPasswordVisible(
                                  !controller.confirmPasswordVisible.value);
                            },
                            icon: controller.confirmPasswordVisible.value
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
                        obscureText: !controller.confirmPasswordVisible.value,
                        controller: controller.confirmPasswordController,
                        isPassword: true,
                      )),
                  const Spacer(
                    flex: 3,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.newPasswordController.text.trim() ==
                            controller.confirmPasswordController.text.trim()) {
                          controller.isLoading(true);
                          await _performResetPassword();
                        } else {
                          showSnackbar(
                            message: 'كلمتا المرور غير متطابقتين',
                            success: false,
                            duration: 2,
                          );
                        }
                      }
                    },
                    child: Text('send'.tr),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
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

  Future<void> _performResetPassword() async {
    String phone = Get.arguments?['phone'] ?? '970';
    String code = Get.arguments?['code'] ?? '0000';
    var response = await controller.resetPassword(phone: phone, code: code);
    controller.isLoading(false);
    showSnackbar(
      message: response.message,
      success: response.success,
    );
    if (response.success) {
      Get.offAllNamed(RoutesManager.signInScreen);
    }
  }
}
