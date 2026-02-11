import 'package:animoapp/feature/Auth/foregetpassword/data/repo/forgetpassword.dart';
import 'package:animoapp/feature/Auth/foregetpassword/presentation/manager/cubit/loginmanger_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Forgeppassordcontroller extends Cubit<ForgeppassordcontrollerState> {
  Forgeppassordcontroller(this.forgetpasswordrepo)
    : super(ForgeppassordcontrollerInitial());
  Forgepasswordrepo forgetpasswordrepo;
  bool isasync = false;

  forgepassword({required email}) async {
    emit(ForgeppassordcontrollerLoading());
    isasync = true;

    await Future.delayed(Duration(seconds: 2));
    final result = await forgetpasswordrepo.forgetPassword(email: email);
    isasync = false;
    result.fold(
      (e) => emit(ForgeppassordcontrollerFailure(message: e.error)),
      (r) => emit(ForgeppassordcontrollerSuccess()),
    );
  }
}
