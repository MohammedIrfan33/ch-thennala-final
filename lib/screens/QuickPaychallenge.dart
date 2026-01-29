import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/modles/NewAssemblyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:chcenterthennala/controller/QuickPayChallengecontroller.dart';
import 'package:chcenterthennala/modles/AssembelyModel.dart';
import 'package:chcenterthennala/modles/ChallenegeListModel.dart';
import 'package:chcenterthennala/modles/ClubModel.dart';
import 'package:chcenterthennala/modles/PanchayatModel.dart';
import 'package:chcenterthennala/modles/Sponsorshipmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../Utils/colors.dart';
import '../controller/QuickpayscreenController.dart';
import '../modles/DistrictModel.dart';
import '../modles/WardModel.dart';
import '../widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class Quickpaychallenge extends StatefulWidget {
  final List<Challegelistmodel> modellist;
  final String totalmaount;
  final String challengid;
  final String? volunteer_id;
  final String? showdistrictandassembly;
  String uniqueid;
  bool isChecked2;
  int backcount;

  Quickpaychallenge({
    required this.modellist,
    required this.totalmaount,
    required this.challengid,
    required this.volunteer_id,
    required this.showdistrictandassembly,
    required this.uniqueid,
    this.backcount = 2,
    this.isChecked2 = false,
  });
  @override
  State<Quickpaychallenge> createState() => _QuickpayState();
}

