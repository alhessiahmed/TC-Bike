import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcbike/api/controllers/content_api_controller.dart';
import 'package:tcbike/core/constants/colors_manager.dart';
import 'package:tcbike/core/constants/constants_manager.dart';
import 'package:tcbike/core/widgets/loading_widget.dart';
import 'package:tcbike/core/widgets/no_data_widget.dart';
import 'package:tcbike/model/faq.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('support_center'.tr),
      ),
      body: FutureBuilder<List<Faq>>(
        future: ContentApiController().readFaqs(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const LoadingWidget()
              : !snapshot.hasData ||
                      (snapshot.hasData && snapshot.data!.isEmpty)
                  ? const NoDataWidget()
                  : ListView.separated(
                      padding: EdgeInsets.all(16.r),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: ConstantsManager.boxShadow,
                          ),
                          child: ExpansionTile(
                            collapsedBackgroundColor: ColorsManager.white,
                            backgroundColor: ColorsManager.secondary,
                            textColor: ColorsManager.white,
                            iconColor: ColorsManager.white,
                            title: Text(
                              snapshot.data![index].title,
                            ),
                            tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                            childrenPadding: EdgeInsets.zero,
                            initiallyExpanded: false,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 14.h, 16.h, 20.h),
                                color: ColorsManager.white,
                                child: Text(snapshot.data![index].description),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                    );
        },
      ),
    );
  }
}
