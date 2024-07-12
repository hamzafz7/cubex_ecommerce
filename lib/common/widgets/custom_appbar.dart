import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final hasLeading;
  final void Function()? backButtonPressed;
  final Color textColor;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.actions = const [],
      this.hasLeading = false,
      this.backButtonPressed,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: !hasLeading,
      leading: !hasLeading
          ? Container()
          : BackButton(
              color: textColor,
              onPressed: backButtonPressed,
            ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title.tr,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontFamily: "Red Rose", fontSize: 22.sp, color: textColor),
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
