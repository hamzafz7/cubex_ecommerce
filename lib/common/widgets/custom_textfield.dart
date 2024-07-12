import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool optional;
  final double opacity;
  final bool? isEnabled;
  final Widget? icon;
  final void Function(String)? onChanged;
  final Widget? suffix;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.width,
      this.opacity = 1,
      this.onTap,
      this.readOnly = false,
      this.validator,
      this.icon,
      this.optional = false,
      required this.hintText,
      this.maxLines,
      this.keyboardType,
      this.isEnabled = true,
      this.onChanged,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      width: width ?? 335.w,
      decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color.fromRGBO(173, 173, 173, 1))),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        onTap: onTap,
        enabled: isEnabled,
        readOnly: readOnly,
        maxLines: maxLines,
        onChanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.name,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: suffix,
          contentPadding: REdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: icon == null && suffix == null ? 0 : 15.h),
          hintText: hintText.tr + (optional ? " (${"optional".tr})" : ""),
          prefixIcon: icon,
          alignLabelWithHint: false,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Color.fromRGBO(137, 137, 137, 1)),
        ),
      ),
    );
  }
}
