import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tcbike/core/constants/images_manager.dart';
import '../../core/constants/colors_manager.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPhone = false,
    this.obscureText = false,
    this.canClear = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.counterColor,
    this.counterText,
    this.onChange,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    required this.label,
  }) : super(key: key);
  final String label;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPhone;
  final bool obscureText;
  final int maxLines;
  final int minLines;
  final Color? counterColor;
  final String? counterText;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final bool readOnly;
  final bool canClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'required_field'.tr;
            } else if (isPassword && value.length < 8) {
              return 'password_condition'.tr;
            } else if (isPhone && value.length < 9) {
              return 'phone_condition'.tr;
            }
            return null;
          },
          textInputAction: textInputAction,
          keyboardType: isPhone ? TextInputType.phone : keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChange,
          onTap: onTap,
          maxLength: isPhone ? 9 : null,
          onFieldSubmitted: onSubmitted,
          readOnly: readOnly,
          decoration: InputDecoration(
            counterText: counterText == null ? counterText : '',
            counterStyle: TextStyle(color: counterColor),

            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 30.w, vertical: 35.h),
            hintText: hintText,
            hintStyle: TextStyle(
              color: ColorsManager.subtitleColor,
              fontSize: 14.sp,
            ),

            // helperText: isPhone ? 'phone_helper'.tr : null,
            suffixIcon: canClear
                ? IconButton(
                    onPressed: () => controller.clear(),
                    icon: const Icon(Icons.close_rounded),
                    iconSize: 24.r,
                  )
                : isPhone
                    ? Row(
                        children: [
                          Container(
                            width: 2,
                            height: 24.h,
                            color: ColorsManager.primary,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Text('972'),
                        ],
                      )
                    : suffixIcon,
            prefixIcon: isPassword
                ? SvgPicture.asset(
                    ImagesManager.lock,
                  )
                : isPhone
                    ? SvgPicture.asset(
                        ImagesManager.phone,
                      )
                    : prefixIcon,
            prefixIconConstraints: BoxConstraints(
              maxHeight: 26.h,
              maxWidth: 40.w,
              minWidth: 40.w,
            ),
            suffixIconConstraints: BoxConstraints(
              // maxHeight: 26.h,
              maxWidth: 60.w,
              minWidth: 40.w,
            ),
            // ? Icon(
            //     Icons.lock_outline_rounded,
            //     color: ColorsManager.subtitleColor,
            //     size: 24.h,
            //   )
            // : isPhone
            //     ? Icon(
            //         Icons.phone_android_outlined,
            //         color: ColorsManager.subtitleColor,
            //         size: 24.h,
            //       )
            //     : prefixIcon,
            errorMaxLines: 2,
            errorStyle: const TextStyle(
              color: ColorsManager.danger,
            ),
            filled: true,
            fillColor: ColorsManager.white,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: ColorsManager.outlineBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: ColorsManager.primary,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: ColorsManager.danger,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: ColorsManager.outlineBorder),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: ColorsManager.danger,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
