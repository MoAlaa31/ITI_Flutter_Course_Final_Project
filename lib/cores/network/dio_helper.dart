import 'package:dio/dio.dart';
import 'package:final_project/cores/network/endpoints.dart';
import 'package:final_project/cores/resources/cache_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SessionManager {
  static String? token;
}

class DioOptionsKeys {
  static const requiresAuth = 'requiresAuth';
}

class DioHelper {
  static Dio? dio;

  static initDio() {
    dio ??= Dio(BaseOptions(receiveDataWhenStatusError: true));
    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth =
              options.extra[DioOptionsKeys.requiresAuth] ?? false;

          if (requiresAuth) {
            String? token = SessionManager.token;
            token ??= await CacheHelper.getToken();

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
      ),
    );
  }

  static Future<Response> getWithAuthRequest({
    required String endPoint,
    Map<String, dynamic>? query,
    bool requiresAuth = false,
  }) async {
    try {
      Response response = await dio!.get(
        endPoint,
        queryParameters: query,
        options: Options(extra: {DioOptionsKeys.requiresAuth: requiresAuth}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio!.get(endPoint, queryParameters: query,);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await dio!.post(endPoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
