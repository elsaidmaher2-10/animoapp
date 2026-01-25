import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit() : super(SingupimageInitial());

  imagepickerstate(File? file) {
    print(state);
    if (file == null) {
      emit(Singupimagedosentselected());
      print(state);
    } else {
      emit(Singupimageselected(file));
      print(file);
    }
  }
}
