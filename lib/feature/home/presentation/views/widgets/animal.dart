import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/function/snackbarshowerror.dart';
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:animoapp/core/widget/customtextfromfield.dart';
import 'package:animoapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/showmodalbottomsheetimage.dart';
import 'package:animoapp/feature/Auth/register/presentation/views/widget/uploadimage.dart';
import 'package:animoapp/feature/home/data/models/CategorySuccessResponse.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_cubit.dart';
import 'package:animoapp/feature/home/presentation/manager/cubit/categorycontroller_state.dart';
import 'package:animoapp/feature/home/presentation/views/category.dart';
import 'package:animoapp/feature/home/presentation/views/mainscreen.dart';
import 'package:animoapp/feature/home/presentation/views/widgets/homebutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AnimalScreen extends StatefulWidget {
  AnimalScreen({super.key, required this.generateListStringAnimal});

  List<Category> generateListStringAnimal;

  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

TextEditingController animalNameController = TextEditingController();
TextEditingController animalDescController = TextEditingController();
StreamController<bool> streamController = StreamController.broadcast();
String? animalImage;

class _AnimalScreenState extends State<AnimalScreen> {
  bool isvalid = false;

  @override
  void initState() {
    animalNameController.addListener(isvalidc);
    animalDescController.addListener(isvalidc);
    super.initState();
  }

