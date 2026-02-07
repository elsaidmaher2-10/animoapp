import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/function/errorvalidator.dart';
import 'package:animoapp/feature/Auth/register/data/models/userResponsemodel.dart';
import 'package:animoapp/feature/Auth/register/data/models/usermodel.dart';
import 'package:animoapp/feature/Auth/register/data/repo/SignupRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'signupcontroller_state.dart';

class SignupcontrollerCubit extends Cubit<SignupcontrollerState> {
  SignupcontrollerCubit() : super(SignupcontrollerInitial());
  SignupRepo repo = getIt<SignupRepo>();
  void signupfunc(Usermodel user) async {
    emit(Signupcontrollerloading());
    await Future.delayed(Duration(seconds: 2));
    Either<Failuerresponse, Userresponsemodel> response = await repo.signup(
      user,
    );
    response.fold((e) {
      return emit(Signupcontrollerfailure(message: errorvalidator(e)));
    }, (r) => emit(Signupcontrollersucess()));
  }
}
