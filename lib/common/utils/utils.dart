import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_core/core.dart';

import '../constants/app_colors.dart';
import '../widgets/shimmer_placeholder.dart';
import 'custom_toasts.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Utils {
  // static Future<File?> compressImage(File file) async {
  //   try {
  //     final filePath = file.path;
  //     final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  //     final splitted = filePath.substring(0, (lastIndex));
  //     final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  //     var result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path,
  //       outPath,
  //       quality: 88,
  //     );

  //     return File(result!.path);
  //   } on CompressError catch (e) {
  //     rethrow;
  //   }
  // }
  static Widget Function(BuildContext, Widget, int?, bool)?
      imageLoadingBuilder() {
    return (_, image, loadingBuilder, __) {
      if (loadingBuilder == null) {
        return ShimmerPlaceholder(
            child: Container(
          width: 80.w,
        ));
      }

      return image;
    };
  }

  static Widget Function(BuildContext, Object, StackTrace?)?
      imageErrorBuilder() {
    return (context, error, stackTrace) => Image(
          image: const AssetImage(
            'assets/images/error.png',
          ),
          width: 80.w,
        );
  }

  static bool isUrl(String text) {
    final isUrl = Uri.tryParse(text);
    return isUrl != null;
  }

  static Future<File> fileFromUrl(String path) async {
    final url = Uri.parse(path);
    final http.Response responseData = await http.get(url);
    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/${path.split("/").last}')
        .writeAsBytes(
            buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  static Future<File?> compressImage(File file) async {
    try {
      final filePath = file.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 88,
      );

      return File(result!.path);
    } on CompressError catch (e) {
      print(e);
      rethrow;
    }
  }

  static String dateFormat(DateTime date, {String expression = "yyyy/MM/dd"}) {
    return DateFormat(expression).format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static String formatTime(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');

    return '$hour:$minute:$second';
  }

  static String convertTimeString(String? timeString) {
    if (timeString == null) {
      return 'no_time'.tr;
    } else {
      DateFormat inputFormat = DateFormat('HH:mm:ss');
      DateFormat outputFormat = DateFormat.jm();
      DateTime dateTime = inputFormat.parse(timeString);
      String formattedTime = outputFormat.format(dateTime);
      return formattedTime;
    }
  }

  static String formatDateForReasonScreen(DateTime date) {
    DateTime dateTime = date;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static String formatFullDate(String fullDate) {
    final inputFormat = DateFormat(
        'yyyy-MM-ddTHH:mm:ss.SSSSSSZ'); // Adjust the format based on your input
    final outputFormat = DateFormat('dd-MM-yyyy - HH:ss a');
    final date = inputFormat.parse(fullDate);
    return outputFormat.format(date);
  }

  static Future<String?> imagePicker(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      return pickedImage.path;
    } else {
      return null;
    }
  }

  static void openWhatsapp(
      {required String text, required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(
            Uri.parse(
              whatsappURLIos,
            ),
            mode: LaunchMode.externalNonBrowserApplication);
      } else {
        CustomToasts.ErrorDialog("whatsapp_not_installed");
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(
          Uri.parse(whatsappURlAndroid),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        CustomToasts.ErrorDialog("whatsapp_not_installed");
      }
    }
  }

  static Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(
        _phoneUri,
      )) {
        await launchUrl(
          _phoneUri,
        );
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  static void sendEmail(String email) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    launchUrl(emailLaunchUri);
  }

  static void sendSms() async {
    // Android
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '+9630938044147',
      queryParameters: <String, String>{
        'body': Uri.encodeComponent('Hello from Flutter!'),
      },
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      // iOS
      final uri = Uri.parse('sms:+9630938044147?body=hello%20there');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  static String maskEmail(String email) {
    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    final maskedUsername =
        '${username.substring(0, 2)}${'*' * (username.length - 2)}';

    return '$maskedUsername@$domain';
  }

  // static void viewFile({required String? path, required bool isNetwork}) {
  //   if (path != null && path != "") {
  //     if (path.contains(".pdf")) {
  //       Get.to(
  //         () => FileViewWidget(imagePath: path),
  //       );
  //     } else {
  //       viewImage(path: path, isNetwork: isNetwork);
  //     }
  //   } else {
  //     Get.snackbar("fail_photo".tr, "fail_photo_view".tr);
  //   }
  // }

  static Future<String?> pickfilefrommemory() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'png', 'jpg', 'jfif', 'HEIC'],
      type: FileType.custom,
    );
    if (result != null) {
      final file = result.files.first;
      String biographyfile = file.path!;
      return biographyfile;
    }
    return null;
  }

  static bool isValidDateFormat(String input) {
    try {
      DateTime.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String? isEmailOptValidated(String? val) {
    if (val == null || val.isEmpty) {
      return null;
    } else if (!GetUtils.isEmail(val)) {
      return "invalid_email".tr;
    } else {
      return null;
    }
  }

  static String? isPasswordValidated(String? val) {
    if (val == null || val.isEmpty) {
      return "required_feild".tr;
    } else {
      return null;
    }
    //  else if (val.length < 8 || val.length > 24) {
    //   return "password_validateion".tr;
    // }
  }

  static String? isFeildValidated(String? val) {
    if (val == null || val.isEmpty) {
      return "required_feild".tr;
    } else {
      return null;
    }
  }

  static String? isOptFeildValidated(String? val) {
    // // RegExp letterRegex = RegExp(r'[a-zA-Z]');
    // if (val != null) {
    //   bool containsLetter = letterRegex.hasMatch(val);
    //   if (!containsLetter) {
    //     return "should_contain_letter".tr;
    //   }
    // }
    return null;
  }

  static String? isStringInputValidated(String? val) {
    if (val == null || val.isEmpty) {
      return "required_feild".tr;
    } else {
      RegExp arabicRegex = RegExp(r'[\u0600-\u06FF]');
      RegExp englishRegex = RegExp(r'[a-zA-Z]');
      bool containsLetter =
          arabicRegex.hasMatch(val) || englishRegex.hasMatch(val);
      if (!containsLetter) {
        return "should_contain_letter".tr;
      }
    }
    return null;
  }

  static String? isLinkValidated(String? val) {
    if (val == null || val.isEmpty) {
      return "required_feild".tr;
    } else {
      final RegExp urlPattern = RegExp(r'^https?://');
      if (!urlPattern.hasMatch(val)) {
        return "must_be_link".tr;
      }
    }
    return null;
  }

  static String? isNumericFeildValidated(String? val) {
    if (val == null || val.isEmpty) {
      return "required_feild".tr;
    }
    try {
      double.parse(val);
      return null;
    } catch (e) {
      return "Only Numbers are allowed in this feild".tr;
    }
  }

  static String? isNumericFeild(String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }
    try {
      double.parse(val);
      return null;
    } catch (e) {
      return "Only Numbers are allowed in this feild".tr;
    }
  }

  static String? isEmailValidated(String? val) {
    if (val == null || val.isEmpty) {
      return "required_feild".tr;
    } else if (!GetUtils.isEmail(val)) {
      return "invalid_email".tr;
    } else {
      return null;
    }
  }

  String getDayofWeek(String stringDate) {
    try {
      DateTime date = DateFormat("yyyy-MM-dd").parse(stringDate);

      String dayOfWeek = DateFormat("EEEE").format(date);

      return dayOfWeek;
    } catch (e) {
      return "No day";
    }
  }

  getDayNum(String stringDate) {
    try {
      DateTime date = DateTime.parse(stringDate);

      int day = date.day;

      return day;
    } catch (_) {
      return 0;
    }
  }

  getYearOfDate(String dateString) {
    try {
      DateTime date = DateFormat("yyyy-MM-dd").parse(dateString);

      String year = DateFormat("yyyy").format(date);
      return year;
    } catch (_) {
      return "No Year";
    }
  }

  getMonthName(String dateString) {
    try {
      DateTime date = DateFormat("yyyy-MM-dd").parse(dateString);

      String month = DateFormat("MMMM").format(date);

      return month.substring(0, 3).toUpperCase();
    } catch (_) {
      return "No month";
    }
  }

  static Future<dynamic>? getHijriDate(context,
      {HijriDatePickerController? controller,
      Function(Object?)? onChanged}) async {
    dynamic timepicked;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
            height: 360.h,
            width: 400.w,
            child: SfHijriDateRangePicker(
                cancelText: 'Cancel'.tr,
                confirmText: "Ok".tr,
                minDate: HijriDateTime.fromDateTime(
                    DateTime.now().add(Duration(days: 2))),
                onCancel: () {
                  Get.back();
                },
                enablePastDates: false,
                controller: controller,
                viewSpacing: 10.w,
                headerHeight: 20.h,
                showTodayButton: false,
                showActionButtons: true,
                view: HijriDatePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                selectionShape: DateRangePickerSelectionShape.circle,
                initialDisplayDate: HijriDateTime.fromDateTime(
                    DateTime.now().add(Duration(days: 2))),
                initialSelectedDate: HijriDateTime.fromDateTime(
                    DateTime.now().add(Duration(days: 2))),
                showNavigationArrow: true,
                selectionColor: AppColors.primaryColor,
                toggleDaySelection: false,
                monthViewSettings: const HijriDatePickerMonthViewSettings(
                  dayFormat: "",
                ),
                onSubmit: (val) {
                  timepicked = val;
                  Get.back();
                }),
          ));
        });
    return timepicked;
  }

  static Future<TimeOfDay?> pickTime(context) async {
    return await showTimePicker(
        cancelText: 'Cancel'.tr,
        confirmText: "Ok".tr,
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child!);
        });
  }

  static Future<dynamic>? getMiladiDate(context,
      {DateRangePickerController? controller,
      Function(DateRangePickerSelectionChangedArgs)? onChanged}) async {
    dynamic timepicked;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
            height: 360.h,
            width: 400.w,
            child: SfDateRangePicker(
              cancelText: 'Cancel'.tr,
              confirmText: "Ok".tr,
              minDate: DateTime.now().add(Duration(days: 2)),
              onCancel: () {
                Get.back();
              },
              enablePastDates: false,
              controller: controller,
              onSelectionChanged: onChanged,
              viewSpacing: 10.w,
              headerHeight: 20.h,
              showTodayButton: false,
              initialDisplayDate: DateTime.now().add(Duration(days: 2)),
              initialSelectedDate: DateTime.now().add(Duration(days: 2)),
              showActionButtons: true,
              selectionMode: DateRangePickerSelectionMode.single,
              selectionShape: DateRangePickerSelectionShape.circle,
              showNavigationArrow: true,
              selectionColor: AppColors.primaryColor,
              toggleDaySelection: false,
              onSubmit: (val) {
                timepicked = val;
                Get.back();
              },
            ),
          ));
        });
    return timepicked;
  }
}
