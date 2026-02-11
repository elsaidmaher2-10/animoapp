import 'package:animoapp/core/database/remote/api/apiConsumer.dart';
import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:dio/dio.dart';

class Apiservice extends Apiconsumer {
  final Dio dio;

  Apiservice(this.dio) {
    dio.options.baseUrl = Apiconstant.baseurl;
  }

  @override
  Future post({
    required String path,
    Map<String, dynamic>? queryparam,
    required Object data,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryparam,
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
          e.response?.data ?? "Server error",
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
 Future get({required String path, required Map<String, dynamic> queryparam}) async {
    {
      try {
        final response = await dio.get(path, queryParameters: queryparam);
        return response.data;
      } on DioException catch (e) {
        throw _handleDioError(e);
      }
    }
  }
}
