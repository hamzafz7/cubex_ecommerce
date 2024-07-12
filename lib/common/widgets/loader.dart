import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double? height;
  final Color? color;
  const CustomLoader({
    super.key,
    this.height,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
