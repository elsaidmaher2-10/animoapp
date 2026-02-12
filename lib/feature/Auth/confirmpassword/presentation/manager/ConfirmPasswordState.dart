import 'package:animoapp/feature/Auth/otpverifcation/data/model/otpsuccesresponse.dart';

class ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerInitial
    extends ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerLoading
    extends ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerSuccess
    extends ConfirmPasswordControllerState {
  OtpSuccessResponse  message;
  ConfirmPasswordControllerSuccess(this.message);
}

final class ConfirmPasswordControllerFailure
    extends ConfirmPasswordControllerState {
  ConfirmPasswordControllerFailure({required this.message});
  String message;
}
