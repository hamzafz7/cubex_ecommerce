import 'package:cubex_ecommerce/pages/logInPage.dart';
import 'package:get/get.dart';

class AppRoute {
  static const homePageUrl = "/home";
  static const loginPageUrl = "/login-page";

  static List<GetPage> pages = [
    // GetPage(name: homePageUrl, page: () => HomePage())
    GetPage(name: loginPageUrl, page: () =>  LogInPage())
  ];
}
