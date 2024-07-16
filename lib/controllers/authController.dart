import 'package:get/get.dart';

class AuthController extends GetxController {
  // RxBool isLoading = false.obs;
  String? email, password;
  @override


  void onInit() {
    super.onInit();

  }

  validateEmail(String? Email) {
    if (!GetUtils.isEmail(Email ?? "")) {
      return "emailVal".tr;
    } else {
      return null;
    }
  }

  validatePassword(String? pwd) {

    if (GetUtils.isLengthLessThan(pwd ?? "", 2)) {
      return "passVal".tr;
    } else {
      return null;
    }
  }

 
}
