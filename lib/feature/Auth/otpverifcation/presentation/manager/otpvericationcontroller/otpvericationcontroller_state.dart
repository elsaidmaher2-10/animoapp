sealed class OtpvericationcontrollerState {}

final class OtpvericationcontrollerInitial
    extends OtpvericationcontrollerState {}

final class OtpvericationcontrollerLoading
    extends OtpvericationcontrollerState {}

final class OtpvericationcontrollerSuccess
    extends OtpvericationcontrollerState {}

final class OtpvericationcontrollerFailure
    extends OtpvericationcontrollerState {
  String message;

  OtpvericationcontrollerFailure(this.message);
}
