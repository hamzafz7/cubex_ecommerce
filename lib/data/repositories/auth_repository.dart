// import 'package:dio/dio.dart';

// import '../../common/constants/end_points.dart';
// import '../../common/providers/remote/api_provider.dart';
// import '../models/app_response.dart';

// class AuthRepository {
//   Future<AppResponse> login(Map<String, dynamic> loginBody) async {
//     try {
//       var appResponse =
//           await ApiProvider.post(url: EndPoints.loginApi, body: loginBody);

//       return AppResponse(
//           success: true, data: appResponse.data, errorMessage: null);
//     } on DioException catch (e) {
//       return AppResponse(
//           success: false, data: null, errorMessage: e.message ?? e.toString());
//     }
//   }

//   Future<AppResponse> register(User user) async {
//     print(user.registerUserToJson());
//     try {
//       var appResponse = await ApiProvider.post(
//           url: EndPoints.registerApi, body: user.registerUserToJson());

//       return AppResponse(
//           success: true, data: appResponse.data, errorMessage: null);
//     } on DioException catch (e) {
//       return AppResponse(
//           success: false, data: null, errorMessage: e.message ?? e.toString());
//     }
//   }

//   Future<AppResponse> logOut() async {
//     try {
//       var appResponse = await ApiProvider.post(
//           url: EndPoints.logOutApi, token: CacheProvider.getAppToken());

//       return AppResponse(
//           success: true, data: appResponse.data, errorMessage: null);
//     } on DioException catch (e) {
//       return AppResponse(
//           success: false, data: null, errorMessage: e.message ?? e.toString());
//     }
//   }
// }
