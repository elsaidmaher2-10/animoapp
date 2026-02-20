import 'package:animoapp/core/database/local/sharedprefrence/sharedprefmanager.dart';
import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';
import 'package:animoapp/feature/home/data/models/categorymodel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Categoryrepo {
  Apiservice apiservice;

  Categoryrepo({required this.apiservice});
  Future<Either<Failuerresponse, Categorysuccessresponse>> createNewCategory(
    Categorymodel categorymodel,
  ) async {
    try {
      String token = SharedPrefManager().getString("access_token") ?? "";
      final response = await apiservice.post(
        path: Apiconstant.createNewCategory,
        data: FormData.fromMap({
          "name": categorymodel.name,
          "description": categorymodel.description,
          "image": categorymodel.image,
        }),
        queryparam: {"Authorization": "Bearer $token"},
      );

      return right(Categorysuccessresponse.fromjson(response));
    } on Serverexpctionmodel catch (e) {
      if (e.message is Map) {
        final d = Failuerresponse.fromjson(e.message);
        return left(d);
      } else {
        return left(
          Failuerresponse(
            error: [e.message.toString()],
            statusCode: e.statuscode,
          ),
        );
      }
    } catch (e) {
      return left(Failuerresponse(error: [e.toString()], statusCode: 500));
    }
  }
}
