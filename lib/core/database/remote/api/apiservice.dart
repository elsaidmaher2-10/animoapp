import 'package:animoapp/core/database/local/sharedprefrence/sharedprefmanager.dart';
import 'package:animoapp/core/database/remote/api/apiConsumer.dart';
import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/home/presentation/views/mainscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class Apiservice extends Apiconsumer {
  final Dio dio;

  Apiservice(this.dio) {
    dio.options.baseUrl = Apiconstant.baseurl;
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onError: __onerror,
        onRequest: (options, handler) {
          var opts = options;
          if (SharedPrefManager().getString("access_token") != null) {
            opts.headers["Authorization"] =
                "Bearer ${SharedPrefManager().getString("access_token")}";
          }
          handler.next(options);
        },
      ),
      LogInterceptor(
        request: true,
        requestUrl: true,
        responseBody: true,
        error: true,
      ),
    ]);
  }

  @override
  Future post({
    required String path,
    Map<String, dynamic>? queryparam,
    required Object data,
  }) async {
    try {
      final response = await dio.post(
        options: Options(headers: queryparam),
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Serverexpctionmodel _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Serverexpctionmodel("Connection timeout", 408);

      case DioExceptionType.sendTimeout:
        return Serverexpctionmodel("Send timeout", 408);

      case DioExceptionType.receiveTimeout:
        return Serverexpctionmodel("Receive timeout", 408);

      case DioExceptionType.badResponse:
        return Serverexpctionmodel(
          e.response?.data as Map? ?? "Server error",
          e.response?.statusCode ?? 500,
        );
      case DioExceptionType.cancel:
        return Serverexpctionmodel("Request was cancelled", 499);

      case DioExceptionType.connectionError:
        return Serverexpctionmodel("No internet connection", 503);

      case DioExceptionType.unknown:
      default:
        return Serverexpctionmodel("Unexpected error occurred", 500);
    }
  }

  @override
  Future get({required String path, Map<String, dynamic>? queryparam}) async {
    {
      try {
        final response = await dio.get(path, queryParameters: queryparam);
        return response.data;
      } on DioException catch (e) {
        throw _handleDioError(e);
      }
    }
  }

  __onerror(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      if (error.requestOptions.extra["retry"] == true) {
        handler.next(error);
        return;
      }

      bool refreshed = await _fetchNewAccessToken();

      if (refreshed) {
        final opts = error.requestOptions;
        opts.extra["retry"] = true;

        final accessToken = SharedPrefManager().getString('access_token');

        opts.headers['Authorization'] = 'Bearer $accessToken';

        final cloneReq = await dio.request(
          opts.path,
          options: Options(method: opts.method, headers: opts.headers),
          data: opts.data,
          queryParameters: opts.queryParameters,
        );

        handler.resolve(cloneReq);
        return;
      } else {
        SharedPrefManager().remove("access_token");
        SharedPrefManager().remove("refresh_token");
        var context = mainscreen.currentContext;

        handler.next(error);
        if (context != null) {
          Navigator.pushNamed(context, RouteName.login);
        }
        return;
      }
    }

    handler.next(error);
  }

  Future<bool> _fetchNewAccessToken() async {
    String? refreshToken = SharedPrefManager().getString("refresh_token");

    if (refreshToken == null) return false;
    Dio dio = Dio(BaseOptions(baseUrl: Apiconstant.baseurl));
    try {
      final response = await dio.post(
        options: Options(headers: {'refresh_token': refreshToken}),
        Apiconstant.newAccessToken,
      );

      final newAccessToken = response.data['access_token'];
      if (newAccessToken != null) {
        SharedPrefManager().setString("access_token", newAccessToken);
        return true;
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }



  @override
  delete({
    required String path,
    required Map<String, dynamic>? queryparam,
  }) async {
    try {
      final response = await dio.delete(queryParameters: queryparam, path);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}

