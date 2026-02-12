import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/model/otpsuccesresponse.dart';
import 'package:dartz/dartz.dart';

class Confirmpasswordrepo {
  final Apiservice service;
  final Networkchecker networkChecker;
  Confirmpasswordrepo({required this.service, required this.networkChecker});
  Future<Either<Failuerresponse, OtpSuccessResponse>> createnewpassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final hasInternet = await Networkchecker.checkinternet();
    if (!hasInternet) {
      return left(
        Failuerresponse(error: ["No internet connection"], statusCode: 0),
      );
    }

    try {
      final Map<String, dynamic> response = await service.post(
        path: Apiconstant.createnewpassowrdAPIEndpoint,
        data: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      return right(OtpSuccessResponse.fromJson(response));
    } on Serverexpctionmodel catch (e) {
      final d = Failuerresponse.fromjson(e.message as Map);
      return left(Failuerresponse(error: d.error, statusCode: e.statuscode));
    } catch (e) {
      return left(Failuerresponse(error: [e.toString()], statusCode: 500));
    }
  }
}
