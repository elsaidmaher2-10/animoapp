import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/service/networkchecker.dart';
import 'package:animoapp/feature/Auth/Login/data/repo/Loginrepo.dart';
import 'package:animoapp/feature/Auth/foregetpassword/data/repo/forgetpassword.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/repo/Otpvrefication.dart';
import 'package:animoapp/feature/Auth/register/data/repo/SignupRepo.dart';
import 'package:animoapp/feature/home/data/repo/CategoryRepo.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void setupgetit() {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerLazySingleton<CategorycontrollerCubit>(
    () =>
        CategorycontrollerCubit(Categoryrepo(apiservice: getIt<Apiservice>())),
  );
  getIt.registerSingleton<GlobalKey<NavigatorState>>(
    instanceName: constantManager.seeAllKey,
    GlobalKey<NavigatorState>(),
  );
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
