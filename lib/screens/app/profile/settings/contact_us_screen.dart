import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/widgets/text_field_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contact_us'.tr),
      ),
      body: Form(
        // key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            TextFieldWidget(
              label: 'name'.tr,
              hintText: 'name'.tr,
              controller: TextEditingController(),
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'phone_number'.tr,
              hintText: 'phone_number'.tr,
              controller: TextEditingController(),
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'email'.tr,
              hintText: 'email'.tr,
              controller: TextEditingController(),
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'notes'.tr,
              hintText: 'notes'.tr,
              minLines: 6,
              maxLines: 6,
              controller: TextEditingController(),
            ),
            SizedBox(height: 96.h),
            ElevatedButton(
              onPressed: () {},
              child: Text('send'.tr),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (controller.formKey.currentState!.validate()) {
            //       controller.isLogging(true);
            //       await _performLogin();
            //     }
            //   },
            //   child: Text('new_sign_in'.tr),
            // ),
            // SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
