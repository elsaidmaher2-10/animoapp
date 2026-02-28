import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';
import 'package:animoapp/feature/home/data/models/categorymodel.dart';
import 'package:animoapp/feature/home/data/repo/CategoryRepo.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorycontrollerCubit extends Cubit<CategorycontrollerState> {
  CategorycontrollerCubit(this.categoryrepo)
    : super(CategorycontrollerInitial());
  List<Category> ofCategory = [];
  Categoryrepo categoryrepo;
  createNewCategory(Categorymodel categorymodel, bool isedit) async {
    emit(CategorycontrollerLoading());
    final response = await categoryrepo.createNewCategory(
      categorymodel,
      isedit,
    );
    response.fold(
      (l) {
        emit(CategorycontrollerFailure(l.error.join()));
      },
      (r) {
        emit(CategorycontrollerSuccess(r));
      },
    );
  }

  deleteCategory(int id) async {
    emit(CategorycontrollerLoading());
    final response = await categoryrepo.deleteCategory(id);
    response.fold(
      (l) {
        emit(CategorycontrollerFailure(l.error.join()));
      },
      (r) {
        emit(Categorycontrollerdeleted(r));
      },
    );
  }

  updategetAllCategory() {
    getAllcategory();
  }

  Future<void> getAllcategory() async {
    emit(CategorycontrollerLoading());
    final result = await categoryrepo.getAllCategory();
    result.fold((l) => emit(CategorycontrollerFailure(l.error.join())), (r) {
      ofCategory = r.category;
      emit(GetCategorycontrollerSuccess(r));
    });
  }

  void EditCateogry(Category allcategory) {
    emit(CategorycontrollerEdit(isEdit: true, category: allcategory));
  }
}
