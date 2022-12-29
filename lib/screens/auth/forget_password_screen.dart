import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/constants_manager.dart';
import '../../core/routes/routes_manager.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/text_field_widget.dart';
import '../../getx/controllers/auth/forget_password_controller.dart';
import '../../core/constants/text_styles_manager.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

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
                    'forget_password'.tr,
                    style: TextStylesManager.title,
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'forget_password_subtitle'.tr,
                    style: TextStylesManager.subTitle,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  GetBuilder<ForgetPasswordController>(builder: (context) {
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
                  const Spacer(
                    flex: 3,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        controller.isLoading(true);
                        await _performReset();
                        controller.isLoading(false);
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

  Future<void> _performReset() async {
    var response = await controller.forgetPassword();
    if (response.success) {
      Get.toNamed(
        RoutesManager.verificationScreen,
        arguments: {
          'phone': controller.phoneController.text,
        },
      );
    }
    showSnackbar(
      message: response.message,
      success: response.success,
    );
  }
}
