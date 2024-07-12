import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../constants/end_points.dart';
import '../../routers/app_router.dart';
import '../../utils/custom_toasts.dart';
import '../local/cache_provider.dart';

class AppInterceptors extends Interceptor {
  final Dio? dio;

  AppInterceptors({required this.dio});
  static bool isNointernet = false;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("request is sending");
    debugPrint(
        "REQUEST[${options.method}] => PATH: ${EndPoints.baseUrl}${options.path}");
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (!isNointernet) {
        isNointernet = false;
        return handler.reject(
            DioException(requestOptions: options, message: "no_internet".tr));
      }
      return;
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint("response is getting");
    isNointernet = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("no internet");
    });
    if (connectivityResult == ConnectivityResult.none) {
      if (!isNointernet) {
        isNointernet = false;
        return handler.reject(DioException(
            requestOptions: response.requestOptions,
            message: "no_internet".tr));
      }
      return;
    }

    if (response.statusCode == 401) {
      debugPrint("hello from 401");
      Get.snackbar("sorry".tr, "re_login".tr);
    }
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(err.message);
    print(err.response);
    if (err.message == "no_internet") {
      if (!isNointernet) {
        print("********");
        isNointernet = true;
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'no_internet'.tr,
          ),
        );
      }
      return;
    } else if (err.response?.statusCode == 401) {
      print("zzzz");
      if (Get.currentRoute != AppRoute.loginPageUrl) {
        CacheProvider.setAppToken(null);
        Get.offAllNamed(AppRoute.loginPageUrl);
        CustomToasts.ErrorDialog(err.response?.data['status'] ?? "relogin");
      }
      // CustomToasts.ErrorDialog("relogin".tr);
    } else if (err.response?.statusCode == 422) {
      String? error = err.response?.data['message'] ?? "wrong_request";
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: error!.tr,
        ),
      );
    } else if (err.response?.statusCode == 403) {
      try {
        String? error = err.response?.data['error'] ?? "wrong_request";
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: error!.tr,
          ),
        );
      } catch (e) {
        print(err.message);
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'wrong_request'.tr,
          ),
        );
      }
    } else {
      // String? error = err.response?.data['message'] ?? "wrong_request";
      if (err.response?.data == null) {
        print("********");
        if (!isNointernet) {
          isNointernet = true;
          return handler.next(
            DioException(
              requestOptions: err.requestOptions,
              message: 'no_internet'.tr,
            ),
          );
        }
        return;
      }
      print(err.response?.data);
      late final resp;
      if (err.response?.data is String) {
        resp = jsonDecode(err.response?.data) ?? "";
      } else {
        resp = err.response?.data;
      }

      var message;
      if (resp is Map) {
        var firstkey = resp.keys.first;
        var firstList = resp[firstkey] ?? [];
        print('*************************************');
        print(firstList);
        print(resp);
        print('*************************************');
        message = firstList is String ? firstList : firstList.first;
      }

      print(message);
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: message ?? "wrong_request",
        ),
      );
    }
  }
}
