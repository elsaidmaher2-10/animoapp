part of 'categorycontroller_cubit.dart';

sealed class CategorycontrollerState {}

final class CategorycontrollerInitial extends CategorycontrollerState {}

final class CategorycontrollerSuccess extends CategorycontrollerState {
  Categorysuccessresponse resposne;
  CategorycontrollerSuccess(this.resposne);
}

final class CategorycontrollerFailure extends CategorycontrollerState {
  String failuerresponse;
  CategorycontrollerFailure(this.failuerresponse);
}

final class CategorycontrollerLoading extends CategorycontrollerState {}
