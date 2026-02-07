import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/service/networkchecker.dart';
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
}
