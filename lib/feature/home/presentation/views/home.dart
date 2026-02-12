import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/AnimalWidget.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/Animalcategory.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/HomepageAnimalList.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/Homepageappbar.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/Homepagecategory.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Homepageappbar(),
              Homepagecategory(),
              HomepageAnimalList(),
              Animalcategory(),
              AnimalWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
