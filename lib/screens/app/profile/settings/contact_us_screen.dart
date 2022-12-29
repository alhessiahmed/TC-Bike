import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/utils/show_snackbar.dart';
import 'package:tcbike/core/widgets/text_field_widget.dart';
import 'package:tcbike/getx/controllers/app/contact_controller.dart';

class ContactUsScreen extends GetView<ContactController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contact_us'.tr),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            TextFieldWidget(
              label: 'name'.tr,
              hintText: 'name'.tr,
              controller: controller.nameController,
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'phone_number'.tr,
              hintText: 'phone_number'.tr,
              controller: controller.phoneController,
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'email'.tr,
              hintText: 'email'.tr,
              controller: controller.emailController,
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'notes'.tr,
              hintText: 'notes'.tr,
              minLines: 6,
              maxLines: 6,
              controller: controller.notesController,
            ),
            SizedBox(height: 96.h),
            ElevatedButton(
              onPressed: () async {
                if (controller.formKey.currentState!.validate()) {
                  controller.isLoading(true);
                  final response = await controller.sendTicket();
                  controller.isLoading(false);
                  if (response.success) {
                    Get.back();
                  }
                  showSnackbar(
                      message: response.message, success: response.success);
                }
              },
              child: Text('send'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
