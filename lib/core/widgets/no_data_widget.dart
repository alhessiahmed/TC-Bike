import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.message = 'no_data'});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.sp,
          height: 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