  void isvalidc() {
    isvalid =
        animalNameController.text.isNotEmpty &&
        animalDescController.text.isNotEmpty &&
        animalNameController.text.length > 12 &&
        animalDescController.text.length > 100;

    streamController.add(isvalid);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<CategorycontrollerCubit>()),
        BlocProvider(create: (context) => SingupCubit()),
      ],
      child: Builder(
        builder: (context) {
          return BlocConsumer<CategorycontrollerCubit, CategorycontrollerState>(
            listener: (context, state) async {
              if (state is CategorycontrollerFailure) {
                AppSnackBar.show(
                  context: context,
                  message: state.failuerresponse,
                  onRetry: () {},
                );
              }

              if (state is CategorycontrollerSuccess) {
                AppSnackBar.show(
                  context: context,
                  message: state.resposne.message,
                  onRetry: () {},
                );

                if (!mainscreen.currentState!.stream.isClosed) {
                  mainscreen.currentState!.stream.add(0);
                }
              }
              if (state is Categorycontrollerdeleted) {
                AppSnackBar.show(
                  context: context,
                  message: state.message,
                  onRetry: () {},
                );

                if (!mainscreen.currentState!.stream.isClosed) {
                  mainscreen.currentState!.stream.add(0);
                }
              }
            },
            builder: (context, state) {
              log(state.toString());
              if (state is CategorycontrollerEdit) {
                // animalImage = state.animal.imagepath;
                // animalDescController.text = state.animal.description;
                // animalNameController.text = state.animal.name;
              }
              bool isasync = false;
              if (state is CategorycontrollerLoading) {
                isasync = true;
              } else {
                isasync = false;
              }
              return ModalProgressHUD(
                inAsyncCall: false,
                blur: 15,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 15,
                  color: ColorManger.kprimary,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 18.w,
                      vertical: 9.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            constantManager.createnewanimal,
                            style: TextStyle(
                              fontSize: screeutilsManager.s20,
                              color: ColorManger.kprimary,
                              fontFamily: FontFamily.Otama_ep,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                backgroundImage: AssetImage(
                                  AssetValueManager.profile,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "El-said Maher",
                                    style: TextStyle(
                                      fontSize: screeutilsManager.s12,
                                      color: ColorManger.black,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),

                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        screeutilsManager.r8,
                                      ),
                                      color: ColorManger.klightgreen
                                          .withOpacity(0.03),
                                    ),

                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.public,
                                          color: ColorManger.klightgreen,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          constantManager.public,
                                          style: TextStyle(
                                            color: ColorManger.klightgreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screeutilsManager.h20),
                          AnimalField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return constantManager.animaldeschint;
                              }
                              if (value.length <= 12) {
                                return "Value must be 12 char";
                              }
                              return null;
                            },
                            controller: animalNameController,
                            maxlines: 1,
                            text: constantManager.AnimalName,
                            hinttext: constantManager.animalnamehint,
                          ),
                          SizedBox(height: screeutilsManager.h20),
                          AnimalField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return constantManager.animaldeschint;
                              }
                              if (value.length < 100) {
                                return "Value must be More Than char";
                              }
                              return null;
                            },
                            controller: animalDescController,
                            maxlines: 3,
                            text: constantManager.animaldesc,
                            hinttext: constantManager.animaldeschint,
                          ),
                          SizedBox(height: screeutilsManager.h20),
                          Builder(
                            builder: (BuildContext context) => Uploadimage(
                              edit: state is CategorycontrollerEdit
                                  ? true
                                  : false,
                              onTap: () {
                                showSignupImageBottomSheet(context);
                              },
                            ),
                          ),
                          SizedBox(height: screeutilsManager.h20),
                          AnimalField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return constantManager.AnimalPrice;
                              }

                              return null;
                            },
                            controller: categroynamecontroller,
                            maxlines: 1,
                            text: constantManager.AnimalPrice,
                            hinttext: constantManager.AnimalPricehint,
                          ),

                          SizedBox(height: screeutilsManager.h20),
                          CategorytabchoiceCheap(
                            generateListStringAnimal:
                                widget.generateListStringAnimal,
                          ),
                          SizedBox(height: screeutilsManager.h20),
                          StreamBuilder(
                            initialData: false,
                            stream: streamController.stream,
                            builder: (context, asyncSnapshot) {
                              return Homebutton(
                                text: state is CategorycontrollerEdit
                                    ? constantManager.edit
                                    : constantManager.add,
                                onPressed: asyncSnapshot.data == true
                                    ? () {
                                        File? image = context
                                            .read<SingupCubit>()
                                            .image;

                                        if (image != null) {}
                                      }
                                    : null,
                              );
                            },
                          ),

                          state is CategorycontrollerEdit
                              ? Homebutton(
                                  text: constantManager.delete,
                                  onPressed: () {
                                    // log(state.animal.id.toString());
                                    // context
                                    //     .read<CategorycontrollerCubit>()
                                    //     .deleteAnimal(state.animal.id);
                                  },
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AnimalField extends StatelessWidget {
  AnimalField({
    super.key,
    required this.hinttext,
    required this.text,
    required this.controller,
    required this.validator,
    this.maxlines = 1,
  });
  String text;
  String hinttext;
  TextEditingController controller;
  int maxlines;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: const Color.fromARGB(255, 60, 60, 60),
            fontSize: screeutilsManager.s16,
          ),
        ),
        SizedBox(height: 6.h),
        CustomTextfromfield(
          validator: validator,
          onChanged: onChanged,
          maxlines: maxlines,
          hinttext: hinttext,
          controller: controller,
        ),
      ],
    );
  }
}

class CategorytabchoiceCheap extends StatefulWidget {
  CategorytabchoiceCheap({super.key, required this.generateListStringAnimal});
  final List<Category> generateListStringAnimal;

  @override
  State<CategorytabchoiceCheap> createState() => _CategorytabchoiceCheapState();
}

class _CategorytabchoiceCheapState extends State<CategorytabchoiceCheap> {
  @override
  int curidnex = -1;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.generateListStringAnimal.length,
        (index) => Padding(
          padding: EdgeInsets.all(5),

          child: InkWell(
            onTap: () {
              curidnex = index;
              setState(() {});
            },
            child: ChoiceChip(
              backgroundColor: curidnex == index
                  ? ColorManger.kprimary
                  : ColorManger.white,
              selectedColor: ColorManger.white,
              label: Text(
                widget.generateListStringAnimal[index].name,
                style: TextStyle(
                  color: curidnex == index
                      ? ColorManger.white
                      : ColorManger.black,
                ),
              ),
              selected: false,
              onSelected: (value) {
                curidnex = index;
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
