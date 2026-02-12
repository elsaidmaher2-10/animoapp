import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/database/local/sharedprefrence/sharedprefmanager.dart';
import 'package:animoapp/core/routes/routesmanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/repo/Otpvrefication.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/manager/otpvericationcontroller/otpvericationcontroller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupgetit();
  bool islogin = true;
  await SharedPrefManager().init();
  runApp(MyApp(islogin));
}

class MyApp extends StatelessWidget {
  MyApp(this.islogin, {super.key});

  bool islogin;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  OtpvericationcontrollerCubit(getIt<Otpvreficationrepo>()),
            ),
          ],
          child: MaterialApp(
            initialRoute: islogin ? RouteName.home : RouteName.login,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManager.ongenerate,
          ),
        );
      },
    );
  }
}
