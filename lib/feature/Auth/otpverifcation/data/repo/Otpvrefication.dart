import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/model/otpsuccesresponse.dart';
import 'package:dartz/dartz.dart';

class Otpvreficationrepo {
  Otpvreficationrepo(this.apiservice);

  Apiservice apiservice;

  Future<Either<Failuerresponse, OtpSuccessResponse>> checkotpvalidation({
    required String email,
    required String otpcode,
  }) async {
    final hasInternet = await Networkchecker.checkinternet();
    if (!hasInternet) {
      return left(
        Failuerresponse(error: ["No internet connection"], statusCode: 0),
      );
    }

    try {
      final response = await apiservice.post(
        path: Apiconstant.otpverifayendpoint,
        data: {"email": email, "code": otpcode},
      );

      return right(OtpSuccessResponse.fromJson(response));
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

  Future<Either<Failuerresponse, OtpSuccessResponse>>
  requestnewotpverficationcode({required String email}) async {
    final hasInternet = await Networkchecker.checkinternet();
    if (!hasInternet) {
      return left(
        Failuerresponse(error: ["No internet connection"], statusCode: 0),
      );
    }

    try {
      final response = await apiservice.post(
        path: Apiconstant.newotpverficationcode,
        data: {"email": email},
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
