import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:chcenterthennala/screens/TopSponsors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:chcenterthennala/screens/homepage3.dart';

import '../main.dart';
import 'HistoryScreen.dart';
import 'Homepage.dart';
import 'Homepage2.dart';
import 'MyHistory.dart';
import 'Reportpage.dart';
import 'TopReports.dart';
import 'newReport.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with RouteAware {
  @override
  void didPopNext() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomBarPages = [
      Homepage2(),
      Historyscreen(
        uniqueid: AppData.uniqueid,
        GlobalId: AppData.volunteerId,
        onTabChange: (index) {
          pageController.jumpToPage(index);
          botController.jumpTo(index);
        },
      ),
      Myhistory(
        identifier: AppData.uniqueid,
        onTabChange: (index) {
          pageController.jumpToPage(index);
          botController.jumpTo(index);
        },
      ),
      Newreport(
        uniqueid: AppData.uniqueid,
        GlobalId: AppData.volunteerId,
        onTabChange: (index) {
          pageController.jumpToPage(index);
          botController.jumpTo(index);
        },
      ),
      TopReport(
        onTabChange: (index) {
          pageController.jumpToPage(index);
          botController.jumpTo(index);
        },
      ),
    ];
  }

  int maxCount = 5;
  PageController pageController = PageController(initialPage: 0);
  NotchBottomBarController botController = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  void changeTab(int index) {
    pageController.jumpToPage(index);
  }

  /// widget list
  late List<Widget> bottomBarPages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      extendBody: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              bottomBarWidth: double.infinity,
              bottomBarHeight: 52.0,

              /// Provide NotchBottomBarController
              notchBottomBarController: botController,
              color: AppColors.primaryColor,
              showLabel: true,
              circleMargin: 6,
              textOverflow: TextOverflow.visible,
              showBottomRadius: false,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 0,
              notchGradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryColor2, AppColors.primaryColor],
              ),

              /// restart app if you change removeMargins
              removeMargins: true,
              showShadow: false,
              durationInMilliSeconds: 300,

              elevation: 1,
              bottomBarItems: [
                BottomBarItem(
                  itemLabelWidget: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  inActiveItem: Image.asset(
                    "assets/home/home.png",
                    color: Colors.white,
                  ),
                  activeItem: Image.asset(
                    "assets/home/home.png",
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  itemLabelWidget: Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  inActiveItem: Image.asset(
                    "assets/home/transaction.png",
                    color: Colors.white,
                  ),
                  activeItem: Image.asset(
                    "assets/home/transaction.png",
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  itemLabelWidget: Text(
                    'My History',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  inActiveItem: Image.asset(
                    "assets/home/myhistory.png",
                    color: Colors.white,
                  ),
                  activeItem: Image.asset(
                    "assets/home/myhistory.png",
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  itemLabelWidget: Text(
                    'Reports',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                  activeItem: Icon(Icons.person, color: Colors.white, size: 24),
                ),
                BottomBarItem(
                  itemLabelWidget: Text(
                    'Top Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  inActiveItem: SvgPicture.asset(
                    "assets/dashbord/topreport.svg",
                  ),
                  activeItem: SvgPicture.asset("assets/dashbord/topreport.svg"),
                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
