import 'package:get_storage/get_storage.dart';

class CacheProvider {
  static late GetStorage _getStorage;

  CacheProvider() {
    _getStorage = GetStorage();
  }
  static init() {
    _getStorage = GetStorage();
  }

  static setAppToken(String? token) async {
    return await _getStorage.write("token", token);
  }

  static getAppToken() {
    return _getStorage.read("token");
  }

  static clearAppToken() {
    _getStorage.remove("token");
  }

  static setIsOnBoardingOpened(bool? val) async {
    await _getStorage.write("onboaring_opened", val);
  }

  static getIsOnBoardingOpened() {
    print(_getStorage.read("onboaring_opened"));
    return _getStorage.read("onboaring_opened");
  }

  static setUserName(String val) async {
    await _getStorage.write("name", val);
  }

  static getUserName() {
    return _getStorage.read("name");
  }

  static setUserEmail(String val) async {
    await _getStorage.write("email", val);
  }

  static getUserEmail() {
    return _getStorage.read("email");
  }

  static setUserID(int val) async {
    await _getStorage.write("id", val);
  }

  static getUserID() {
    return _getStorage.read("id");
  }

  static setUserPhone(String val) async {
    await _getStorage.write("phone", val);
  }

  static getUserPhone() {
    return _getStorage.read("phone");
  }

  static getAppLocale() {
    return _getStorage.read("locale");
  }

  static setAppLocale(String locale) async {
    return await _getStorage.write("locale", locale);
  }

  static clearStorage() async {
    await _getStorage.remove("name");
    await _getStorage.remove("phone");
    await _getStorage.remove("id");
    await _getStorage.remove("email");
    await _getStorage.remove("token");
  }
}
