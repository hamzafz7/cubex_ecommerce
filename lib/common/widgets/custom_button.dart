import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String? icon;
  final VoidCallback? onTap;
  final bool isprefix;
  final bool ispng;
  final double opacity;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final bool? hasBorder;
  final double height, width;
  final Color? borderColor;
  final bool rotateOnAr;

  const CustomButton({
    Key? key,
    required this.title,
    this.icon,
    this.opacity = 1,
    this.ispng = false,
    this.rotateOnAr = false,
    this.isprefix = false,
    // this.color = AppColors.primaryColor,
    required this.onTap,
    this.borderRadius = 8,
    this.textStyle,
    this.buttonColor = AppColors.primaryColor,
    this.hasBorder = false,
    this.borderColor,
    this.width = 330,
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
              color: onTap == null
                  ? buttonColor!.withOpacity(0.5)
                  : buttonColor!.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius!),
              border: hasBorder!
                  ? Border.all(width: 1, color: borderColor!)
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && isprefix)
                ispng
                    ? ImageIcon(
                        AssetImage(icon!),
                        color: Colors.white,
                      )
                    : RotatedBox(
                        quarterTurns: !rotateOnAr
                            ? 0
                            : Get.locale!.languageCode == "ar"
                                ? 2
                                : 0,
                        child: SvgPicture.asset(icon!)),
              if (icon != null && isprefix)
                SizedBox(
                  width: 5.w,
                ),
              Text(
                title,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
              ),
              if (icon != null && !isprefix)
                SizedBox(
                  width: 5.w,
                ),
              if (icon != null && !isprefix)
                ispng
                    ? ImageIcon(
                        AssetImage(icon!),
                        color: Colors.white,
                      )
                    : RotatedBox(
                        quarterTurns: !rotateOnAr
                            ? 0
                            : Get.locale!.languageCode == "ar"
                                ? 2
                                : 0,
                        child: SvgPicture.asset(icon!))
            ],
          ),
        ));
  }
}
