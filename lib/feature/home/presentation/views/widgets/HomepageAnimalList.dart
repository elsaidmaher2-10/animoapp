import 'dart:developer';
import 'dart:math' show min;

import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/database/remote/api/apiservice.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/routes/routesname.dart';
import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';
import 'package:animoapp/feature/home/data/repo/CategoryRepo.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_cubit.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_state.dart';
import 'package:animoapp/feature/home/presentation/views/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageAnimalList extends StatelessWidget {
  HomepageAnimalList({super.key});
  List<Category> allcategory = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CategorycontrollerCubit>()..getAllcategory(),
      child: Builder(
        builder: (BuildContext context) =>
            BlocBuilder<CategorycontrollerCubit, CategorycontrollerState>(
              builder: (context, state) {
                log(state.toString());
                if (state is GetCategorycontrollerSuccess) {
                  allcategory = state.resposne.category;
                }
                return Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, indx) {
                        return indx == allcategory.length
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40.0,
                                  horizontal: 10,
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    backgroundColor: Color(0xff155F45),
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteName.seeAll,
                                    );
                                  },
                                  child: Text("See All"),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  context
                                      .read<CategorycontrollerCubit>()
                                      .EditCateogry(allcategory[indx]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => CategoryScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                allcategory[indx].imagepath,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 0,
                                          right: -10,
                                          child: Badge.count(
                                            padding: EdgeInsets.all(6),
                                            count: 10,
                                            backgroundColor:
                                                ColorManger.kprimary,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Text(
                                      maxLines: 1,
                                      allcategory[indx].description.substring(
                                        0,
                                        min(
                                          10,
                                          allcategory[indx].description.length,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: ColorManger.black,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                      separatorBuilder: (ctx, index) => SizedBox(width: 12.w),
                      itemCount: allcategory.length + 1,
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
