import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';

sealed class CategorycontrollerState {}

final class CategorycontrollerInitial extends CategorycontrollerState {}

final class CategorycontrollerSuccess extends CategorycontrollerState {
  Categorysuccessresponse resposne;
  CategorycontrollerSuccess(this.resposne);
}

final class GetCategorycontrollerSuccess extends CategorycontrollerState {
  GetCategorysuccessresponse resposne;
  GetCategorycontrollerSuccess(this.resposne);
}

final class CategorycontrollerFailure extends CategorycontrollerState {
  String failuerresponse;
  CategorycontrollerFailure(this.failuerresponse);
}

final class CategorycontrollerLoading extends CategorycontrollerState {}

final class Categorycontrollerdeleted extends CategorycontrollerState {
  String message;
  Categorycontrollerdeleted(this.message);
}

final class CategorycontrollerEdit extends CategorycontrollerState {
  bool isEdit;
  Category category;
  CategorycontrollerEdit({required this.isEdit, required this.category});
}
