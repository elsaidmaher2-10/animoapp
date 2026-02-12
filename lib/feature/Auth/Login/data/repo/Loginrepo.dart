import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/Login/data/models/loginsuccesresponse.dart';
import 'package:dartz/dartz.dart';

class Loginrepo {
  Apiservice apiservice;

  Loginrepo(this.apiservice);

  Future<Either<Failuerresponse, Loginsuccesresponse>> login({
    required email,
    required password,
  }) async {
    if (!await Networkchecker.checkinternet()) {
      return left(
        Failuerresponse(error: ["No internet connection"], statusCode: 1),
      );
    }
    try {
      final response = await apiservice.get(
        path: Apiconstant.loginendpoint,
        queryparam: {"email": email, "password": password},
      );

      return right(Loginsuccesresponse.fromjosn(response));
    } on Serverexpctionmodel catch (e) {
      final d = Failuerresponse.fromjson(e.message as Map);
      return left(Failuerresponse(error: d.error, statusCode: e.statuscode));
    } catch (e) {
      return left(Failuerresponse(error: [e.toString()], statusCode: 500));
    }
  }
}
