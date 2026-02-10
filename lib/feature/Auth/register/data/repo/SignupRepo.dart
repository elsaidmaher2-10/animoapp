import 'dart:io';
import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/register/data/models/userResponsemodel.dart';
import 'package:animoapp/feature/Auth/register/data/models/usermodel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SignupRepo {
  final Apiservice service;
  final Networkchecker networkChecker;

  SignupRepo({required this.service, required this.networkChecker});

  Future<Either<Failuerresponse, Userresponsemodel>> signup(
    Usermodel user,
  ) async {
    final hasInternet = await Networkchecker.checkinternet();
    if (!hasInternet) {
      return left(
        Failuerresponse(error: ["No internet connection"], statusCode: 0),
      );
    }

    try {
      final formData = FormData.fromMap({
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "phone": user.phone,
        "password": user.password,

        "image": await MultipartFile.fromFile(
          user.image.path,
          filename: user.image.path.split("/").last,
        ),
      });
      final Map response = await service.post(
        path: Apiconstant.apiendpoint,
        data: formData,
      );
      return right(Userresponsemodel.fromjson(response));
    } on Serverexpctionmodel catch (e) {
      final d = Failuerresponse.fromjson(e.message as Map);
      return left(Failuerresponse(error: d.error, statusCode: e.statuscode));
    } catch (e) {
      return left(Failuerresponse(error: [e.toString()], statusCode: 500));
    }
  }
}
