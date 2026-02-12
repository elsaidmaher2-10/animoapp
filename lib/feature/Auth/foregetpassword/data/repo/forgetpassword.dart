import 'package:animoapp/core/database/remote/api/apiconstant.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/database/remote/error/forgetpassworderro.dart';
import 'package:animoapp/core/database/remote/error/serverExpctionmodel.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/foregetpassword/data/models/foregetpasswordresponse.dart';
import 'package:dartz/dartz.dart';

class Forgepasswordrepo {
  Apiservice apiservice;

  Forgepasswordrepo(this.apiservice);

  Future<Either<Forgetpassworderror, Forgetpassworduccesresponse>>
  forgetPassword({required email}) async {
    if (!await Networkchecker.checkinternet()) {
      return left(Forgetpassworderror(error: "No internet connection"));
    }
    try {
      final response = await apiservice.post(
        path: Apiconstant.forgetPasswordendpoint,
        data: {"email": email},
      );

      return right(Forgetpassworduccesresponse.fromjosn(response));
    } on Serverexpctionmodel catch (e) {
      if (e.message is Map) {
        Forgetpassworderror error = Forgetpassworderror.fromjson(
          e.message as Map,
        );
        return left(error);
      } else {
        return left(Forgetpassworderror(error: e.message.toString()));
      }
    } catch (e) {
      return left(Forgetpassworderror(error: e.toString()));
    }
  }
}
