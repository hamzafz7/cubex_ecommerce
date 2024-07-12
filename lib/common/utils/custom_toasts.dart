import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToasts {
  static ErrorDialog(String message, {Icon? icon}) {
    Get.snackbar("Error".tr, message,
        icon: icon,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.red);
  }

  static SuccessDialog(String message, {Icon? icon}) {
    Get.snackbar("Success".tr, message.tr,
        icon: icon,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green);
  }
}
