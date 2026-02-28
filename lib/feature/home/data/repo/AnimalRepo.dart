import 'package:animoapp/core/database/local/sharedprefrence/sharedprefmanager.dart';
import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';
import 'package:animoapp/feature/home/data/models/categorymodel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Animalrepo {
  Apiservice apiservice;

  Animalrepo({required this.apiservice});

  Future<Either<Failuerresponse, Categorysuccessresponse>> createNewAnimal(
    Categorymodel animalmodel,
    bool isedit,
  ) async {
    if (!await Networkchecker.checkinternet()) {
      return left(
        Failuerresponse(
          error: [constantManager.Nointernetconnection],
          statusCode: 1,
        ),
      );
    }
    try {
      String token = SharedPrefManager().getString("access_token") ?? "";
      final response = await apiservice.post(
        path: isedit == true
            ? Apiconstant.updateAnimal
            : Apiconstant.addNewAnimal,
        data: FormData.fromMap({
          "name": animalmodel.name,
          "description": animalmodel.description,
          "image": await MultipartFile.fromFile(
            animalmodel.image.path,
            filename: animalmodel.image.path.split("/").last,
          ),
        }),
        queryparam: {"Authorization": "bearer $token"},
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

  Future<Either<Failuerresponse, String>> deleteAnimal(int id) async {
    if (!await Networkchecker.checkinternet()) {
      return left(
        Failuerresponse(
          error: [constantManager.Nointernetconnection],
          statusCode: 1,
        ),
      );
    }
    try {
      final response = await apiservice.delete(
        path: Apiconstant.deleteAnimal,
        queryparam: {"id": id.toString()},
      );

      return right(response["message"]);
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

  Future<Either<Failuerresponse, GetCategorysuccessresponse>>
  getAllAnimal() async {
    if (!await Networkchecker.checkinternet()) {
      return left(
        Failuerresponse(
          error: [constantManager.Nointernetconnection],
          statusCode: 1,
        ),
      );
    }
    try {
      final response = await apiservice.get(path: Apiconstant.getAllAnimal);

      return right(GetCategorysuccessresponse.fromjson(response));
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
