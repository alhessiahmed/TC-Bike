import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors_manager.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgColor,
      appBar: AppBar(
        title: Text('privacy_policy'.tr),
      ),
      // body: Container(
      //   padding: EdgeInsets.symmetric(vertical: 20.w),
      //   margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      //   decoration: BoxDecoration(
      //     color: ColorsManager.white,
      //     borderRadius: BorderRadius.circular(12.r),
      //     boxShadow: [
      //       BoxShadow(
      //           color: ColorsManager.shadow,
      //           blurRadius: 5.r,
      //           offset: Offset(0, 2.h)),
      //     ],
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       SvgPicture.asset(
      //         ImagesManager.logo,
      //         height: 78.h,
      //       ),
      //       Divider(
      //         thickness: 1,
      //         height: 40.h,
      //         color: ColorsManager.dividerColor,
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(right: 32.w),
      //         child: Text(
      //           'privacy_policy'.tr,
      //           style: TextStyle(
      //             fontSize: 15.sp,
      //             fontWeight: FontWeight.bold,
      //             color: const Color(0xFF525961),
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 12.h),
      //       Expanded(
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 20.w),
      //           child: FutureBuilder(
      //             future: AboutApiController().readAboutData(),
      //             builder: (context, snapshot) {
      //               return snapshot.connectionState == ConnectionState.waiting
      //                   ? Container(
      //                       width: double.infinity,
      //                       height: double.infinity,
      //                       alignment: Alignment.center,
      //                       // color: Colors.black.withOpacity(0.2),
      //                       child: const CircularProgressIndicator(
      //                         color: ColorsManager.primary,
      //                       ),
      //                     )
      //                   : !snapshot.hasData
      //                       ? const NoDataWidget(message: 'حدث خطأ ما')
      //                       : HtmlWidget(
      //                           snapshot.data!.privacyPolicy,
      //                           renderMode: RenderMode.listView,
      //                         );
      //             },
      //           ),
      //           // Text(
      //           //   'terms_conditions_content'.tr,
      //           //   style: TextStyle(
      //           //     fontSize: 13.sp,
      //           //     height: 1.8,
      //           //     color: const Color(0xCC494545),
      //           //   ),
      //           // ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
