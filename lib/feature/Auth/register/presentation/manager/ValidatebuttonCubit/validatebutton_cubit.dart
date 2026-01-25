import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatebuttonCubit extends Cubit<bool> {
  ValidatebuttonCubit() : super(true);

  buttonreq() async {
    emit(!state);
    await Future.delayed(Duration(seconds: 2));
  }
}
