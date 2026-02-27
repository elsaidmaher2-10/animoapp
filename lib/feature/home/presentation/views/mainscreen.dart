import 'dart:async';
import 'package:animoapp/core/DI/getit.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/feature/home/hometab.dart';
import 'package:animoapp/feature/home/presentation/views/category.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<_MainscreenState> mainscreen = GlobalKey();

class Mainscreen extends StatefulWidget {
  Mainscreen({Key? key}) : super(key: mainscreen);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  StreamController<int> stream = StreamController.broadcast();
  int curindex = 0;

  List<Widget> get screens => [
    Hometab(
      onTap2: () {
        stream.add(3);
      },
      onTap: () {
        stream.add(2);
      },
    ),
    const Center(child: Text("data")),
    const CategoryScreen(),
    const Center(child: Text("data2")),
    const Center(child: Text("data3")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      extendBody: true,
      bottomNavigationBar: StreamBuilder(
        initialData: curindex,
        stream: stream.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: snapshot.data,
                onTap: (index) {
                  if (index == 0) {
                    getIt<GlobalKey<NavigatorState>>(
                      instanceName: constantManager.seeAllKey,
                    ).currentState?.popUntil((route) => route.isFirst);
                  }
                  stream.add(index);
                },
                elevation: 0,
                selectedItemColor: ColorManger.kprimary,
                unselectedItemColor: ColorManger.Lightgrey,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: "Category",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.heart_broken),
                    label: "Animal",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    label: "Me",
                  ),
                ],
              ),
            ),
      ),
      body: StreamBuilder(
        stream: stream.stream,
        builder: (ctx, snap) => screens[snap.data ?? 0],
      ),
    );
  }
}
