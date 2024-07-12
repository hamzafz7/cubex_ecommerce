import 'package:dio/dio.dart';

import '../../constants/end_points.dart';
import '../local/cache_provider.dart';
import 'interceptor.dart';

class ApiProvider {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        baseUrl: EndPoints.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          "Authorization": CacheProvider.getAppToken(),
          "lang": CacheProvider.getAppLocale()
        },
      ),
    );
    dio!.interceptors.add(
      AppInterceptors(
        dio: dio,
      ),
    );
  }

  static Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    String token = "",
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
      "lang": CacheProvider.getAppLocale()
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    Object? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
      "lang": CacheProvider.getAppLocale()
    };

    return await dio!.post(
      url,
      queryParameters: query,
      data: body,
    );
  }

  static Future<Response> patch({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
      "lang": CacheProvider.getAppLocale()
    };
    return await dio!.patch(
      url,
      queryParameters: query,
      data: body,
    );
  }

  static Future<Response> put({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
      "lang": CacheProvider.getAppLocale()
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: body,
    );
  }

  static Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
      "lang": CacheProvider.getAppLocale()
    };
    return await dio!.delete(
      url,
      queryParameters: query,
      data: body,
    );
  }
}
