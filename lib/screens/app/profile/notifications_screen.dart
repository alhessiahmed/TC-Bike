import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import 'package:tcbike/core/constants/text_styles_manager.dart';
import 'package:tcbike/core/widgets/loading_widget.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/model/api_notification.dart';

import '../../../api/controllers/content_api_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
      ),
      body: FutureBuilder<List<ApiNotification>>(
        future: ContentApiController().readNotifications(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const LoadingWidget()
              : !snapshot.hasData ||
                      (snapshot.hasData && snapshot.data!.isEmpty)
                  ? const NoDataWidget()
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        vertical: 18.h,
                        horizontal: 24.w,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              ImagesManager.notification,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].time,
                                  style: TextStylesManager.subTitle,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                SizedBox(
                                  width: (Get.width * (3 / 4) - 16),
                                  child: Text(
                                    // 'semi_fill'.tr,
                                    snapshot.data![index].body,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 32,
                          thickness: 1,
                        );
                      },
                    );
        },
      ),
    );
  }
}
