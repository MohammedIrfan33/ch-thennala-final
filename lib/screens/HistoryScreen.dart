import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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

class Historyscreen extends StatefulWidget {
  final String? GlobalId;
  final String uniqueid;
  final Function(int)? onTabChange;
  Historyscreen({
    required this.GlobalId,
    required this.uniqueid,
    this.onTabChange,
  });

  @override
  State<Historyscreen> createState() => HistoryState(GlobalId: GlobalId);
}

class HistoryState extends State<Historyscreen>
    with TickerProviderStateMixin, RouteAware {
  late TabController tabControllerInner;
  late TabController _tabController;

  final String? GlobalId;

  HistoryState({required this.GlobalId});

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(94),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: 25,
                //   height: 25,
                //   // margin: const EdgeInsets.all(8),
                //   // decoration: ShapeDecoration(
                //   //   color: Colors.white,
                //   //   shape: RoundedRectangleBorder(
                //   //     side:
                //   //     const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                //   //     borderRadius: BorderRadius.circular(18),
                //   //   ),
                //   // ),
                //   // child: IconButton(
                //   //   padding: const EdgeInsets.all(8),
                //   //   constraints: const BoxConstraints(),
                //   //   onPressed: () {
                //   //     Get.back();
                //   //   },
                //   //   icon: SvgPicture.asset(
                //   //     'assets/backarrow_s.svg',
                //   //     width: 22,
                //   //     height: 22,
                //   //     semanticsLabel: 'Example SVG',
                //   //   ),
                //   // ),
                // ),
                const Center(
                  child: Text(
                    'Transactions',
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
                // Container(
                //   width: 25,
                //   height: 25,
                //   // margin: const EdgeInsets.all(8),
                //   // decoration: ShapeDecoration(
                //   //   color: Colors.white,
                //   //   shape: RoundedRectangleBorder(
                //   //     side:
                //   //     const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                //   //     borderRadius: BorderRadius.circular(18),
                //   //   ),
                //   // ),
                //   // child: IconButton(
                //   //   padding: const EdgeInsets.all(8),
                //   //   onPressed: () {
                //   //     Get.back();
                //   //   },
                //   //   icon: SvgPicture.asset(
                //   //     'assets/home.svg',
                //   //     width: 18,
                //   //     height: 20,
                //   //     semanticsLabel: 'Example SVG',
                //   //   ),
                //   // ),
                // ),
              ],
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TabBar(
                // Selected tab text color
                unselectedLabelColor: Colors.transparent,
                // Unselected tab text color
                controller: _tabController,

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
                        "Challenge Report",
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
                        "Contribution Report",
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    tabControllerInner = TabController(length: 1, vsync: this);
    super.initState();

    controller.fetchPanchaythapi(['1']);
    controller.fetchPanchaythapi_S(['1']);
    controller.fetchPanchaythapi_D('1');
    controller.fetchClub();

    tabControllerInner.addListener(() {
      if (tabControllerInner.indexIsChanging) {
        searchdrictFocusNode.unfocus();
        searchassemblyFocusNode.unfocus();
        searchpanchayatFocusNode.unfocus();
        searchwardFocusNode.unfocus();

        searchdrictFocusNode_S.unfocus();
        searchassemblyFocusNode_S.unfocus();
        searchpanchayatFocusNode_S.unfocus();
        searchwardFocusNode_S.unfocus();

        searchdrictFocusNode_C.unfocus();

        searchdrictFocusNode_D.unfocus();
        searchassemblyFocusNode_D.unfocus();
        searchpanchayatFocusNode_D.unfocus();
        searchwardFocusNode_D.unfocus();
      }
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        searchdrictFocusNode.unfocus();
        searchassemblyFocusNode.unfocus();
        searchpanchayatFocusNode.unfocus();
        searchwardFocusNode.unfocus();

        searchdrictFocusNode_S.unfocus();
        searchassemblyFocusNode_S.unfocus();
        searchpanchayatFocusNode_S.unfocus();
        searchwardFocusNode_S.unfocus();

        searchdrictFocusNode_C.unfocus();

        searchdrictFocusNode_D.unfocus();
        searchassemblyFocusNode_D.unfocus();
        searchpanchayatFocusNode_D.unfocus();
        searchwardFocusNode_D.unfocus();
      }
    });
    addListnnerFortheTextController_S();
    addListnnerFortheTextController_D();
    addListnnerFortheTextController();
    addListnnerFortheTextController_C();

    controller.ChallengeHistory();
    controller.challegesponsorList();
    controller.Condributionlist();
  }

  @override
  void dispose() {
    disposetheview();
    disposetheview_D();
    disposetheview_S();
    searchdrictFocusNode_C.unfocus();

    super.dispose();

    tabControllerInner.dispose();
    _tabController.dispose();
  }

  @override
  void didPopNext() {
    controller.fetchPanchaythapi(['1']);
    controller.fetchPanchaythapi_S(['1']);
    controller.fetchPanchaythapi_D('1');
    controller.fetchClub();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  var controller = Get.put(ChallengeHistroyController());
  TextEditingController txtsearchController = TextEditingController();
  TextEditingController txtsearchController2 = TextEditingController();

  void unfocusTextField() {
    hideDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: TabBarView(
        controller: _tabController,
        children: [
          /// challenge report /////
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TabBar(
                  unselectedLabelColor: const Color(0xFF3A3A3A),
                  labelColor: Colors.white,
                  dividerColor: Colors.transparent,
                  // Set to true to allow scrolling of tabs
                  indicatorSize: TabBarIndicatorSize.tab,
                  // Tab indicator size
                  indicatorWeight: 2.0,
                  indicator: BoxDecoration(
                    color: AppColors.primaryColor2,
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Set color and thickness
                    // Set the horizontal inset
                  ),
                  controller: tabControllerInner,
                  tabs: [
                    Tab(
                      child: MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaleFactor: 1.0),
                        child: const AutoSizeText(
                          textAlign: TextAlign.center,
                          'Participants',
                          style: TextStyle(fontSize: 14.0),
                          maxFontSize: 14,
                          minFontSize: 10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: tabControllerInner,

                  children: [
                    /// participation /////
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Visibility(
                            visible: false,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
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
                                            focusNode: searchdrictFocusNode,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xffE0EDFF),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(12),
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
                                                          Radius.circular(12),
                                                        ),
                                                  ),

                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fillColor: Colors.transparent,
                                              filled: true,
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF757575),
                                                fontFamily: "Fontsemibold",
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
                                                searchdistrictController.text,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 0,
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
                                            focusNode: searchassemblyFocusNode,

                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xffE0EDFF),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(12),
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
                                                          Radius.circular(12),
                                                        ),
                                                  ),
                                              hintText: "Select Assembly",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fillColor: Colors.transparent,
                                              filled: true,
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF757575),
                                                fontFamily: "Fontsemibold",
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
                                                searchassemblyController.text,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                        hintText: "Select Panchayat/Mun./Corp.",
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
                                          fontFamily: "Fontsemibold",
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

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              children: [
                                CompositedTransformTarget(
                                  link: layerLinkward,
                                  child: Container(
                                    height: 50,
                                    child: TextField(
                                      controller: searchwardController,
                                      focusNode: searchwardFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Select Ward",
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
                                          fontFamily: "Fontsemibold",
                                          fontSize: 14,
                                        ),
                                        suffixIcon:
                                            searchwardController.text.isNotEmpty
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.clear,
                                                  size: 16,
                                                ),

                                                onPressed: () {
                                                  setState(() {
                                                    clearTheDatas(
                                                      whichToclear.ward,
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
                                          whichToclear.ward,
                                          value,
                                        );
                                      },
                                      onChanged: (value) {
                                        filterSearchward(
                                          searchwardController.text,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          SizedBox(height: 8),

                          Wrap(
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                    child: Image.asset(
                                      height: 86,

                                      'assets/home3/orderpackedbg.png', // Path to your SVG
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    height: 86,

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 158,

                                                child: const AutoSizeText(
                                                  textAlign: TextAlign.start,
                                                  "Total Collected",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontFamily: 'Fontsemibold',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.91,
                                                  ),
                                                  textScaleFactor: 1.0,
                                                  maxLines: 2,
                                                  minFontSize: 08,
                                                  maxFontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Obx(() {
                                                  return AutoSizeText(
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Fmedium',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 08,
                                                    maxFontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textScaleFactor: 1.0,
                                                    " ₹ ${controller.totalPrice.toString()}",
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 158,

                                                child: const AutoSizeText(
                                                  textAlign: TextAlign.start,
                                                  "Total Ordered",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontFamily: 'Fontsemibold',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.91,
                                                  ),
                                                  textScaleFactor: 1.0,
                                                  maxLines: 2,
                                                  minFontSize: 08,
                                                  maxFontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Obx(() {
                                                  return AutoSizeText(
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Fmedium',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 06,
                                                    maxFontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textScaleFactor: 1.0,
                                                    " ${controller.pendingPrice.toString()}",
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),

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
                              } else if (controller.challengelist.isEmpty) {
                                return const Center(
                                  child: Text('No entries to show'),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: controller.challengelist.length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      fit: StackFit.passthrough,
                                      alignment: AlignmentDirectional.topCenter,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                          ),

                                          decoration: ShapeDecoration(
                                            color: AppColors.primaryColor3,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: AppColors.primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12.0,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .challengelist[index]
                                                              .day,
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF3A3A3A,
                                                                ),
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 0,
                                                              ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .challengelist[index]
                                                              .month,
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF757575,
                                                                ),
                                                                fontSize: 9,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 4,
                                                          right: 4,
                                                        ),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Name   :',
                                                              style: TextStyle(
                                                                color: Color(
                                                                  0xFF3A3A3A,
                                                                ),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                height: 0,
                                                              ),
                                                              textScaleFactor:
                                                                  1.0,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                controller
                                                                    .challengelist[index]
                                                                    .name,
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFF3A3A3A,
                                                                  ),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  height: 0,
                                                                ),
                                                                textScaleFactor:
                                                                    1.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      'District : ',
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                    Text(
                                                                      controller
                                                                          .challengelist[index]
                                                                          .district,
                                                                      style: const TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      'Assembly : ',
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                    Text(
                                                                      controller
                                                                          .challengelist[index]
                                                                          .assembly,
                                                                      style: const TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      'Panchayat : ',
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                    Text(
                                                                      controller
                                                                          .challengelist[index]
                                                                          .panchayat,
                                                                      style: const TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      'Ward   :  ',
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                    Text(
                                                                      controller
                                                                          .challengelist[index]
                                                                          .ward,
                                                                      style: const TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        controller
                                                                    .challengelist[index]
                                                                    .canchangeward ==
                                                                0
                                                            ? SizedBox()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          isScrollControlled:
                                                                              true,
                                                                          builder:
                                                                              (
                                                                                context,
                                                                              ) => BottomSheetContent(
                                                                                id: controller.challengelist[index].customerid,
                                                                                panchayatid: controller.challengelist[index].panchayatid,
                                                                                controllersub: controller,
                                                                                GlogalIDSub: GlobalId,
                                                                              ),
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        margin: const EdgeInsets.only(
                                                                          left:
                                                                              6,
                                                                        ),
                                                                        height:
                                                                            28,
                                                                        decoration: ShapeDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                          ),
                                                                          shadows: const [
                                                                            BoxShadow(
                                                                              color: Color(
                                                                                0x3F000000,
                                                                              ),
                                                                              blurRadius: 4,
                                                                              offset: Offset(
                                                                                0,
                                                                                4,
                                                                              ),
                                                                              spreadRadius: 0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            'Change Ward',
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 10,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // controller.challengelist[index].fullypaid ==
                                                                  //     0
                                                                  //     ? SizedBox()
                                                                  //     : Expanded(
                                                                  //   flex: 2,
                                                                  //   child: InkWell(
                                                                  //     onTap: () {
                                                                  //       Get.to(
                                                                  //           ReceiptDownload(
                                                                  //             Amount: controller
                                                                  //                 .challengelist[
                                                                  //             index]
                                                                  //                 .amount,
                                                                  //             name: controller
                                                                  //                 .challengelist[
                                                                  //             index]
                                                                  //                 .receiptname,
                                                                  //           ));
                                                                  //     },
                                                                  //     child:
                                                                  //     Container(
                                                                  //       margin:
                                                                  //       const EdgeInsets
                                                                  //           .only(
                                                                  //           left:
                                                                  //           6),
                                                                  //       height: 28,
                                                                  //       decoration:
                                                                  //       ShapeDecoration(
                                                                  //         color: Colors
                                                                  //             .white,
                                                                  //         shape:
                                                                  //         RoundedRectangleBorder(
                                                                  //           borderRadius:
                                                                  //           BorderRadius.circular(
                                                                  //               10),
                                                                  //         ),
                                                                  //         shadows: const [
                                                                  //           BoxShadow(
                                                                  //             color: Color(
                                                                  //                 0x3F000000),
                                                                  //             blurRadius:
                                                                  //             4,
                                                                  //             offset: Offset(
                                                                  //                 0,
                                                                  //                 4),
                                                                  //             spreadRadius:
                                                                  //             0,
                                                                  //           )
                                                                  //         ],
                                                                  //       ),
                                                                  //       child:
                                                                  //       const Center(
                                                                  //         child: Text(
                                                                  //           'Receipt',
                                                                  //           style:
                                                                  //           TextStyle(
                                                                  //             color: Colors
                                                                  //                 .black,
                                                                  //             fontSize:
                                                                  //             10,
                                                                  //             fontFamily:
                                                                  //             'Poppins',
                                                                  //             fontWeight:
                                                                  //             FontWeight.w500,
                                                                  //             height:
                                                                  //             0,
                                                                  //           ),
                                                                  //           textScaleFactor:
                                                                  //           1.0,
                                                                  //         ),
                                                                  //       ),
                                                                  //     ),
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          bottom: 40,
                                          top: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 72,

                                                child: AutoSizeText(
                                                  "₹${controller.challengelist[index].amount.trim().replaceAll(".00", "")}",
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                width: 72,

                                                child: AutoSizeText(
                                                  "${controller.challengelist[index].time}",
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                  ],
                ),
              ),
            ],
          ),

          ///contribution report ///
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 4),
                  Visibility(
                    visible: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              CompositedTransformTarget(
                                link: layerLinkdrict_D,
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  child: TextField(
                                    controller: searchdistrictController_D,
                                    focusNode: searchdrictFocusNode_D,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xffE0EDFF),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(12),
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
                                                          Radius.circular(12),
                                                        ),
                                                  ),

                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fillColor: Colors.transparent,
                                              filled: true,
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF757575),
                                                fontFamily: "Fontsemibold",
                                                fontSize: 14,
                                              ),
                                              hintText: "Select District",

                                      suffixIcon:
                                          searchdistrictController_D
                                              .text
                                              .isNotEmpty
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                size: 16,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  clearTheDatas_D(
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

                                      ondoneTheDatas_D(
                                        whichToclear.district,
                                        value,
                                      );
                                    },
                                    onChanged: (value) {
                                      filterSearchdrict_D(
                                        searchdistrictController_D.text,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          child: Column(
                            children: [
                              CompositedTransformTarget(
                                link: layerLinkassembly_D,
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    controller: searchassemblyController_D,
                                    focusNode: searchassemblyFocusNode_D,

                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xffE0EDFF),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(12),
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
                                                          Radius.circular(12),
                                                        ),
                                                  ),
                                              hintText: "Select Assembly",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fillColor: Colors.transparent,
                                              filled: true,
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF757575),
                                                fontFamily: "Fontsemibold",
                                                fontSize: 14,
                                              ),

                                      suffixIcon:
                                          searchassemblyController_D
                                              .text
                                              .isNotEmpty
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                size: 16,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  clearTheDatas_D(
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

                                      ondoneTheDatas_D(
                                        whichToclear.assembly,
                                        value,
                                      );
                                    },
                                    onChanged: (value) {
                                      filterSearchassembly_D(
                                        searchassemblyController_D.text,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        CompositedTransformTarget(
                          link: layerLinkpanchayat_D,
                          child: Container(
                            height: 50,
                            child: TextField(
                              controller: searchpanchayatController_D,
                              focusNode: searchpanchayatFocusNode_D,
                                      decoration: InputDecoration(
                                        hintText: "Select Panchayat/Mun./Corp.",
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
                                          fontFamily: "Fontsemibold",
                                          fontSize: 14,
                                        ),
                                suffixIcon:
                                    searchpanchayatController_D.text.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.clear, size: 16),
                                        onPressed: () {
                                          setState(() {
                                            clearTheDatas_D(
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

                                ondoneTheDatas_D(whichToclear.panchayt, value);
                              },
                              onChanged: (value) {
                                filterSearchpanchayat_D(
                                  searchpanchayatController_D.text,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        CompositedTransformTarget(
                          link: layerLinkward_D,
                          child: Container(
                            height: 50,
                            child: TextField(
                              controller: searchwardController_D,
                              focusNode: searchwardFocusNode_D,
                                      decoration: InputDecoration(
                                        hintText: "Select Ward",
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
                                          fontFamily: "Fontsemibold",
                                          fontSize: 14,
                                        ),
                                suffixIcon:
                                    searchwardController_D.text.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.clear, size: 16),

                                        onPressed: () {
                                          setState(() {
                                            clearTheDatas_D(whichToclear.ward);
                                          });
                                        },
                                      )
                                    : null,
                              ),
                              textInputAction: TextInputAction
                                  .done, // ✅ Shows the tick button on the keyboard
                              onSubmitted: (value) {
                                // ✅ Called when tick (✔) is pressed

                                ondoneTheDatas_D(whichToclear.ward, value);
                              },
                              onChanged: (value) {
                                filterSearchward_D(searchwardController_D.text);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),

                  Stack(
                    children: [
                      Positioned(
                        child: SvgPicture.asset(
                          height: 86,

                          'assets/dashbord/firstbg.svg', // Path to your SVG
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 86,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount\n Collected',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Fontsemibold',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: 1.05,
                                ),
                                textScaleFactor: 1.0,
                              ),
                              Obx(() {
                                return AutoSizeText(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Fmedium',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 08,
                                  maxFontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: 1.0,
                                  " ₹ ${controller.totalPrice3.toString()}",
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    if (controller.isLoading_Condribution.value) {
                      return ProgressINdigator();
                    } else if (controller.contributionList.isEmpty) {
                      return const Center(child: Text('No entries to show'));
                    } else {
                      return GetBuilder(
                        builder: (ChallengeHistroyController controller) {
                          return Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 400, // Set the height for ListView
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: controller.contributionList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),

                                      decoration: ShapeDecoration(
                                        color: AppColors.primaryColor3,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: AppColors.primaryColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 12),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Name   :',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Fontsemibold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .contributionList[index]
                                                              .name,
                                                          style: const TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Fontsemibold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'District : ',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .contributionList[index]
                                                                      .district,
                                                                  style: const TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  'Assembly : ',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .contributionList[index]
                                                                      .assembly,
                                                                  style: const TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Panchayath : ',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .contributionList[index]
                                                                      .panchayat,
                                                                  style: const TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  'Ward   :  ',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .contributionList[index]
                                                                      .ward,
                                                                  style: const TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  'Date & time :  ',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .contributionList[index]
                                                                      .date,
                                                                  style: const TextStyle(
                                                                    color: Color(
                                                                      0xFF3A3A3A,
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Fontsemibold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " ₹${controller.contributionList[index].amount.replaceAll(".00", "")}",
                                                              style: const TextStyle(
                                                                color: Color(
                                                                  0xFF3A3A3A,
                                                                ),
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Fontsemibold',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 0,
                                                              ),
                                                              textScaleFactor:
                                                                  1.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
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
  final ScrollController _scrollController_S = ScrollController();

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
                          style: TextStyle(fontSize: 14),
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
        controller.ChallengeHistory();
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
                          style: TextStyle(fontSize: 14),
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
        controller.ChallengeHistory();
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
                              style: TextStyle(fontSize: 14),
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
        controller.ChallengeHistory();
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
                              style: TextStyle(fontSize: 14),
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
        controller.ChallengeHistory();
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
    /// for the the participation /////
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

  /// data delete from the on done ////
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

  /// data selected by drop down click
  Future<void> selectedTheDatas(whichToclear value) async {
    if (value == whichToclear.district) {
      searchassemblyController.clear();
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgassemblymodel.value = null;
      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      if (controller.wardlistfull!.isNotEmpty) controller.wardlistfull!.clear();

      if (controller.panchayatListfull!.isNotEmpty)
        controller.panchayatListfull!.clear();

      if (controller.orgassemblyfullList!.isNotEmpty)
        controller.orgassemblyfullList!.clear();
    } else if (value == whichToclear.assembly) {
      searchpanchayatController.clear();
      searchwardController.clear();

      controller.orgPanchaytModel.value = null;
      controller.orgwardModel.value = null;

      if (controller.wardlistfull!.isNotEmpty) controller.wardlistfull!.clear();

      if (controller.panchayatListfull!.isNotEmpty)
        controller.panchayatListfull!.clear();
    } else if (value == whichToclear.panchayt) {
      searchwardController.clear();

      controller.orgwardModel.value = null;

      if (controller.wardlistfull!.isNotEmpty) controller.wardlistfull!.clear();
    } else if (value == whichToclear.ward) {}

    hideDropdown();
  }

  /// data called by the on click the cross iocn
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

    controller.ChallengeHistory();
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
    controller.ChallengeHistory();
  }

  ///  filter code the sponsorship /////////////

  TextEditingController searchdistrictController_S = TextEditingController();
  FocusNode searchdrictFocusNode_S = FocusNode();

  TextEditingController searchassemblyController_S = TextEditingController();
  FocusNode searchassemblyFocusNode_S = FocusNode();

  final LayerLink layerLinkdrict_S = LayerLink();
  final LayerLink layerLinkassembly_S = LayerLink();

  addListnnerFortheTextController_S() {
    searchdrictFocusNode_S.addListener(() {
      if (searchdrictFocusNode_S.hasFocus) {
        if (controller.orgdistristList_S.isEmpty) {
          filterSearchdrict_S("");
        } else {
          showDropdowndistrict_S();
        }
      } else {
        hideDropdown();
      }
    });

    searchassemblyFocusNode_S.addListener(() {
      if (searchassemblyFocusNode_S.hasFocus) {
        if (controller.orgassemblyList_S.isEmpty) {
          filterSearchassembly_S("");
        } else {
          showDropdownassembly_S();
          ();
        }
      } else {
        hideDropdown();
      }
    });

    searchpanchayatFocusNode_S.addListener(() {
      if (searchpanchayatFocusNode_S.hasFocus) {
        if (controller.orgpanchayatList_S.isEmpty) {
          filterSearchpanchayat_S("");
        } else {
          showDropdownpanchayat_S();
        }
      } else {
        hideDropdown();
      }
    });

    searchwardFocusNode_S.addListener(() {
      if (searchwardFocusNode_S.hasFocus) {
        if (controller.orgWardList_S.isEmpty) {
          filterSearchward_S("");
        } else {
          showDropdownward_S();
        }
      } else {
        hideDropdown();
      }
    });
  }

  ///////Drist level///////////////

  void showDropdowndistrict_S() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgdistristList_S.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkdrict_S,
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
                    itemCount: controller.orgdistristList_S!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.orgdistristList_S![index].name}",
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () => selectItemdrict_S(
                          controller.orgdistristList_S![index],
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

  void selectItemdrict_S(DistrictModel selectedItem) {
    selectedTheDatas_S(whichToclear.district).then(
      (value) => setState(() {
        searchdistrictController_S.text = selectedItem.name;
        controller.fetchAssemblyapi_S(selectedItem.id);
        controller.orgdistModel_S.value = selectedItem;
        controller.challegesponsorList();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchdrict_S(String query) {
    controller.orgdistristList_S.isNull
        ? null
        : controller.orgdistristList_S?.clear();

    List<DistrictModel> filterdItem = query.isEmpty
        ? List.from(controller.ditrictfulllist_S!)
        : controller.ditrictfulllist_S!
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
      controller.orgdistristList_S?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchdrictFocusNode_S.hasFocus) {
      showDropdowndistrict_S();
    }
  }

  ///////assembly level///////////////

  void showDropdownassembly_S() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgassemblyList_S.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkassembly_S,
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
                    itemCount: controller.orgassemblyList_S!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.orgassemblyList_S![index].name}",
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () => selectItemassembly_S(
                          controller.orgassemblyList_S![index],
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

  void selectItemassembly_S(NewAssemblyModel selectedItem) {
    selectedTheDatas_S(whichToclear.assembly).then(
      (value) => setState(() {
        searchassemblyController_S.text = selectedItem.name;
        controller.fetchPanchaythapi_S([selectedItem.id]);
        controller.orgassemblymodel_S.value = selectedItem;
        controller.challegesponsorList();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchassembly_S(String query) {
    controller.orgassemblyList_S.isNull
        ? null
        : controller.orgassemblyList_S?.clear();
    print(">>>>>>>query$query");
    List<NewAssemblyModel> filterdItem = query.isEmpty
        ? List.from(controller.orgassemblyfullList_S!)
        : controller.orgassemblyfullList_S!
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
      controller.orgassemblyList_S?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchassemblyFocusNode_S.hasFocus) {
      showDropdownassembly_S();
    }
  }

  ///////panchayat level///////////////

  TextEditingController searchpanchayatController_S = TextEditingController();
  FocusNode searchpanchayatFocusNode_S = FocusNode();

  final LayerLink layerLinkpanchayat_S = LayerLink();

  void showDropdownpanchayat_S() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgpanchayatList_S.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkpanchayat_S,
            offset: Offset(0, 48), // Position below TextField
            child: Material(
              color: Colors.white,

              elevation: 1.0,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Obx(() {
                  if (controller.orgpanchayatList_S == null ||
                      controller.orgpanchayatList_S!.isEmpty) {
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
                      itemCount: controller.orgpanchayatList_S!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 40,
                          child: ListTile(
                            title: Text(
                              "${index + 1}. ${controller.orgpanchayatList_S![index].name}",
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () => selectItempanchayat_S(
                              controller.orgpanchayatList_S![index],
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

  void selectItempanchayat_S(PanchayatModel selectedItem) {
    selectedTheDatas_S(whichToclear.panchayt).then(
      (value) => setState(() {
        searchpanchayatController_S.text = selectedItem.name;
        controller.fetchwardapi_S(selectedItem.id);
        controller.orgPanchaytModel_S.value = selectedItem;
        controller.challegesponsorList();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchpanchayat_S(String query) {
    controller.orgpanchayatList_S.isNull
        ? null
        : controller.orgpanchayatList_S?.clear();
    print(">>>>>>>query$query");
    List<PanchayatModel> filterdItem = query.isEmpty
        ? List.from(controller.orgpanchayatListfull_S!)
        : controller.orgpanchayatListfull_S!
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
      controller.orgpanchayatList_S?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchpanchayatFocusNode_S.hasFocus) {
      showDropdownpanchayat_S();
    }
  }

  ///////ward level///////////////

  TextEditingController searchwardController_S = TextEditingController();
  FocusNode searchwardFocusNode_S = FocusNode();

  final LayerLink layerLinkward_S = LayerLink();

  void showDropdownward_S() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgWardList_S.isNull) {
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
                link: layerLinkward_S,
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
                        itemCount: controller.orgWardList_S!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${index + 1}. ${controller.orgWardList_S![index].name}",
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () => selectItemward_S(
                              controller.orgWardList_S![index],
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
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItemward_S(WardModel selectedItem) {
    selectedTheDatas_S(whichToclear.ward).then(
      (value) => setState(() {
        searchwardController_S.text = selectedItem.name;
        controller.orgWardModel_S.value = selectedItem;
        controller.challegesponsorList();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchward_S(String query) {
    controller.orgWardList_S.isNull ? null : controller.orgWardList_S?.clear();
    print(">>>>>>>query$query");
    List<WardModel> filterdItem = query.isEmpty
        ? List.from(controller.orgWardListFull_S!)
        : controller.orgWardListFull_S!
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
      controller.orgWardList_S?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchwardFocusNode_S.hasFocus) {
      showDropdownward_S();
    }
  }

  disposetheview_S() {
    /// for the the participation /////
    searchdistrictController_S.dispose();
    searchdrictFocusNode_S.dispose();

    searchassemblyController_S.dispose();
    searchassemblyFocusNode_S.dispose();

    searchpanchayatController_S.dispose();
    searchpanchayatFocusNode_S.dispose();

    searchwardController_S.dispose();
    searchwardFocusNode_S.dispose();
    hideDropdown();
  }

  /// data delete from the on done ////
  ondoneTheDatas_S(whichToclear value, String? filter) {
    if (value == whichToclear.district) {
      try {
        DistrictModel districtModel = controller.orgdistristList_S!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItemdrict_S(districtModel);
      } catch (e) {
        clearTheDatasondone_S(value);
      }
    } else if (value == whichToclear.assembly) {
      try {
        NewAssemblyModel assemblyModel = controller.orgassemblyList_S!
            .firstWhere(
              (assembly) =>
                  assembly.name.toLowerCase() == filter!.toLowerCase(),
            );
        selectItemassembly_S(assemblyModel);
      } catch (e) {
        clearTheDatasondone_S(value);
      }
    } else if (value == whichToclear.panchayt) {
      try {
        PanchayatModel panchayatModel = controller.orgpanchayatList_S!
            .firstWhere(
              (assembly) =>
                  assembly.name.toLowerCase() == filter!.toLowerCase(),
            );
        selectItempanchayat_S(panchayatModel);
      } catch (e) {
        clearTheDatasondone_S(value);
      }
    } else if (value == whichToclear.ward) {
      try {
        WardModel wardModel = controller.orgWardList_S!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItemward_S(wardModel);
      } catch (e) {
        clearTheDatasondone_S(value);
      }
    }

    controller.challegesponsorList();
  }

  /// data selected by drop down click
  Future<void> selectedTheDatas_S(whichToclear value) async {
    if (value == whichToclear.district) {
      searchassemblyController_S.clear();
      searchpanchayatController_S.clear();
      searchwardController_S.clear();

      controller.orgassemblymodel_S.value = null;
      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgassemblyfullList_S.isEmpty
          ? null
          : controller.orgassemblyfullList_S.clear();
      controller.orgpanchayatListfull_S.isEmpty
          ? null
          : controller.orgpanchayatListfull_S.clear();
      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgassemblyList_S.isEmpty
          ? null
          : controller.orgassemblyList_S.clear();
      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.assembly) {
      searchpanchayatController_S.clear();
      searchwardController_S.clear();

      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgpanchayatListfull_S.isEmpty
          ? null
          : controller.orgpanchayatListfull_S.clear();
      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.panchayt) {
      print("reached panchayat ");

      searchwardController_S.clear();

      controller.orgWardModel_S.value = null;

      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.ward) {}

    hideDropdown();
  }

  /// data called by the on click the cross iocn
  clearTheDatas_S(whichToclear value) {
    if (value == whichToclear.district) {
      searchdistrictController_S.text = "";
      searchassemblyController_S.clear();
      searchpanchayatController_S.clear();
      searchwardController_S.clear();

      controller.orgdistModel_S.value = null;
      controller.orgassemblymodel_S.value = null;
      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgassemblyfullList_S.isEmpty
          ? null
          : controller.orgassemblyfullList_S.clear();
      controller.orgpanchayatListfull_S.isEmpty
          ? null
          : controller.orgpanchayatListfull_S.clear();
      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgdistristList_S.isEmpty
          ? null
          : controller.orgdistristList_S.clear();
      controller.orgassemblyList_S.isEmpty
          ? null
          : controller.orgassemblyList_S.clear();
      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.assembly) {
      searchassemblyController_S.text = "";
      searchpanchayatController_S.clear();
      searchwardController_S.clear();

      controller.orgassemblymodel_S.value = null;
      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgpanchayatListfull_S.isEmpty
          ? null
          : controller.orgpanchayatListfull_S.clear();
      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgassemblyList_S.isEmpty
          ? null
          : controller.orgassemblyList_S.clear();
      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.panchayt) {
      searchpanchayatController_S.text = "";
      searchwardController_S.clear();

      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.ward) {
      searchwardController_S.text = "";

      controller.orgWardModel_S.value = null;

      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    }

    hideDropdown();
    controller.challegesponsorList();
  }

  clearTheDatasondone_S(whichToclear value) {
    if (value == whichToclear.district) {
      searchassemblyController_S.clear();
      searchpanchayatController_S.clear();
      searchwardController_S.clear();

      controller.orgdistModel_S.value = null;
      controller.orgassemblymodel_S.value = null;
      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgassemblyfullList_S.isEmpty
          ? null
          : controller.orgassemblyfullList_S.clear();
      controller.orgpanchayatListfull_S.isEmpty
          ? null
          : controller.orgpanchayatListfull_S.clear();
      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgassemblyList_S.isEmpty
          ? null
          : controller.orgassemblyList_S.clear();
      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.assembly) {
      searchwardController_S.clear();

      controller.orgassemblymodel_S.value = null;
      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgpanchayatListfull_S.isEmpty
          ? null
          : controller.orgpanchayatListfull_S.clear();
      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgpanchayatList_S.isEmpty
          ? null
          : controller.orgpanchayatList_S.clear();
      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.panchayt) {
      searchwardController_S.clear();

      controller.orgPanchaytModel_S.value = null;
      controller.orgWardModel_S.value = null;

      controller.orgWardListFull_S.isEmpty
          ? null
          : controller.orgWardListFull_S.clear();

      controller.orgWardList_S.isEmpty
          ? null
          : controller.orgWardList_S.clear();
    } else if (value == whichToclear.ward) {
      controller.orgWardModel_S.value = null;
    }
    hideDropdown();
    controller.challegesponsorList();
  }

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
                          style: TextStyle(fontSize: 14),
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
    controller.ChallengeHistoryorganisation();

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

  ///  For contribution //////////////////
  TextEditingController searchdistrictController_D = TextEditingController();
  FocusNode searchdrictFocusNode_D = FocusNode();

  TextEditingController searchassemblyController_D = TextEditingController();
  FocusNode searchassemblyFocusNode_D = FocusNode();

  final LayerLink layerLinkdrict_D = LayerLink();
  final LayerLink layerLinkassembly_D = LayerLink();

  addListnnerFortheTextController_D() {
    searchdrictFocusNode_D.addListener(() {
      if (searchdrictFocusNode_D.hasFocus) {
        if (controller.orgdistristList_D.isEmpty) {
          filterSearchdrict_D("");
        } else {
          showDropdowndistrict_D();
        }
      } else {
        hideDropdown();
      }
    });

    searchassemblyFocusNode_D.addListener(() {
      if (searchassemblyFocusNode_D.hasFocus) {
        if (controller.orgassemblyList_D.isEmpty) {
          filterSearchassembly_D("");
        } else {
          showDropdownassembly_D();
          ();
        }
      } else {
        hideDropdown();
      }
    });

    searchpanchayatFocusNode_D.addListener(() {
      if (searchpanchayatFocusNode_D.hasFocus) {
        if (controller.orgpanchayatList_D.isEmpty) {
          filterSearchpanchayat_D("");
        } else {
          showDropdownpanchayat_D();
        }
      } else {
        hideDropdown();
      }
    });

    searchwardFocusNode_D.addListener(() {
      if (searchwardFocusNode_D.hasFocus) {
        if (controller.orgWardList_D.isEmpty) {
          filterSearchward_D("");
        } else {
          showDropdownward_D();
        }
      } else {
        hideDropdown();
      }
    });
  }

  ///////Drist level///////////////

  void showDropdowndistrict_D() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgdistristList_D.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkdrict_D,
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
                    itemCount: controller.orgdistristList_D!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.orgdistristList_D![index].name}",
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () => selectItemdrict_D(
                          controller.orgdistristList_D![index],
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

  void selectItemdrict_D(DistrictModel selectedItem) {
    selectedTheDatas_D(whichToclear.district).then(
      (value) => setState(() {
        searchdistrictController_D.text = selectedItem.name;
        controller.fetchAssemblyapi_D(selectedItem.id);
        controller.orgdistModel_D.value = selectedItem;
        controller.Condributionlist();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchdrict_D(String query) {
    controller.orgdistristList_D.isEmpty
        ? null
        : controller.orgdistristList_D?.clear();

    List<DistrictModel> filterdItem = query.isEmpty
        ? List.from(controller.ditrictfulllist_D!)
        : controller.ditrictfulllist_D!
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
      controller.orgdistristList_D?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchdrictFocusNode_D.hasFocus) {
      showDropdowndistrict_D();
    }
  }

  ///////assembly level///////////////

  void showDropdownassembly_D() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgassemblyList_D.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkassembly_D,
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
                    itemCount: controller.orgassemblyList_D!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1}. ${controller.orgassemblyList_D![index].name}",
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () => selectItemassembly_D(
                          controller.orgassemblyList_D![index],
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

  void selectItemassembly_D(NewAssemblyModel selectedItem) {
    selectedTheDatas_D(whichToclear.assembly).then(
      (value) => setState(() {
        searchassemblyController_D.text = selectedItem.name;
        controller.fetchPanchaythapi_D(selectedItem.id);
        controller.orgassemblymodel_D.value = selectedItem;
        controller.Condributionlist();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchassembly_D(String query) {
    controller.orgassemblyList_D.isEmpty
        ? null
        : controller.orgassemblyList_D?.clear();
    print(">>>>>>>query$query");
    List<NewAssemblyModel> filterdItem = query.isEmpty
        ? List.from(controller.orgassemblyfullList_D!)
        : controller.orgassemblyfullList_D!
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
      controller.orgassemblyList_D?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchassemblyFocusNode_D.hasFocus) {
      showDropdownassembly_D();
    }
  }

  ///////panchayat level///////////////

  TextEditingController searchpanchayatController_D = TextEditingController();
  FocusNode searchpanchayatFocusNode_D = FocusNode();

  final LayerLink layerLinkpanchayat_D = LayerLink();

  void showDropdownpanchayat_D() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgpanchayatList_D.isNull) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
          child: CompositedTransformFollower(
            link: layerLinkpanchayat_D,
            offset: Offset(0, 48), // Position below TextField
            child: Material(
              color: Colors.white,

              elevation: 1.0,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Obx(() {
                  if (controller.orgpanchayatList_D == null ||
                      controller.orgpanchayatList_D!.isEmpty) {
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
                      itemCount: controller.orgpanchayatList_D!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 40,
                          child: ListTile(
                            title: Text(
                              "${index + 1}. ${controller.orgpanchayatList_D![index].name}",
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () => selectItempanchayat_D(
                              controller.orgpanchayatList_D![index],
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

  void selectItempanchayat_D(PanchayatModel selectedItem) {
    selectedTheDatas_D(whichToclear.panchayt).then(
      (value) => setState(() {
        searchpanchayatController_D.text = selectedItem.name;
        controller.fetchwardapi_D(selectedItem.id);
        controller.orgPanchaytModel_D.value = selectedItem;
        controller.Condributionlist();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchpanchayat_D(String query) {
    controller.orgpanchayatList_D.isEmpty
        ? null
        : controller.orgpanchayatList_D?.clear();
    print(">>>>>>>query$query");
    List<PanchayatModel> filterdItem = query.isEmpty
        ? List.from(controller.orgpanchayatListfull_D!)
        : controller.orgpanchayatListfull_D!
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
      controller.orgpanchayatList_D?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchpanchayatFocusNode_D.hasFocus) {
      showDropdownpanchayat_D();
    }
  }

  ///////ward level///////////////

  TextEditingController searchwardController_D = TextEditingController();
  FocusNode searchwardFocusNode_D = FocusNode();

  final LayerLink layerLinkward_D = LayerLink();

  void showDropdownward_D() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    if (controller.orgWardList_D.isNull) {
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
                link: layerLinkward_D,
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
                        itemCount: controller.orgWardList_D!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${index + 1}. ${controller.orgWardList_D![index].name}",
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () => selectItemward_D(
                              controller.orgWardList_D![index],
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
      },
    );

    overlay.insert(overlayEntry!);
  }

  void selectItemward_D(WardModel selectedItem) {
    selectedTheDatas_D(whichToclear.ward).then(
      (value) => setState(() {
        searchwardController_D.text = selectedItem.name;
        controller.orgWardModel_D.value = selectedItem;
        controller.Condributionlist();
      }),
    );

    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void filterSearchward_D(String query) {
    controller.orgWardList_D.isEmpty ? null : controller.orgWardList_D?.clear();
    print(">>>>>>>query$query");
    List<WardModel> filterdItem = query.isEmpty
        ? List.from(controller.orgWardListFull_D!)
        : controller.orgWardListFull_D!
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
      controller.orgWardList_D?.addAll(filterdItem);
    }

    // Update dropdown when filtering
    if (searchwardFocusNode_D.hasFocus) {
      showDropdownward_D();
    }
  }

  disposetheview_D() {
    /// for the the participation /////
    searchdistrictController_D.dispose();
    searchdrictFocusNode_D.dispose();

    searchassemblyController_D.dispose();
    searchassemblyFocusNode_D.dispose();

    searchpanchayatController_D.dispose();
    searchpanchayatFocusNode_D.dispose();

    searchwardController_D.dispose();
    searchwardFocusNode_D.dispose();
    hideDropdown();
  }

  /// data delete from the on done ////
  ondoneTheDatas_D(whichToclear value, String? filter) {
    if (value == whichToclear.district) {
      try {
        DistrictModel districtModel = controller.orgdistristList_D!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItemdrict_D(districtModel);
      } catch (e) {
        clearTheDatasondone_D(value);
      }
    } else if (value == whichToclear.assembly) {
      try {
        NewAssemblyModel assemblyModel = controller.orgassemblyList_D!
            .firstWhere(
              (assembly) =>
                  assembly.name.toLowerCase() == filter!.toLowerCase(),
            );
        selectItemassembly_D(assemblyModel);
      } catch (e) {
        clearTheDatasondone_D(value);
      }
    } else if (value == whichToclear.panchayt) {
      try {
        PanchayatModel panchayatModel = controller.orgpanchayatList_D!
            .firstWhere(
              (assembly) =>
                  assembly.name.toLowerCase() == filter!.toLowerCase(),
            );
        selectItempanchayat_D(panchayatModel);
      } catch (e) {
        clearTheDatasondone_D(value);
      }
    } else if (value == whichToclear.ward) {
      try {
        WardModel wardModel = controller.orgWardList_D!.firstWhere(
          (assembly) => assembly.name.toLowerCase() == filter!.toLowerCase(),
        );
        selectItemward_D(wardModel);
      } catch (e) {
        clearTheDatasondone_D(value);
      }
    }

    controller.Condributionlist();
  }

  /// data selected by drop down click
  Future<void> selectedTheDatas_D(whichToclear value) async {
    if (value == whichToclear.district) {
      searchassemblyController_D.clear();
      searchpanchayatController_D.clear();
      searchwardController_D.clear();

      controller.orgassemblymodel_D.value = null;
      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgassemblyfullList_D.isEmpty
          ? null
          : controller.orgassemblyfullList_D.clear();
      controller.orgpanchayatListfull_D.isEmpty
          ? null
          : controller.orgpanchayatListfull_D.clear();
      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgassemblyList_D.isEmpty
          ? null
          : controller.orgassemblyList_D.clear();
      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.assembly) {
      searchpanchayatController_D.clear();
      searchwardController_D.clear();

      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgpanchayatListfull_D.isEmpty
          ? null
          : controller.orgpanchayatListfull_D.clear();
      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.panchayt) {
      print("reached panchayat ");

      searchwardController_D.clear();

      controller.orgWardModel_D.value = null;

      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.ward) {}

    hideDropdown();
  }

  /// data called by the on click the cross iocn
  clearTheDatas_D(whichToclear value) {
    if (value == whichToclear.district) {
      searchdistrictController_D.text = "";
      searchassemblyController_D.clear();
      searchpanchayatController_D.clear();
      searchwardController_D.clear();

      controller.orgdistModel_D.value = null;
      controller.orgassemblymodel_D.value = null;
      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgassemblyfullList_D.isEmpty
          ? null
          : controller.orgassemblyfullList_D.clear();
      controller.orgpanchayatListfull_D.isEmpty
          ? null
          : controller.orgpanchayatListfull_D.clear();
      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgdistristList_D.isEmpty
          ? null
          : controller.orgdistristList_D.clear();
      controller.orgassemblyList_D.isEmpty
          ? null
          : controller.orgassemblyList_D.clear();
      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.assembly) {
      searchassemblyController_D.text = "";
      searchpanchayatController_D.clear();
      searchwardController_D.clear();

      controller.orgassemblymodel_D.value = null;
      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgpanchayatListfull_D.isEmpty
          ? null
          : controller.orgpanchayatListfull_D.clear();
      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgassemblyList_D.isEmpty
          ? null
          : controller.orgassemblyList_D.clear();
      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.panchayt) {
      searchpanchayatController_D.text = "";
      searchwardController_D.clear();

      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.ward) {
      searchwardController_D.text = "";

      controller.orgWardModel_D.value = null;

      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    }

    hideDropdown();
    controller.Condributionlist();
  }

  clearTheDatasondone_D(whichToclear value) {
    if (value == whichToclear.district) {
      searchassemblyController_D.clear();
      searchpanchayatController_D.clear();
      searchwardController_D.clear();

      controller.orgdistModel_D.value = null;
      controller.orgassemblymodel_D.value = null;
      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgassemblyfullList_D.isEmpty
          ? null
          : controller.orgassemblyfullList_D.clear();
      controller.orgpanchayatListfull_D.isEmpty
          ? null
          : controller.orgpanchayatListfull_D.clear();
      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgassemblyList_D.isEmpty
          ? null
          : controller.orgassemblyList_D.clear();
      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.assembly) {
      searchwardController_D.clear();

      controller.orgassemblymodel_D.value = null;
      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgpanchayatListfull_D.isEmpty
          ? null
          : controller.orgpanchayatListfull_D.clear();
      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgpanchayatList_D.isEmpty
          ? null
          : controller.orgpanchayatList_D.clear();
      controller.orgWardList_D.isEmpty
          ? null
          : controller.orgWardList_D.clear();
    } else if (value == whichToclear.panchayt) {
      searchwardController_D.clear();

      controller.orgPanchaytModel_D.value = null;
      controller.orgWardModel_D.value = null;

      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();

      controller.orgWardListFull_D.isEmpty
          ? null
          : controller.orgWardListFull_D.clear();
    } else if (value == whichToclear.ward) {
      controller.orgWardModel_D.value = null;
    }
    hideDropdown();
    controller.Condributionlist();
  }
}

class BottomSheetContent extends StatefulWidget {
  String id;

  String panchayatid;
  ChallengeHistroyController controllersub;

  String? GlogalIDSub;

  BottomSheetContent({
    required this.id,
    required this.panchayatid,
    required this.controllersub,
    required this.GlogalIDSub,
  });

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String error1 = "";
  String error2 = "";

  String? GlogalIDSub;

  WardModel? wardModel;
  List<WardModel>? wardList = <WardModel>[];
  bool isLodingUpdatebutton = false;
  TextEditingController txtcontroller = TextEditingController();

  /// get ward list
  fetchwardapi(String S) async {
    //// print(">>>>>>>>>>id");
    //// print(id);
    //// print(">>>>>>>>>>wardModel");
    //// print(wardModel!.name);
    //// print(">>>>>>>>>>txtcontroller");
    //// print(txtcontroller.text);
    final response = await http.post(
      Uri.parse(historypageWardAPi),
      body: {'id': S.toString()},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<WardModel>.from(
        data['data'].map((x) => WardModel.fromJson(x)),
      ).toList();

      setState(() {
        if (list.isNull) {
        } else {
          wardList!.addAll(list);
        }
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  ///update the data
  Future<bool> updatetheward() async {
    final response = await http.post(
      Uri.parse(updateWard),
      body: {
        'id': widget.id, //userid.text.toString(),
        'wardid': wardModel!.id,
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Check the status
        if (parsedJson['Status'] == 'True') {
          widget.controllersub.ChallengeHistory();
          widget.controllersub.ChallengeHistoryorganisation();

          Get.snackbar(
            'Updated', // Title of the Snackbar
            "Your Ward is updated", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'Updated',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium', // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.0,
            ),
            messageText: const Text(
              'Your Ward is updated',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fontsemibold', // Set your custom font family here
                fontSize: 14,
              ),
              textScaleFactor: 1.0,
            ),
            // Position of the Snackbar
            backgroundColor: AppColors.primaryColor2,
            // Background color of the Snackbar
            colorText: Colors.white,
            // Text color of the Snackbar
            borderRadius: 10,
            // Border radius of the Snackbar
            margin: EdgeInsets.all(10),
            // Margin around the Snackbar
            duration: Duration(
              seconds: 3,
            ), // Duration for which the Snackbar is displayed
          );

          txtcontroller.clear();

          return true;
        } else {
          Get.snackbar("Error", "There is a error in your updation process");
        }
      }
    } else {
      throw Exception('Failed to load data');
    }

    return false;
  }

  bool validate() {
    setState(() {
      isLodingUpdatebutton = true;
    });

    if (wardModel.isNull) {
      setState(() {
        error2 = "Please enter *";
      });
      return false;
    } else {
      setState(() {
        error2 = "";
      });
    }

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchwardapi(widget.panchayatid);
    //print("Customerid >>>>>>>>>>");
    //print(">>>>>>>>>>id");
    //print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Change Ward',
                        style: TextStyle(
                          color: Color(0xFF3A3A3A),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  wardList.isNull
                      ? SizedBox()
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                error2,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontFamily: 'Fontsemibold',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: MediaQuery.sizeOf(context).width - 48,
                              height: 50,
                              decoration: ShapeDecoration(
                                color: Color(0xFFF7FAFF),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFE8F0FB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<WardModel>(
                                    hint: const Text('Select Your Ward '),
                                    value: wardModel,
                                    onChanged: (WardModel? newValue) {
                                      setState(() {
                                        wardModel = newValue;
                                      });
                                    },
                                    items: wardList!
                                        .map<DropdownMenuItem<WardModel>>((
                                          item,
                                        ) {
                                          return DropdownMenuItem<WardModel>(
                                            value: item,
                                            child: Text(
                                              item.name.toString(),
                                              style: TextStyle(
                                                fontFamily: "",
                                                fontSize: 14,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                          );
                                        })
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            isLodingUpdatebutton
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: ProgressINdigator(),
                                  )
                                : InkWell(
                                    onTap: () {
                                      //print(validate().toString());
                                      if (validate()) {
                                        updatetheward().then((bool value1) {
                                          if (value1) {
                                            Navigator.pop(context);
                                          } else {
                                            setState(() {
                                              isLodingUpdatebutton = false;
                                            });
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          isLodingUpdatebutton = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      width: 326,
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
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'Change Ward',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                ],
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

enum whichToclear { district, assembly, panchayt, ward }
