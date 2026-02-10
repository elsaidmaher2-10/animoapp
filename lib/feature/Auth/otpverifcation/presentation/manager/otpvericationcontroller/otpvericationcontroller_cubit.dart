import 'dart:async';

import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/function/errorvalidator.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/model/otpsuccesresponse.dart';
import 'package:animoapp/feature/Auth/otpverifcation/data/repo/Otpvrefication.dart';
import 'package:animoapp/feature/Auth/otpverifcation/presentation/manager/otpvericationcontroller/otpvericationcontroller_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpvericationcontrollerCubit extends Cubit<OtpvericationcontrollerState> {
  final int otpLength = 5;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  Timer? timer;
  int counter = 60;

  final StreamController<int> streamController =
      StreamController<int>.broadcast();

  OtpvericationcontrollerCubit(this.otpvreficationrepo)
    : super(OtpvericationcontrollerInitial());

  Otpvreficationrepo otpvreficationrepo;
  /////////////////////
  otpcontroller({required String email, required String otpcode}) async {
    emit(OtpvericationcontrollerLoading());
    await Future.delayed(Duration(seconds: 3));
    Either<Failuerresponse, OtpSuccessResponse> response =
        await otpvreficationrepo.checkotpvalidation(
          email: email,
          otpcode: otpcode,
        );

    response.fold(
      (e) => emit(OtpvericationcontrollerFailure(errorvalidator(e))),
      (r) => emit(OtpvericationcontrollerSuccess()),
    );
  } //////////////

  requestnewotpcode({required String email}) async {
    Either<Failuerresponse, OtpSuccessResponse> response =
        await otpvreficationrepo.requestnewotpverficationcode(email: email);

    response.fold(
      (e) => emit(OtpvericationcontrollerFailure(errorvalidator(e))),
      (r) => emit(OtpvericationcontrollerSuccess()),
    );
  } //////////////

  void resendcodetimer() {
    counter = 60;
    timer?.cancel();

    if (!streamController.isClosed) {
      streamController.add(counter);
    }

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (counter > 0) {
        counter--;
        if (!streamController.isClosed) {
          streamController.add(counter);
        }
      } else {
        t.cancel();
      }
    });
  }

  void onOtpChanged(String value, int index, context) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      FocusScope.of(
        context,
      ).requestFocus(index != 0 ? focusNodes[index - 1] : focusNodes[0]);
    }
  }

  String getOtpCode() {
    return controllers.map((e) => e.text).join();
  }

  init() {
    {
      controllers = List.generate(otpLength, (_) => TextEditingController());
      focusNodes = List.generate(otpLength, (_) => FocusNode());
    }
  }

  @override
  Future<void> close() {
    for (final c in controllers) {
      c.dispose();
    }

    for (final f in focusNodes) {
      f.dispose();
    }

    timer?.cancel();

    return super.close();
  }
}
