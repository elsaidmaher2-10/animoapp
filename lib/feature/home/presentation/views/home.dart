import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_cubit.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/AnimalWidget.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/Animalcategory.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/HomepageAnimalList.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/Homepageappbar.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/Homepagecategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  Home({required this.onTap, required this.onTap2});
  Function()? onTap;
  Function()? onTap2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: ColorManger.kprimary,
        backgroundColor: Colors.white,
        onRefresh: () {
          return context.read<CategorycontrollerCubit>().getAllcategory();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Homepageappbar(),
              Homepagecategory(onTap: onTap),
              HomepageAnimalList(),
              Animalcategory(ontap: onTap2),
              AnimalWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
