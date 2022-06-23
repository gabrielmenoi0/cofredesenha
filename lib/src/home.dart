import 'package:cofredesenha/src/password/selectType.dart';
import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/src/home/profile.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  int segmentedControlValue = 0;
  int _pageIndex = 0;
  late PageController _pageController;


  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex);
    super.initState();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
              icon: Icon(Icons.home_outlined,color: _pageIndex != 0
                  ? DefaultColors.darkColor0
                  : DefaultColors.primaryColor),
              title: 'Home'),
          TabItem(
              icon: Icon(Icons.add,color: _pageIndex != 1  ? Colors.white : Colors.white),
          ),
          TabItem(
              icon: Icon(Icons.person_outline,color: _pageIndex != 2
                  ? DefaultColors.darkColor0
                  : DefaultColors.primaryColor),
              title: 'Perfil'),

        ],
        initialActiveIndex: _pageIndex,
        style: TabStyle.fixedCircle,
        onTap: (page) => onPageChanged(page),
        backgroundColor: Colors.white,
        activeColor: DefaultColors.secondaryColor,
        color: DefaultColors.darkColor0,
        elevation: 10,
      ),
      body: PageView(
        children: [
        ViewPassword(),
        SelectType(),
        ProfileView(),
      ],
        controller: _pageController,
        onPageChanged: (page) => onPageChanged(page),
        physics: const NeverScrollableScrollPhysics(),
      ),
    );

  }


  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
      _pageController.jumpToPage(page);
    });
  }
}