class _QuickpayState extends State<Quickpaychallenge>
    with WidgetsBindingObserver {
  final QuickpayChallagecontroller controller = Get.put(
    QuickpayChallagecontroller(),
  );

  ///////////////////////////////////////////////////////////////

  bool islosding = true;

  Future getshareddata() async {
    controller.uniqueid = widget.uniqueid;
    controller.volunteerid = widget.volunteer_id;
    controller.challengeid = widget.challengid;
    controller.Amount = widget.totalmaount;
    controller.list.assignAll(widget.modellist);
  }

  @override
  void initState() {
    getshareddata();
    controller.orderforothercheck = widget.isChecked2;
    controller.backCount = widget.backcount;
    super.initState();

    controller.fetchClub();
    controller.fetchPanchaythapi(['1']);
    addListnnerFortheTextController();
    addListnnerFortheTextController_C();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    disposetheview();
    super.dispose();
  }
  ////////////////models //////

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
                  'Participate',
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
                    goBackTwoPages(widget.backcount);
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

  void goBackTwoPages(int backcount) {
    int count = 0;
    Get.until((route) => count++ == backcount);
  }

  bool isChecked = false;

  bool isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    double KeyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    IntrinsicWidth(
                      child: Container(
                        padding: EdgeInsets.only(right: 12),
                        height: 66,
                        decoration: BoxDecoration(
                          color: Color(0xFFFBF2F2), // Background color
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.006,
                              ), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: Offset(
                                0,
                                -1,
                              ), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ), // Add padding inside the container
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: Color(0xFFAF252B),
                                size: 36,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${widget.totalmaount.replaceAll(".0", "")}',
                                    style: const TextStyle(
                                      color: Color(0xFFAF252B),
                                      fontSize: 40,
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
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

                    AppData.volunteerId.isNull
                        ? Column(
                            children: [
                              const SizedBox(height: 38),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 26.0,
                              //     vertical: 8,
                              //   ),
                              //   child: Column(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             isChecked3 = !isChecked3;
                              //             controller.clubModel.value = null;
                              //           });
                              //         },
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.start,
                              //           children: [
                              //             CustomPaint(
                              //               size: Size(14.0, 14.0),
                              //               painter: RadioCheckboxPainter(
                              //                 isChecked: isChecked3,
                              //               ),
                              //             ),
                              //             SizedBox(width: 8.0),
                              //             const Text(
                              //               'Order through Organisation',
                              //               style: TextStyle(
                              //                 color: Color(0xFF3A591F),
                              //                 fontSize: 10,
                              //                 fontFamily: 'Fregular',
                              //                 fontWeight: FontWeight.w400,
                              //                 height: 0,
                              //               ),
                              //               textScaleFactor: 1.0,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],

                              //   ),
                              // ),
                            ],
                          )
                        : AppData.clubId.isNull
                        ? SizedBox()
                        : AppData.clubId == "0"
                        ? SizedBox()
                        : Column(
                            children: [
                              const SizedBox(height: 38),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 26.0,
                                  vertical: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isChecked3 = !isChecked3;
                                          controller.clubModel.value = null;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomPaint(
                                            size: Size(14.0, 14.0),
                                            painter: RadioCheckboxPainter(
                                              isChecked: isChecked3,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          const Text(
                                            'Order through Organisation',
                                            style: TextStyle(
                                              color: Color(0xFF3A591F),
                                              fontSize: 10,
                                              fontFamily: 'Fregular',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                            textScaleFactor: 1.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                    Visibility(
                      visible: AppData.volunteerId.isNull ? isChecked3 : false,
                      child: Column(
                        children: [
                          Obx(() {
                            if (controller.Errorcheck[10] == 0) {
                              return SizedBox();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Please Enter * ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontFamily: 'Fmedium',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                    textAlign: TextAlign.right,
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              );
                            }
                          }),

                          /// organisation///
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 8),
                                  CompositedTransformTarget(
                                    link: layerLinkclub_C,
                                    child: Container(
                                      height: 50,
                                      child: TextField(
                                        controller: searchdistrictController_C,
                                        focusNode: searchdrictFocusNode_C,
                                        decoration: InputDecoration(
                                          hintText: "Select Organisation",
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xffE0EDFF),
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12),
                                                ),
                                              ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                      AppColors.primaryColor2,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12),
                                                ),
                                              ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                          ),
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          hintStyle: const TextStyle(
                                            color: Color(0xFF757575),
                                            fontFamily: "Fmedium",
                                            fontSize: 14,
                                          ),
                                          suffixIcon:
                                              searchdistrictController_C
                                                  .text
                                                  .isNotEmpty
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.clear,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      searchdistrictController_C
                                                              .text =
                                                          "";
                                                      controller
                                                              .clubModel
                                                              .value =
                                                          null;
                                                      controller.clubList
                                                          .clear();
                                                    });
                                                  },
                                                )
                                              : null,
                                        ),
                                        textInputAction: TextInputAction
                                            .done, // ✅ Shows the tick button on the keyboard
                                        onSubmitted: (value) {
                                          // ✅ Called when tick (✔) is pressed
                                        },
                                        onChanged: (value) {
                                          filterSearchdrict_C(
                                            searchdistrictController_C.text,
                                          );
                                        },
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
                    SizedBox(height: 20.0),

                    Obx(() {
                      return controller.Errorcheck[0] == 0
                          ? SizedBox()
                          : const Padding(
                              padding: EdgeInsets.only(right: 24, bottom: 4),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Please Enter * ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontFamily: 'Fontsemibold',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                  textAlign: TextAlign.right,
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            );
                    }),
                    // password textfield
                    MyTextField(
                      isNumber: false,
                      fontPading: 24,
                      controller: controller.txtControllername,
                      hintText: 'Enter Name',
                      obscureText: false,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26.0,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                                if (isChecked) {
                                  controller.hideidendity = "1";
                                } else {
                                  controller.hideidendity = "0";
                                }
                              });
                            },
                            child: CustomPaint(
                              size: Size(14.0, 14.0),
                              painter: RadioCheckboxPainter(
                                isChecked: isChecked,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          const Text(
                            'Hide Name (Participate without revealing your name)',
                            style: TextStyle(
                              color: Color(0xFF3A591F),
                              fontSize: 10,
                              fontFamily: 'Fregular',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return controller.Errorcheck[1] == 0
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.only(right: 24, bottom: 4),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  controller.Errorcheck[1] == 1
                                      ? "Please Enter * "
                                      : "Please Enter valid number* ",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontFamily: 'Fontsemibold',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                  textAlign: TextAlign.right,
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            );
                    }),
                    MyTextField(
                      isNumber: true,
                      fontPading: 24,
                      controller: controller.txtControllerMobile,
                      hintText: 'Enter Mobile Number',
                      obscureText: false,
                      height: 50,
                    ),
                    const SizedBox(height: 18),
                    Obx(() {
                      return controller.Errorcheck[2] == 0
                          ? SizedBox()
                          : const Padding(
                              padding: EdgeInsets.only(right: 24, bottom: 4),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Please Enter * ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontFamily: 'Fontsemibold',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                  textAlign: TextAlign.right,
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            );
                    }),
                    MyTextField(
                      isNumber: false,
                      fontPading: 24,
                      controller: controller.txtControllerAddress,
                      hintText: 'Enter Address',
                      obscureText: false,
                      height: 50,
                    ),
                    const SizedBox(height: 8),

                    ////////spinner for the district
                    if (AppData.volunteerId == null)
                      Column(
                        children: [
                          widget.showdistrictandassembly != "1"
                              ? SizedBox()
                              : Visibility(
                                  visible: false,
                                  child: Column(
                                    children: [
                                      Obx(() {
                                        return controller.Errorcheck[3] == 0
                                            ? SizedBox()
                                            : const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 24,
                                                  bottom: 4,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    "Please Enter * ",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Fontsemibold',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                    textScaleFactor: 1.0,
                                                  ),
                                                ),
                                              );
                                      }),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: Column(
                                          children: [
                                            CompositedTransformTarget(
                                              link: layerLinkdrict,
                                              child: Container(
                                                height: 50,
                                                width: double.infinity,
                                                child: TextField(
                                                  controller:
                                                      searchdistrictController,
                                                  focusNode:
                                                      searchdrictFocusNode,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Color(
                                                                  0xffE0EDFF,
                                                                ),
                                                                width: 1,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  12,
                                                                ),
                                                              ),
                                                        ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: AppColors
                                                                .primaryColor2,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  12,
                                                                ),
                                                              ),
                                                        ),

                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            25,
                                                          ),
                                                    ),
                                                    fillColor:
                                                        Colors.transparent,
                                                    filled: true,
                                                    hintStyle: const TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontFamily: "Fmedium",
                                                      fontSize: 14,
                                                    ),
                                                    hintText: "Select District",

                                                    suffixIcon:
                                                        searchdistrictController
                                                            .text
                                                            .isNotEmpty
                                                        ? IconButton(
                                                            icon: Icon(
                                                              Icons.clear,
                                                              size: 16,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                clearTheDatas(
                                                                  whichToclear
                                                                      .district,
                                                                );
                                                              });
                                                            },
                                                          )
                                                        : null,
                                                  ),

                                                  textInputAction: TextInputAction
                                                      .done, // ✅ Shows the tick button on the keyboard
                                                  onSubmitted: (value) {
                                                    // ✅ Called when tick (✔) is pressed

                                                    ondoneTheDatas(
                                                      whichToclear.district,
                                                      value,
                                                    );
                                                  },
                                                  onChanged: (value) {
                                                    filterSearchdrict(
                                                      searchdistrictController
                                                          .text,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Obx(() {
                                        return controller.Errorcheck[4] == 0
                                            ? SizedBox()
                                            : const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 24,
                                                  bottom: 4,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    "Please Enter * ",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Fontsemibold',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                    textScaleFactor: 1.0,
                                                  ),
                                                ),
                                              );
                                      }),
                                      SizedBox(),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: Column(
                                          children: [
                                            CompositedTransformTarget(
                                              link: layerLinkassembly,
                                              child: Container(
                                                height: 50,
                                                child: TextField(
                                                  controller:
                                                      searchassemblyController,
                                                  focusNode:
                                                      searchassemblyFocusNode,

                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Color(
                                                                  0xffE0EDFF,
                                                                ),
                                                                width: 1,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  12,
                                                                ),
                                                              ),
                                                        ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: AppColors
                                                                .primaryColor2,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  12,
                                                                ),
                                                              ),
                                                        ),
                                                    hintText: "Select Assembly",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            25,
                                                          ),
                                                    ),
                                                    fillColor:
                                                        Colors.transparent,
                                                    filled: true,
                                                    hintStyle: const TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontFamily: "Fmedium",
                                                      fontSize: 14,
                                                    ),

                                                    suffixIcon:
                                                        searchassemblyController
                                                            .text
                                                            .isNotEmpty
                                                        ? IconButton(
                                                            icon: Icon(
                                                              Icons.clear,
                                                              size: 16,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                clearTheDatas(
                                                                  whichToclear
                                                                      .assembly,
                                                                );
                                                              });
                                                            },
                                                          )
                                                        : null,
                                                  ),
                                                  textInputAction: TextInputAction
                                                      .done, // ✅ Shows the tick button on the keyboard
                                                  onSubmitted: (value) {
                                                    // ✅ Called when tick (✔) is pressed

                                                    ondoneTheDatas(
                                                      whichToclear.assembly,
                                                      value,
                                                    );
                                                  },
                                                  onChanged: (value) {
                                                    filterSearchassembly(
                                                      searchassemblyController
                                                          .text,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 8),
                          Obx(() {
                            return controller.Errorcheck[5] == 0
                                ? SizedBox()
                                : const Padding(
                                    padding: EdgeInsets.only(
                                      right: 24,
                                      bottom: 4,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Please Enter * ",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontFamily: 'Fontsemibold',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                        textAlign: TextAlign.right,
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                  );
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                CompositedTransformTarget(
                                  link: layerLinkpanchayat,
                                  child: Container(
                                    height: 50,
                                    child: TextField(
                                      controller: searchpanchayatController,
                                      focusNode: searchpanchayatFocusNode,
                                      decoration: InputDecoration(
                                        label: Text(
                                          "Panchayat/Mun./Corp.",
                                          style: TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontFamily: 'Fmedium',
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffE0EDFF),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor2,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        hintStyle: const TextStyle(
                                          color: Color(0xFF757575),
                                          fontFamily: "Fmedium",
                                          fontSize: 14,
                                        ),
                                        suffixIcon:
                                            searchpanchayatController
                                                .text
                                                .isNotEmpty
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.clear,
                                                  size: 16,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    clearTheDatas(
                                                      whichToclear.panchayt,
                                                    );
                                                  });
                                                },
                                              )
                                            : null,
                                      ),
                                      textInputAction: TextInputAction
                                          .done, // ✅ Shows the tick button on the keyboard
                                      onSubmitted: (value) {
                                        // ✅ Called when tick (✔) is pressed

                                        ondoneTheDatas(
                                          whichToclear.panchayt,
                                          value,
                                        );
                                      },
                                      onChanged: (value) {
                                        filterSearchpanchayat(
                                          searchpanchayatController.text,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Obx(() {
                            return controller.Errorcheck[6] == 0
                                ? SizedBox()
                                : const Padding(
                                    padding: EdgeInsets.only(
                                      right: 24,
                                      bottom: 4,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Please Enter * ",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontFamily: 'Fontsemibold',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                        textAlign: TextAlign.right,
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                  );
                          }),

                          Obx(() {
                            return controller.wardlist.isEmpty
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Select Ward',
                                            style: TextStyle(
                                              color: Color(0xFF7F8281),
                                              fontSize: 12,
                                              fontFamily: 'Fmedium',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Wrap(
                                          spacing: 10, // Like gap in flexbox
                                          runSpacing:
                                              10, // Like row-gap in flexbox
                                          children: List.generate(
                                            controller.wardlist.length,
                                            (index) => IntrinsicWidth(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    controller.selected_index =
                                                        index;
                                                  });

                                                  selectItemward(
                                                    controller.wardlist![index],
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 12,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        index ==
                                                            controller
                                                                .selected_index
                                                        ? AppColors
                                                              .primaryColor2
                                                        : Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,
                                                        color:
                                                            index ==
                                                                controller
                                                                    .selected_index
                                                            ? AppColors
                                                                  .primaryColor2
                                                            : Color(0xFF7F8181),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    controller
                                                        .wardlist[index]
                                                        .name,
                                                    style: TextStyle(
                                                      color:
                                                          index ==
                                                              controller
                                                                  .selected_index
                                                          ? Colors.white
                                                          : Color(0xFF7F8281),
                                                      fontSize: 14,
                                                      fontFamily: 'Fmedium',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),

                          if (KeyboardHeight > 0 &&
                              searchdrictFocusNode.hasFocus)
                            SizedBox(height: 30),
                          if (KeyboardHeight > 0 &&
                              searchassemblyFocusNode.hasFocus)
                            SizedBox(height: 80),
                          if (KeyboardHeight > 0 &&
                              searchpanchayatFocusNode.hasFocus)
                            SizedBox(height: 100),
                          if (KeyboardHeight > 0 &&
                              searchwardFocusNode.hasFocus)
                            SizedBox(height: 200),
                        ],
                      ),

                    //////spinner for club selection
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26.0,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (widget.isChecked2 != true) {
                                    setState(() {
                                      controller.orderforothercheck =
                                          !controller.orderforothercheck;
                                      controller.clubModel.value = null;
                                    });
                                  }
                                },
                                child: CustomPaint(
                                  size: Size(14.0, 14.0),
                                  painter: RadioCheckboxPainter(
                                    isChecked: controller.orderforothercheck,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              const Text(
                                'Order for Others',
                                style: TextStyle(
                                  color: Color(0xFF3A591F),
                                  fontSize: 10,
                                  fontFamily: 'Fregular',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ],
                          ),
                        ),

                        Visibility(
                          visible: controller.orderforothercheck,
                          child: Column(
                            children: [
                              Obx(() {
                                return controller.Errorcheck[7] == 0
                                    ? SizedBox()
                                    : const Padding(
                                        padding: EdgeInsets.only(
                                          right: 24,
                                          bottom: 4,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "Please Enter * ",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                            textAlign: TextAlign.right,
                                            textScaleFactor: 1.0,
                                          ),
                                        ),
                                      );
                              }),
                              MyTextField(
                                isNumber: false,
                                fontPading: 24,
                                controller: controller.txtControllerotname,
                                hintText: 'Enter recipient  name',
                                obscureText: false,
                                height: 50,
                              ),
                              const SizedBox(height: 16),
                              Obx(() {
                                return controller.Errorcheck[8] == 0
                                    ? SizedBox()
                                    : const Padding(
                                        padding: EdgeInsets.only(
                                          right: 24,
                                          bottom: 4,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "Please Enter * ",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                            textAlign: TextAlign.right,
                                            textScaleFactor: 1.0,
                                          ),
                                        ),
                                      );
                              }),
                              MyTextField(
                                isNumber: false,
                                fontPading: 24,
                                controller: controller.txtControllerotAddress,
                                hintText: 'Enter recipient  Address',
                                obscureText: false,
                                height: 50,
                              ),
                              const SizedBox(height: 16),
                              Obx(() {
                                return controller.Errorcheck[9] == 0
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          right: 24,
                                          bottom: 4,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            controller.Errorcheck[9] == 1
                                                ? "Please Enter * "
                                                : "Please Enter valid number* ",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                            textAlign: TextAlign.right,
                                            textScaleFactor: 1.0,
                                          ),
                                        ),
                                      );
                              }),
                              MyTextField(
                                isNumber: true,
                                fontPading: 24,
                                controller: controller.txtControllerotMobile,
                                hintText: 'Enter recipient  number',
                                obscureText: false,
                                height: 50,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppData.volunteerId == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Obx(() {
                      if (controller.isLoading.isTrue) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return InkWell(
                          onTap: () {
                            controller.savetotheserver(
                              isChecked3,
                              widget.showdistrictandassembly,
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(1.00, 0.00),
                                end: Alignment(-1, 0),
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor2,
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x21000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                  spreadRadius: -2,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'Fmedium',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Obx(() {
                      if (controller.isLoading.isTrue) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.savefromvolunterr(
                                  "0",
                                  isChecked3,
                                  widget.showdistrictandassembly,
                                  isChecked,
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      color: Color(0xFF757575),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x21000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Pay Later',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'Fmedium',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                controller.savefromvolunterr(
                                  widget.totalmaount,
                                  isChecked3,
                                  widget.showdistrictandassembly,
                                  isChecked,
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(1.00, 0.00),
                                    end: Alignment(-1, 0),
                                    colors: [
                                      AppColors.primaryColor,
                                      AppColors.primaryColor2,
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x21000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Cash Received',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Fmedium',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
          ],
        ),
      ),
    );
  }

  scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.offset + 160, // Scroll to the bottom
      duration: Duration(milliseconds: 500), // Smooth scrolling duration
      curve: Curves.easeOut, // Animation curve
    );
  }

  TextEditingController searchdistrictController = TextEditingController();
  FocusNode searchdrictFocusNode = FocusNode();

  TextEditingController searchassemblyController = TextEditingController();
  FocusNode searchassemblyFocusNode = FocusNode();

  final LayerLink layerLinkdrict = LayerLink();
  final LayerLink layerLinkassembly = LayerLink();

  OverlayEntry? overlayEntry;
  void hideDropdown() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  addListnnerFortheTextController() {
    searchdrictFocusNode.addListener(() {
      if (searchdrictFocusNode.hasFocus) {
        if (controller.distristList.isEmpty) {
          filterSearchdrict("");
        } else {
          showDropdowndistrict();
        }
      } else {
        hideDropdown();
      }
    });

    searchassemblyFocusNode.addListener(() {
      if (searchassemblyFocusNode.hasFocus) {
        if (controller.orgassemblyList.isEmpty) {
          filterSearchassembly("");
        } else {
          showDropdownassembly();
        }
      } else {
        hideDropdown();
      }
    });

    searchpanchayatFocusNode.addListener(() {
      if (searchpanchayatFocusNode.hasFocus) {
        if (controller.panchayatList.isEmpty) {
          filterSearchpanchayat("");
        } else {
          showDropdownpanchayat();
        }
      } else {
        hideDropdown();
      }
    });

    searchwardFocusNode.addListener(() {
      if (searchwardFocusNode.hasFocus) {
        if (controller.wardlist.isEmpty) {
          filterSearchward("");
        } else {
          showDropdownward();
        }
      } else {
        hideDropdown();
      }
    });
  }

  ///////Drist level///////////////

  // Scroll controller for SingleChildScrollView
  final ScrollController _scrollController = ScrollController();

  void showDropdowndistrict() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.distristList.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkdrict,
            offset: Offset(0, 50), // Position below TextField
            child: Material(
              elevation: 1.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 200, // Set the maximum height
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                // Limit dropdown height
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.distristList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.distristList![index].name}",
                          style: TextStyle(fontSize: 14, fontFamily: 'Fmedium'),
                        ),
                        onTap: () =>
                            selectItemdrict(controller.distristList![index]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItemdrict(DistrictModel selectedItem) {
    selectedTheDatas(whichToclear.district).then(
      (value) => setState(() {
        searchdistrictController.text = selectedItem.name;
        controller.fetchAssemblyapi(selectedItem.id);
        controller.orgdistModel.value = selectedItem;
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchdrict(String query) {
    controller.distristList.isNull ? null : controller.distristList?.clear();
    print(">>>>>>>query$query");
    List<DistrictModel> filterdItem = query.isEmpty
        ? List.from(controller.ditrictfulllist!)
        : controller.ditrictfulllist!
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    if (filterdItem.isNull) {
      print(">>>>>>>Empty");
    } else {
      print(">>>>>>>Not empty");
      filterdItem?.forEach((district) {
        print(district.name);
      });
      controller.distristList?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchdrictFocusNode.hasFocus) {
      showDropdowndistrict();
    }
  }

  ///////assembly level///////////////

  void showDropdownassembly() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgassemblyfullList.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkassembly,
            offset: Offset(0, 50), // Position below TextField
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 200, // Set the maximum height
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                // Limit dropdown height
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.orgassemblyList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.orgassemblyList![index].name}",
                          style: TextStyle(fontSize: 14, fontFamily: 'Fmedium'),
                        ),
                        onTap: () => selectItemassembly(
                          controller.orgassemblyList![index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItemassembly(NewAssemblyModel selectedItem) {
    selectedTheDatas(whichToclear.assembly).then(
      (value) => setState(() {
        searchassemblyController.text = selectedItem.name;
        controller.fetchPanchaythapi([selectedItem.id]);
        controller.orgassemblymodel.value = selectedItem;
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchassembly(String query) {
    controller.orgassemblyList.isNull
        ? null
        : controller.orgassemblyList?.clear();
    print(">>>>>>>query$query");
    List<NewAssemblyModel> filterdItem = query.isEmpty
        ? List.from(controller.orgassemblyfullList!)
        : controller.orgassemblyfullList!
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    if (filterdItem.isNull) {
      print(">>>>>>>Empty");
    } else {
      print(">>>>>>>Not empty");
      filterdItem?.forEach((district) {
        print(district.name);
      });
      controller.orgassemblyList?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchassemblyFocusNode.hasFocus) {
      showDropdownassembly();
    }
  }

  ///////panchayat level///////////////

  TextEditingController searchpanchayatController = TextEditingController();
  FocusNode searchpanchayatFocusNode = FocusNode();

  final LayerLink layerLinkpanchayat = LayerLink();

  void showDropdownpanchayat() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.panchayatList.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkpanchayat,
            offset: Offset(0, 48), // Position below TextField
            child: Material(
              color: Colors.white,

              elevation: 1.0,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Obx(() {
                  if (controller.panchayatList == null ||
                      controller.panchayatList!.isEmpty) {
                    return SizedBox(); // Return empty widget if list is empty
                  }
                  return ConstrainedBox(
                    constraints: BoxConstraints.loose(
                      Size(double.infinity, 200),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.panchayatList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 40,
                          child: ListTile(
                            title: Text(
                              "${index + 1}. ${controller.panchayatList![index].name}",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Fmedium',
                              ),
                            ),
                            onTap: () => selectItempanchayat(
                              controller.panchayatList![index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItempanchayat(PanchayatModel selectedItem) {
    selectedTheDatas(whichToclear.panchayt).then(
      (value) => setState(() {
        searchpanchayatController.text = selectedItem.name;
        controller.fetchwardapi(selectedItem.id);
        controller.orgPanchaytModel.value = selectedItem;
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchpanchayat(String query) {
    controller.panchayatList.isNull ? null : controller.panchayatList?.clear();
    print(">>>>>>>query$query");
    List<PanchayatModel> filterdItem = query.isEmpty
        ? List.from(controller.panchayatListfull!)
        : controller.panchayatListfull!
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    if (filterdItem.isNull) {
      print(">>>>>>>Empty");
    } else {
      print(">>>>>>>Not empty");
      filterdItem?.forEach((district) {
        print(district.name);
      });
      controller.panchayatList?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchpanchayatFocusNode.hasFocus) {
      showDropdownpanchayat();
    }
  }

  ///////ward level///////////////

  TextEditingController searchwardController = TextEditingController();
  FocusNode searchwardFocusNode = FocusNode();
  final LayerLink layerLinkward = LayerLink();

  void showDropdownward() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.wardlist.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Positioned(
              width:
                  MediaQuery.of(context).size.width * 0.9, // Set dropdown width
              child: CompositedTransformFollower(
                link: layerLinkward,
                offset: Offset(0, 50), // Position below TextField
                child: Material(
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 200, // Set the maximum height
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // Limit dropdown height
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.wardlist!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${index + 1}. ${controller.wardlist![index].name}",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Fmedium',
                              ),
                            ),
                            onTap: () =>
                                selectItemward(controller.wardlist![index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItemward(WardModel selectedItem) {
    selectedTheDatas(whichToclear.ward).then(
      (value) => setState(() {
        searchwardController.text = selectedItem.name;
        controller.orgwardModel.value = selectedItem;
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchward(String query) {
    controller.wardlist.isNull ? null : controller.wardlist?.clear();
    print(">>>>>>>query$query");
    List<WardModel> filterdItem = query.isEmpty
        ? List.from(controller.wardlistfull!)
        : controller.wardlistfull!
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    if (filterdItem.isNull) {
      print(">>>>>>>Empty");
    } else {
      print(">>>>>>>Not empty");
      filterdItem?.forEach((district) {
        print(district.name);
      });
      controller.wardlist?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchwardFocusNode.hasFocus) {
      showDropdownward();
    }
  }

  disposetheview() {
    searchdistrictController.dispose();
    searchdrictFocusNode.dispose();

    searchassemblyController.dispose();
    searchassemblyFocusNode.dispose();

    searchpanchayatController.dispose();
    searchpanchayatFocusNode.dispose();

    searchwardController.dispose();
    searchwardFocusNode.dispose();
    hideDropdown();
  }

  bool _isKeyboardVisible = false;
  @override
  void didChangeMetrics() {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isVisible = keyboardHeight > 0;

    if (isVisible != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });

      if (isVisible &&
          (searchdrictFocusNode.hasFocus ||
              searchassemblyFocusNode.hasFocus ||
              searchpanchayatFocusNode.hasFocus ||
              searchwardFocusNode.hasFocus)) {
        Future.delayed(Duration(milliseconds: 300), () {
          scrollToEnd();
        });
      }
    }
  }

  ondoneTheDatas(whichToclear value, String? filter) {
    if (value == whichToclear.district) {
      try {
        DistrictModel districtModel = controller.distristList!.firstWhere(
          (district) => district.name.toLowerCase() == filter?.toLowerCase(),
        );
        selectItemdrict(districtModel);
      } catch (e) {
        clearTheDatasondone(value);
      }
    } else if (value == whichToclear.assembly) {
      try {
        NewAssemblyModel districtModel = controller.orgassemblyList!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItemassembly(districtModel);
      } catch (e) {
        clearTheDatasondone(value);
      }
    } else if (value == whichToclear.panchayt) {
      try {
        PanchayatModel panchayatModel = controller.panchayatList!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItempanchayat(panchayatModel);
      } catch (e) {
        clearTheDatasondone(value);
      }
    } else if (value == whichToclear.ward) {
      try {
        WardModel value = controller.wardlist!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItemward(value);
      } catch (e) {
        clearTheDatasondone(value);
      }
    }
  }

  Future<void> selectedTheDatas(whichToclear value) async {
    if (value == whichToclear.district) {
      searchassemblyController.clear();
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgassemblymodel.value = null;
      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.orgassemblyfullList.isEmpty
          ? null
          : controller.orgassemblyfullList.clear();
      controller.panchayatListfull.isEmpty
          ? null
          : controller.panchayatListfull.clear();
      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.orgassemblyList.isEmpty
          ? null
          : controller.orgassemblyList.clear();
      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.assembly) {
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.panchayatListfull.isEmpty
          ? null
          : controller.panchayatListfull.clear();
      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.panchayt) {
      searchwardController.clear();

      controller.orgwardModel.value = null;

      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.ward) {}

    hideDropdown();
  }

  clearTheDatas(whichToclear value) {
    if (value == whichToclear.district) {
      searchdistrictController.text = "";
      searchassemblyController.clear();
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgdistModel.value = null;
      controller.orgassemblymodel.value = null;
      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.orgassemblyfullList.isEmpty
          ? null
          : controller.orgassemblyfullList.clear();
      controller.panchayatListfull.isEmpty
          ? null
          : controller.panchayatListfull.clear();
      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.distristList.isEmpty ? null : controller.distristList.clear();
      controller.orgassemblyList.isEmpty
          ? null
          : controller.orgassemblyList.clear();
      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.assembly) {
      searchassemblyController.text = "";
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgassemblymodel.value = null;
      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.panchayatListfull.isEmpty
          ? null
          : controller.panchayatListfull.clear();
      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.orgassemblyList.isEmpty
          ? null
          : controller.orgassemblyList.clear();
      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.panchayt) {
      searchpanchayatController.text = "";
      searchwardController.clear();

      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.ward) {
      searchwardController.text = "";

      controller.orgwardModel.value = null;

      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    }

    hideDropdown();
  }

  clearTheDatasondone(whichToclear value) {
    if (value == whichToclear.district) {
      searchassemblyController.clear();
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgdistModel.value = null;
      controller.orgassemblymodel.value = null;
      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.orgassemblyfullList.isEmpty
          ? null
          : controller.orgassemblyfullList.clear();
      controller.panchayatListfull.isEmpty
          ? null
          : controller.panchayatListfull.clear();
      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.orgassemblyList.isEmpty
          ? null
          : controller.orgassemblyList.clear();
      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.assembly) {
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgassemblymodel.value = null;
      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.panchayatListfull.isEmpty
          ? null
          : controller.panchayatListfull.clear();
      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.panchayatList.isEmpty
          ? null
          : controller.panchayatList.clear();
      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.panchayt) {
      searchwardController.clear();

      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      controller.wardlistfull.isEmpty ? null : controller.wardlistfull.clear();

      controller.wardlist.isEmpty ? null : controller.wardlist.clear();
    } else if (value == whichToclear.ward) {
      controller.orgwardModel.value = null;
    }

    hideDropdown();
  }

  ///////////////

  /// for the club ////////////////////////

  TextEditingController searchdistrictController_C = TextEditingController();
  FocusNode searchdrictFocusNode_C = FocusNode();

  final LayerLink layerLinkclub_C = LayerLink();

  addListnnerFortheTextController_C() {
    searchdrictFocusNode_C.addListener(() {
      if (searchdrictFocusNode_C.hasFocus) {
        if (controller.clubList.isEmpty) {
          filterSearchdrict_C("");
        } else {
          showDropdowndistrict_C();
        }
      } else {
        hideDropdown();
      }
    });
  }

  ///////Drist level///////////////
  void showDropdowndistrict_C() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.clubList.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkclub_C,
            offset: Offset(0, 50), // Position below TextField
            child: Material(
              elevation: 1.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 200, // Set the maximum height
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                // Limit dropdown height
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.clubList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.clubList![index].name}",
                          style: TextStyle(fontSize: 14, fontFamily: 'Fmedium'),
                        ),
                        onTap: () =>
                            selectItemdrict_C(controller.clubList![index]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItemdrict_C(ClubModel selectedItem) {
    searchdistrictController_C.text = selectedItem.name;
    controller.clubModel.value = selectedItem;

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchdrict_C(String query) {
    controller.clubList.isEmpty ? null : controller.clubList?.clear();

    List<ClubModel> filterdItem = query.isEmpty
        ? List.from(controller.clubListFull!)
        : controller.clubListFull!
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    if (filterdItem.isNull) {
      print(">>>>>>>Empty");
    } else {
      print(">>>>>>>Not empty");
      filterdItem?.forEach((district) {
        print(district.name);
      });
      controller.clubList?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchdrictFocusNode_C.hasFocus) {
      showDropdowndistrict_C();
    }
  }
}

class RadioCheckboxPainter extends CustomPainter {
  final bool isChecked;

  RadioCheckboxPainter({required this.isChecked});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF3A591F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the outer circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    if (isChecked) {
      // Draw the inner dot if checked
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(size.center(Offset.zero), size.width / 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

enum whichToclear { district, assembly, panchayt, ward }
