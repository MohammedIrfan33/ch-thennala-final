import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/modles/NewAssemblyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/screens/OrderUpdateScreen.dart';
import 'package:chcenterthennala/widgets/my_textfield.dart';
import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../controller/ChallengehistoryController.dart';
import '../controller/NewInnerpageController.dart';
import '../controller/NewReportController.dart';
import '../main.dart';
import '../modles/AssembelyModel.dart';
import '../modles/ClubModel.dart';
import '../modles/DistrictModel.dart';
import '../modles/PanchayatModel.dart';
import '../modles/WardModel.dart';
import '../widgets/PorgressIndicator.dart';
import 'package:http/http.dart' as http;

import 'ReceiptDownloadpage.dart';
import 'ReceiptPageContribution.dart';
import '../Utils/colors.dart';

class Newreportinnerpage extends StatefulWidget {
  String panyathID;
  String wardID;

  Newreportinnerpage({required this.panyathID, required this.wardID});

  @override
  State<Newreportinnerpage> createState() => HistoryState();
}

class HistoryState extends State<Newreportinnerpage> {
  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 53,
                height: 53,
                margin: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    'assets/backarrow_s.svg',
                    width: 22,
                    height: 22,
                    semanticsLabel: 'Example SVG',
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Detailed Report',
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
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: () {
                    goBackTwoPages();
                  },
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    width: 18,
                    height: 20,
                    semanticsLabel: 'Example SVG',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.fullproducts(widget.panyathID, widget.wardID);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.fullproducts(widget.panyathID, widget.wardID);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
  }

  var controller = Get.put(Newinnerpagecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Container(
                      height: 45,
                      width: 45,
                      child: ProgressINdigator(),
                    ),
                  );
                } else if (controller.callengepartisipationlist.isEmpty) {
                  return const Center(child: Text('No entries to show'));
                } else {
                  return ListView.builder(
                    itemCount: controller.callengepartisipationlist.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: AlignmentDirectional.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(8),

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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 8,
                                    top: 20,
                                  ),
                                  width: 43,
                                  height: 51,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller
                                              .callengepartisipationlist[index]
                                              .day,
                                          style: const TextStyle(
                                            color: Color(0xFF3A3A3A),
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                        Text(
                                          controller
                                              .callengepartisipationlist[index]
                                              .month,
                                          style: const TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 9,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Text(
                                              'Name   :',
                                              style: TextStyle(
                                                color: Color(0xFF3A3A3A),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w900,
                                                height: 0,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller
                                                    .callengepartisipationlist[index]
                                                    .name,
                                                style: TextStyle(
                                                  color: Color(0xFF3A3A3A),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w900,
                                                  height: 0,
                                                ),
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'District : ',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(
                                                      controller
                                                          .callengepartisipationlist[index]
                                                          .district,
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      textAlign: TextAlign.left,
                                                      'Assembly : ',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(
                                                      controller
                                                          .callengepartisipationlist[index]
                                                          .assembly,
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Panchayat : ',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(
                                                      controller
                                                          .callengepartisipationlist[index]
                                                          .panchayat,
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      textAlign: TextAlign.left,
                                                      'Ward   :  ',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(
                                                      controller
                                                          .callengepartisipationlist[index]
                                                          .ward,
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 40,
                            top: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 72,

                                  child: AutoSizeText(
                                    "₹${controller.callengepartisipationlist[index].amount.trim().replaceAll(".00", "")}",
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: 0.91,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 06,
                                    maxFontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  width: 72,

                                  child: AutoSizeText(
                                    "${controller.callengepartisipationlist[index].time}",
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                      letterSpacing: 0.91,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 06,
                                    maxFontSize: 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == 1);
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

enum whichToclear { district, assembly, panchayt, ward }
