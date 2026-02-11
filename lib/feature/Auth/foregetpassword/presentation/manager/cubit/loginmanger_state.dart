
 class ForgeppassordcontrollerState {}

final class ForgeppassordcontrollerInitial extends ForgeppassordcontrollerState {}

final class ForgeppassordcontrollerLoading extends ForgeppassordcontrollerState {}

final class ForgeppassordcontrollerSuccess extends ForgeppassordcontrollerState {}

final class ForgeppassordcontrollerFailure extends ForgeppassordcontrollerState {
  ForgeppassordcontrollerFailure({required this.message});
  String message;
}
