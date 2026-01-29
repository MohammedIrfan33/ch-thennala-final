import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/rewardStatus/Hundered_Club.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utils/colors.dart';
import '../controller/TopReportController.dart';
import '../main.dart';
import '../rewardStatus/ThreeHundred_Club.dart';
import '../rewardStatus/Twohundred_Club.dart';
import '../widgets/PorgressIndicator.dart';

class TopReport extends StatefulWidget {
  final Function(int)? onTabChange;
  TopReport({required this.onTabChange});

  @override
  State<TopReport> createState() => _TopClubsState();
}

class _TopClubsState extends State<TopReport>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  final controller = Get.put(TopreportController());

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(117),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 53,
                  height: 53,
                  margin: const EdgeInsets.all(8),
                  // decoration: ShapeDecoration(
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     side:
                  //     const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  // ),
                  // child: IconButton(
                  //   padding: const EdgeInsets.all(8),
                  //   constraints: const BoxConstraints(),
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   icon: SvgPicture.asset(
                  //     'assets/backarrow_s.svg',
                  //     width: 22,
                  //     height: 22,
                  //     semanticsLabel: 'Example SVG',
                  //   ),
                  // ),
                ),
                const Center(
                  child: Text(
                    'Top Report',
                    style: TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontSize: 14,
                      fontFamily: 'Fontsemibold',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                    textScaleFactor: 1.0,
                  ),
                ),
                Container(
                  width: 53,
                  height: 53,
                  margin: const EdgeInsets.all(8),
                  // decoration: ShapeDecoration(
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     side:
                  //     const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  // ),
                  // child: IconButton(
                  //   padding: const EdgeInsets.all(8),
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   icon: SvgPicture.asset(
                  //     'assets/home.svg',
                  //     width: 18,
                  //     height: 20,
                  //     semanticsLabel: 'Example SVG',
                  //   ),
                  // ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  // Selected tab text color
                  //isScrollable: true, // Enables horizontal scrolling
                  unselectedLabelColor: Colors.transparent,
                  // Unselected tab text color
                  controller: _tabController,
                  labelPadding: EdgeInsets.only(right: 12),

                  // Tab indicator size
                  indicatorWeight: 0,
                  indicator: GradientTabIndicator(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor2, AppColors.primaryColor],
                    ),

                    thickness: 2.2,
                    radius: 90.0, // Adjust as needed
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Contributors",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Ward",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),

                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Panchayat",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Organisation",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.fullConstituency();
    controller.fullPanchayt();
    controller.fullorganisation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Obx(
        () => TabBarView(
          controller: _tabController,
          children: [
            ////////////first tab>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading4.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.contributorsList.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.contributorsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                height: 84,
                                decoration: ShapeDecoration(
                                  color: AppColors.primaryColor3,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 41,
                                          height: 40,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/topvolunteer.svg",
                                              ),
                                              Positioned(
                                                left: 17,
                                                right: 0,
                                                bottom: 0,
                                                top: 12,
                                                child: Text(
                                                  index < 3
                                                      ? (index + 1).toString()
                                                      : "",
                                                  style: TextStyle(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 6.0,
                                            ),
                                            child: Text(
                                              controller
                                                  .contributorsList[index]
                                                  .name,
                                              style: const TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              '₹ ${controller.contributorsList[index].amount.replaceAll(".00", "")}',
                                              style: const TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
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
            ),

            ////////////second tab>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading1.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.assemblylist.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.assemblylist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // String value=controller.assemblylist[index].amount;
                                // int? amount = int.tryParse(value);
                                //
                                // if (amount == null) return; // Handle invalid numbers safely
                                //
                                // StatefulWidget? page =
                                // // (amount >= 50 && amount < 100) ? FiftyClub(name: controller.assemblylist[index].name,) :
                                // // (amount >= 100 && amount < 150) ? HundredClub(name: controller.assemblylist[index].name,) :
                                // // (amount >= 150 && amount < 200) ? OnefiftyClub(name: controller.assemblylist[index].name,) :
                                // (amount >= 100 && amount < 200) ? HunderedClub(name: controller.assemblylist[index].name,name_panchayath: controller.assemblylist[index].panchayat,) :
                                // (amount >= 200 && amount < 300) ? TwohundredClub(name: controller.assemblylist[index].name,name_panchayath: controller.assemblylist[index].panchayat,) :
                                //
                                // (amount >= 300) ? ThreehundredClub(name: controller.assemblylist[index].name,name_panchayath: controller.assemblylist[index].panchayat,) :
                                // null;
                                //
                                // if (page != null) {
                                //   Get.to(page);
                                // }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                child: Container(
                                  height: 84,
                                  decoration: ShapeDecoration(
                                    color: AppColors.primaryColor3,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 41,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/topvolunteer.svg",
                                                ),
                                                Positioned(
                                                  left: 17,
                                                  right: 0,
                                                  bottom: 0,
                                                  top: 12,
                                                  child: Text(
                                                    index < 3
                                                        ? (index + 1).toString()
                                                        : "",
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 6.0,
                                              ),
                                              child: Text(
                                                controller
                                                    .assemblylist[index]
                                                    .name,
                                                style: const TextStyle(
                                                  color: Color(0xFF3A3A3A),
                                                  fontSize: 13,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 4,
                                              ),
                                              child: Text(
                                                textAlign: TextAlign.right,
                                                "₹ ${controller.assemblylist[index].amount.replaceAll(".00", "")}",
                                                style: const TextStyle(
                                                  color: Color(0xFF3A3A3A),
                                                  fontSize: 13,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            ////////////third tab>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading2.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.panchayatlist.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.panchayatlist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                height: 84,
                                decoration: ShapeDecoration(
                                  color: AppColors.primaryColor3,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 41,
                                          height: 40,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/topvolunteer.svg",
                                              ),
                                              Positioned(
                                                left: 17,
                                                right: 0,
                                                bottom: 0,
                                                top: 12,
                                                child: Text(
                                                  index < 3
                                                      ? (index + 1).toString()
                                                      : "",
                                                  style: TextStyle(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 6.0,
                                            ),
                                            child: Text(
                                              controller
                                                  .panchayatlist[index]
                                                  .name,
                                              style: const TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              '₹ ${controller.panchayatlist[index].amount.replaceAll(".00", "")}',
                                              style: const TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
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
            ),
            //Last Tab>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading3.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.clublist.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.clublist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                height: 84,
                                decoration: ShapeDecoration(
                                  color: AppColors.primaryColor3,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 41,
                                          height: 40,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/topvolunteer.svg",
                                              ),
                                              Positioned(
                                                left: 17,
                                                right: 0,
                                                bottom: 0,
                                                top: 12,
                                                child: Text(
                                                  index < 3
                                                      ? (index + 1).toString()
                                                      : "",
                                                  style: TextStyle(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 6.0,
                                            ),
                                            child: Text(
                                              controller.clublist[index].name,
                                              style: const TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              '₹ ${controller.clublist[index].amount.replaceAll(".00", "")}',
                                              style: const TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class GradientTabIndicator extends Decoration {
  final Gradient gradient;
  final double thickness;
  final double radius;

  GradientTabIndicator({
    required this.gradient,
    this.thickness = 2.0,
    this.radius = 0.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientPainter(gradient, thickness, radius);
  }
}

class _GradientPainter extends BoxPainter {
  final Gradient gradient;
  final double thickness;
  final double radius;

  _GradientPainter(this.gradient, this.thickness, this.radius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect indicatorRect = Rect.fromLTWH(
      offset.dx,
      configuration.size!.height - thickness,
      configuration.size!.width,
      thickness,
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(indicatorRect)
      ..style = PaintingStyle.fill;

    final RRect roundedRect = RRect.fromRectAndRadius(
      indicatorRect,
      Radius.circular(radius),
    );
    canvas.drawRRect(roundedRect, paint);
  }
}
