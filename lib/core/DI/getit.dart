import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/Login/data/repo/Loginrepo.dart';
import 'package:animoapp/feature/Auth/foregetpassword/data/repo/forgetpassword.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/repo/Otpvrefication.dart';
import 'package:animoapp/feature/Auth/register/data/repo/SignupRepo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void setupgetit() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Apiservice>(Apiservice(getIt<Dio>()));
  getIt.registerSingleton<Networkchecker>(Networkchecker());
  getIt.registerSingleton<SignupRepo>(
    SignupRepo(
      service: getIt<Apiservice>(),
      networkChecker: getIt<Networkchecker>(),
    ),
  );
  getIt.registerSingleton<Otpvreficationrepo>(
    Otpvreficationrepo(getIt<Apiservice>()),
  );
  getIt.registerSingleton<Loginrepo>(Loginrepo(getIt<Apiservice>()));
  getIt.registerSingleton<Forgepasswordrepo>(
    Forgepasswordrepo(getIt<Apiservice>()),
  );
}
