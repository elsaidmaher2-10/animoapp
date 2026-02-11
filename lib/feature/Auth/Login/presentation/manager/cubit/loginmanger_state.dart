
 class LogincontrollerState {}

final class LogincontrollerInitial extends LogincontrollerState {}

final class LogincontrollerLoading extends LogincontrollerState {}

final class LogincontrollerSuccess extends LogincontrollerState {}

final class LogincontrollerFailure extends LogincontrollerState {
  LogincontrollerFailure({required this.message});
  String message;
}
