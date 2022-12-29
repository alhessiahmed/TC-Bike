import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/colors_manager.dart';

class VerifyFieldWidget extends StatelessWidget {
  const VerifyFieldWidget({
    Key? key,
    required this.codeController,
    required this.focusNode,
    required this.onChanged,
    required this.filled,
    this.autofocus = false,
  }) : super(key: key);

  final TextEditingController codeController;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  final bool filled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 54.w,
      child: TextFormField(
        controller: codeController,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 30.sp,
          color: filled ? ColorsManager.white : ColorsManager.textColor,
        ),
        textAlign: TextAlign.center,
        maxLength: 1,
        cursorColor: filled ? ColorsManager.white : ColorsManager.primary,
        autofocus: autofocus,
        decoration: InputDecoration(
          counterText: '',
          filled: filled,
          fillColor: ColorsManager.primary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Color(0xFFEFF0F3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Color(0xFFEFF0F3)),
          ),
        ),
      ),
    );
  }
}
