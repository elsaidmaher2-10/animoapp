import 'package:animoapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';
import 'package:animoapp/feature/home/data/models/categorymodel.dart';
import 'package:animoapp/feature/home/data/repo/CategoryRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categorycontroller_state.dart';

class CategorycontrollerCubit extends Cubit<CategorycontrollerState> {
  CategorycontrollerCubit(this.categoryrepo)
    : super(CategorycontrollerInitial());

  Categoryrepo categoryrepo;

  createNewCategory(Categorymodel categorymodel) async {
    emit(CategorycontrollerLoading());
    final response = await categoryrepo.createNewCategory(categorymodel);

    response.fold(
      (l) {
        emit(CategorycontrollerFailure(l.error.join()));
      },
      (r) {
        emit(CategorycontrollerSuccess(r));
      },
    );
  }
}
