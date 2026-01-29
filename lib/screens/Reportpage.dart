import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/controller/ReportController.dart';
import 'package:chcenterthennala/modles/ClubModel.dart';
import 'package:chcenterthennala/modles/PanchayatModel.dart';
import 'package:chcenterthennala/modles/WardModel.dart';
import 'package:http/http.dart' as http;
import '../ApiLists/Apis.dart';
import '../Utils/colors.dart';
import '../main.dart';
import '../modles/AssembelyModel.dart';
import '../modles/DistrictModel.dart';
import '../modles/NewAssemblyModel.dart';
import '../widgets/PorgressIndicator.dart';
import 'OrderUpdateScreen.dart';
import 'ReceiptDownloadpage.dart';
import 'ReceiptPageContribution.dart';
import 'Statuspage.dart';

class Reportscreen extends StatefulWidget {
  String? volunteer_ID;
  Reportscreen({required this.volunteer_ID});

  @override
  State<Reportscreen> createState() => _ReportState();
}

class _ReportState extends State<Reportscreen>
    with TickerProviderStateMixin, RouteAware {
  late TabController tabControllerInner;
  final controller = Get.put(ReportController());

  ClubModel? clubModel;
  List<ClubModel>? clubList = <ClubModel>[];

  fetchClub() async {
    final response = await http.get(Uri.parse(ClubApi));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<ClubModel>.from(
        data['data'].map((x) => ClubModel.fromJson(x)),
      ).toList();
      setState(() {
        if (list.isNull) {
        } else {
          clubList!.addAll(list);
        }
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
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
                    'Leaders Report',
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
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFEDF4FC),
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(8),
                    onPressed: () {
                      Get.back();
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    tabControllerInner = TabController(length: 3, vsync: this);

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
      }
    });

    super.initState();

    controller.volunteer_ID = widget.volunteer_ID;
    controller.fullproducts();
    controller.Condributionlist(null, null, null, null);
    controller.challegesponsorList();
    controller.fetchDistrictapi();
    controller.fetchDistrictapi_S();
    addListnnerFortheTextController();
    addListnnerFortheTextController_S();

    fetchClub();
  }

  @override
  void didPopNext() {
    controller.fetchDistrictapi();
    controller.fetchDistrictapi_S();
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
  void dispose() {
    tabControllerInner.dispose();
    disposetheview();
    disposetheview_S();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 4),
            Container(
              //  height: 40,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TabBar(
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
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Tab(
                        child: MediaQuery(
                          data: MediaQuery.of(
                            context,
                          ).copyWith(textScaleFactor: 1.0),
                          child: const AutoSizeText(
                            textAlign: TextAlign.center,
                            'Sponsors',
                            style: TextStyle(fontSize: 14.0),
                            maxFontSize: 14,
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Tab(
                        child: MediaQuery(
                          data: MediaQuery.of(
                            context,
                          ).copyWith(textScaleFactor: 1.0),
                          child: const AutoSizeText(
                            textAlign: TextAlign.center,
                            'Donations',
                            style: TextStyle(fontSize: 14.0),
                            maxFontSize: 14,
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabControllerInner,
                children: [
                  ///first tab starts ///
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding:  EdgeInsets.symmetric(horizontal: 0),
                        //       child: Column(
                        //         children: [
                        //           CompositedTransformTarget(
                        //             link: layerLinkdrict,
                        //             child: Container(
                        //               height: 50,
                        //               width: double.infinity,
                        //               child: TextField(
                        //                 controller: searchdistrictController,
                        //                 focusNode: searchdrictFocusNode,
                        //                 decoration: InputDecoration(
                        //                   enabledBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   focusedBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //
                        //                   border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(25),
                        //
                        //                   ),
                        //                   fillColor: Colors.transparent,
                        //                   filled: true,
                        //                   hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //                   hintText: "Select District",
                        //
                        //
                        //                   suffixIcon: searchdistrictController.text.isNotEmpty
                        //                       ? IconButton(
                        //                     icon: Icon(Icons.clear,size: 16,),
                        //                     onPressed: () {
                        //                       setState(() {
                        //                         clearTheDatas(whichToclear.district);
                        //
                        //                       });
                        //                     },
                        //                   )
                        //                       : null,
                        //                 ),
                        //
                        //                 textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //                 onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //                   ondoneTheDatas(whichToclear.district,value);
                        //
                        //                 },
                        //                 onChanged:  (value) {
                        //                   filterSearchdrict(searchdistrictController.text);
                        //                 },
                        //
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 8,),
                        //
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 0),
                        //       child: Column(
                        //         children: [
                        //           CompositedTransformTarget(
                        //             link: layerLinkassembly,
                        //             child: Container(
                        //               height: 50,
                        //               child: TextField(
                        //                 controller: searchassemblyController,
                        //                 focusNode: searchassemblyFocusNode,
                        //
                        //
                        //
                        //                 decoration: InputDecoration(
                        //                   enabledBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   focusedBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   hintText: "Select Assembly",
                        //                   border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(25),
                        //
                        //                   ),
                        //                   fillColor: Colors.transparent,
                        //                   filled: true,
                        //                   hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //
                        //
                        //                   suffixIcon: searchassemblyController.text.isNotEmpty
                        //                       ? IconButton(
                        //                     icon: Icon(Icons.clear,size: 16,),
                        //                     onPressed: () {
                        //                       setState(() {
                        //                         clearTheDatas(whichToclear.assembly);
                        //                       });
                        //                     },
                        //                   )
                        //                       : null,
                        //                 ),
                        //                 textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //                 onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //                   ondoneTheDatas(whichToclear.assembly,value);
                        //
                        //                 },
                        //                 onChanged:  (value) {
                        //                   filterSearchassembly(searchassemblyController.text);
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 8,),
                        //   ],
                        // ),
                        //
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal:0),
                        //   child: Column(
                        //     children: [
                        //       CompositedTransformTarget(
                        //         link: layerLinkpanchayat,
                        //         child: Container(
                        //           height: 50,
                        //           child: TextField(
                        //             controller: searchpanchayatController,
                        //             focusNode: searchpanchayatFocusNode,
                        //             decoration: InputDecoration(
                        //
                        //               hintText: "Select Panchayat/Mun./Corp.",
                        //               enabledBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(25),
                        //
                        //               ),
                        //               fillColor: Colors.transparent,
                        //               filled: true,
                        //               hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //               suffixIcon: searchpanchayatController.text.isNotEmpty
                        //                   ? IconButton(
                        //                 icon: Icon(Icons.clear,size: 16,),
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     clearTheDatas(whichToclear.panchayt);
                        //                   });
                        //                 },
                        //               )
                        //                   : null,
                        //             ),
                        //             textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //             onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //               ondoneTheDatas(whichToclear.panchayt,value);
                        //
                        //             },
                        //             onChanged:  (value) {
                        //               filterSearchpanchayat(searchpanchayatController.text);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8,),
                        //
                        // Padding(
                        //   padding: const EdgeInsets. symmetric(horizontal: 0),
                        //   child: Column(
                        //     children: [
                        //       CompositedTransformTarget(
                        //         link: layerLinkward,
                        //         child: Container(
                        //           height: 50,
                        //           child: TextField(
                        //             controller: searchwardController,
                        //             focusNode: searchwardFocusNode,
                        //             decoration: InputDecoration(
                        //
                        //               hintText: "Select Ward",
                        //               enabledBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(25),
                        //
                        //               ),
                        //               fillColor: Colors.transparent,
                        //               filled: true,
                        //               hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //               suffixIcon: searchwardController.text.isNotEmpty
                        //                   ? IconButton(
                        //                 icon: Icon(Icons.clear,size: 16,),
                        //
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     clearTheDatas(whichToclear.ward);
                        //                   });
                        //                 },
                        //               )
                        //                   : null,
                        //             ),
                        //             textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //             onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //               ondoneTheDatas(whichToclear.ward,value);
                        //
                        //             },
                        //             onChanged:  (value) {
                        //               filterSearchward(searchwardController.text);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8,),
                        Stack(
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                height: 96,

                                'assets/dashbord/firstbg.svg', // Path to your SVG
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: 96,

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 158,

                                          child: const AutoSizeText(
                                            textAlign: TextAlign.start,
                                            "Amount Received",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.91,
                                            ),
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            minFontSize: 08,
                                            maxFontSize: 14,
                                            overflow: TextOverflow.ellipsis,
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
                                                fontWeight: FontWeight.w900,
                                                height: 0,
                                              ),
                                              maxLines: 1,
                                              minFontSize: 08,
                                              maxFontSize: 20,
                                              overflow: TextOverflow.ellipsis,
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
                                            "Amount Pending",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.91,
                                            ),
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            minFontSize: 08,
                                            maxFontSize: 14,
                                            overflow: TextOverflow.ellipsis,
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
                                                fontWeight: FontWeight.w900,
                                                height: 0,
                                              ),
                                              maxLines: 1,
                                              minFontSize: 06,
                                              maxFontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor: 1.0,
                                              " ₹ ${controller.pendingPrice.toString()}",
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
                        SizedBox(height: 10),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return ProgressINdigator();
                          } else if (controller
                              .callengepartisipationlist
                              .isEmpty) {
                            return const Center(
                              child: Text('No entries to show'),
                            );
                          } else {
                            return GetBuilder(
                              builder: (ReportController controller) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    return ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: constraints.maxHeight,
                                      ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .callengepartisipationlist
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color:
                                                      AppColors.primaryColor3,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    0.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                12.0,
                                                              ),
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    'Name   :',
                                                                    style: TextStyle(
                                                                      color: Color(
                                                                        0xFF3A3A3A,
                                                                      ),
                                                                      fontSize:
                                                                          14,
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
                                                                  Expanded(
                                                                    child: Text(
                                                                      controller
                                                                          .callengepartisipationlist[index]
                                                                          .name,
                                                                      style: const TextStyle(
                                                                        color: Color(
                                                                          0xFF3A3A3A,
                                                                        ),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Fontsemibold',
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        height:
                                                                            0,
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
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            'District : ',
                                                                            style: TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                          Text(
                                                                            controller.callengepartisipationlist[index].district,
                                                                            style: const TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            'Assembly : ',
                                                                            style: TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                          Text(
                                                                            controller.callengepartisipationlist[index].assembly,
                                                                            style: const TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            'Panchayath : ',
                                                                            style: TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                          Text(
                                                                            controller.callengepartisipationlist[index].panchayat,
                                                                            style: const TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            'Ward   :  ',
                                                                            style: TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                          Text(
                                                                            controller.callengepartisipationlist[index].ward,
                                                                            style: const TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            'Payable amount :  ',
                                                                            style: TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                          Text(
                                                                            "₹${controller.callengepartisipationlist[index].payable.replaceAll(".00", "")}",
                                                                            style: const TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            'Date :  ',
                                                                            style: TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
                                                                            ),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                          ),
                                                                          Text(
                                                                            "${controller.callengepartisipationlist[index].date.replaceAll(".00", "")}",
                                                                            style: const TextStyle(
                                                                              color: Color(
                                                                                0xFF3A3A3A,
                                                                              ),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Fontsemibold',
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0,
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
                                                                height: 12,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  controller.callengepartisipationlist[index].amount !=
                                                                          "0.00"
                                                                      ? SizedBox()
                                                                      : Expanded(
                                                                          flex:
                                                                              2,
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              controller.updateamount(
                                                                                controller.callengepartisipationlist[index].id,
                                                                                controller.orgdistModel.value,
                                                                                controller.orgassemblymodel.value,
                                                                                controller.orgPanchaytModel.value,
                                                                                controller.orgwardModel.value,
                                                                                clubModel,
                                                                              );
                                                                            },
                                                                            child: Container(
                                                                              margin: const EdgeInsets.only(
                                                                                left: 6,
                                                                              ),
                                                                              height: 28,
                                                                              decoration: ShapeDecoration(
                                                                                color: AppColors.primaryColor2,
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
                                                                                  ' Pay Now',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Fontsemibold',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    height: 0,
                                                                                  ),
                                                                                  textScaleFactor: 1.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              controller
                                                                          .callengepartisipationlist[index]
                                                                          .show_receipt_status !=
                                                                      "1"
                                                                  ? SizedBox()
                                                                  : Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: InkWell(
                                                                            onTap: () => Get.to(
                                                                              () => StatusScreen(
                                                                                name: controller.callengepartisipationlist[index].name,
                                                                              ),
                                                                            ),
                                                                            child: Container(
                                                                              height: 28,
                                                                              decoration: ShapeDecoration(
                                                                                color: AppColors.primaryColor2,
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
                                                                                  'Status',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    height: 0,
                                                                                  ),
                                                                                  textScaleFactor: 1.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: IgnorePointer(
                                                                            ignoring:
                                                                                false, // ← allows interaction
                                                                            child: Material(
                                                                              color: Colors.transparent,
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  Get.to(
                                                                                    () => ReceiptDownload(
                                                                                      name: controller.callengepartisipationlist[index].name,
                                                                                      Amount: controller.callengepartisipationlist[index].amount,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.only(
                                                                                    left: 6,
                                                                                  ),
                                                                                  height: 28,
                                                                                  decoration: ShapeDecoration(
                                                                                    color: AppColors.primaryColor2,
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
                                                                                      'Receipt',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 10,
                                                                                        fontFamily: 'Fontsemibold',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        height: 0,
                                                                                      ),
                                                                                      textScaleFactor: 1.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),

                                                              const SizedBox(
                                                                height: 8,
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
                                                right: 8,
                                                top: 50,

                                                child: IgnorePointer(
                                                  ignoring: true,
                                                  child: Container(
                                                    width: 100,
                                                    child: AutoSizeText(
                                                      textAlign: TextAlign.end,
                                                      "₹${controller.callengepartisipationlist[index].amount.trim().replaceAll(".00", "")}",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            controller
                                                                    .callengepartisipationlist[index]
                                                                    .amount ==
                                                                "0.00"
                                                            ? Color(0xFFF60606)
                                                            : Color(0xFF3A3A3A),
                                                        fontFamily:
                                                            'Fontsemibold',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.91,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                      maxLines: 2,
                                                      minFontSize: 08,
                                                      maxFontSize: 18,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        }),
                      ],
                    ),
                  ),

                  ///Second tab starts ///
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding:  EdgeInsets.symmetric(horizontal: 0),
                        //       child: Column(
                        //         children: [
                        //           CompositedTransformTarget(
                        //             link: layerLinkdrict,
                        //             child: Container(
                        //               height: 50,
                        //               width: double.infinity,
                        //               child: TextField(
                        //                 controller: searchdistrictController,
                        //                 focusNode: searchdrictFocusNode,
                        //                 decoration: InputDecoration(
                        //                   enabledBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   focusedBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //
                        //                   border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(25),
                        //
                        //                   ),
                        //                   fillColor: Colors.transparent,
                        //                   filled: true,
                        //                   hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //                   hintText: "Select District",
                        //
                        //
                        //                   suffixIcon: searchdistrictController.text.isNotEmpty
                        //                       ? IconButton(
                        //                     icon: Icon(Icons.clear,size: 16,),
                        //                     onPressed: () {
                        //                       setState(() {
                        //                         clearTheDatas(whichToclear.district);
                        //
                        //                       });
                        //                     },
                        //                   )
                        //                       : null,
                        //                 ),
                        //
                        //                 textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //                 onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //                   ondoneTheDatas(whichToclear.district,value);
                        //
                        //                 },
                        //                 onChanged:  (value) {
                        //                   filterSearchdrict(searchdistrictController.text);
                        //                 },
                        //
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 8,),
                        //
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 0),
                        //       child: Column(
                        //         children: [
                        //           CompositedTransformTarget(
                        //             link: layerLinkassembly,
                        //             child: Container(
                        //               height: 50,
                        //               child: TextField(
                        //                 controller: searchassemblyController,
                        //                 focusNode: searchassemblyFocusNode,
                        //
                        //
                        //
                        //                 decoration: InputDecoration(
                        //                   enabledBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   focusedBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   hintText: "Select Assembly",
                        //                   border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(25),
                        //
                        //                   ),
                        //                   fillColor: Colors.transparent,
                        //                   filled: true,
                        //                   hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //
                        //
                        //                   suffixIcon: searchassemblyController.text.isNotEmpty
                        //                       ? IconButton(
                        //                     icon: Icon(Icons.clear,size: 16,),
                        //                     onPressed: () {
                        //                       setState(() {
                        //                         clearTheDatas(whichToclear.assembly);
                        //                       });
                        //                     },
                        //                   )
                        //                       : null,
                        //                 ),
                        //                 textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //                 onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //                   ondoneTheDatas(whichToclear.assembly,value);
                        //
                        //                 },
                        //                 onChanged:  (value) {
                        //                   filterSearchassembly(searchassemblyController.text);
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 8,),
                        //   ],
                        // ),
                        //
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal:0),
                        //   child: Column(
                        //     children: [
                        //       CompositedTransformTarget(
                        //         link: layerLinkpanchayat,
                        //         child: Container(
                        //           height: 50,
                        //           child: TextField(
                        //             controller: searchpanchayatController,
                        //             focusNode: searchpanchayatFocusNode,
                        //             decoration: InputDecoration(
                        //
                        //               hintText: "Select Panchayat/Mun./Corp.",
                        //               enabledBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(25),
                        //
                        //               ),
                        //               fillColor: Colors.transparent,
                        //               filled: true,
                        //               hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //               suffixIcon: searchpanchayatController.text.isNotEmpty
                        //                   ? IconButton(
                        //                 icon: Icon(Icons.clear,size: 16,),
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     clearTheDatas(whichToclear.panchayt);
                        //                   });
                        //                 },
                        //               )
                        //                   : null,
                        //             ),
                        //             textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //             onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //               ondoneTheDatas(whichToclear.panchayt,value);
                        //
                        //             },
                        //             onChanged:  (value) {
                        //               filterSearchpanchayat(searchpanchayatController.text);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8,),
                        //
                        // Padding(
                        //   padding: const EdgeInsets. symmetric(horizontal: 0),
                        //   child: Column(
                        //     children: [
                        //       CompositedTransformTarget(
                        //         link: layerLinkward,
                        //         child: Container(
                        //           height: 50,
                        //           child: TextField(
                        //             controller: searchwardController,
                        //             focusNode: searchwardFocusNode,
                        //             decoration: InputDecoration(
                        //
                        //               hintText: "Select Ward",
                        //               enabledBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(25),
                        //
                        //               ),
                        //               fillColor: Colors.transparent,
                        //               filled: true,
                        //               hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //               suffixIcon: searchwardController.text.isNotEmpty
                        //                   ? IconButton(
                        //                 icon: Icon(Icons.clear,size: 16,),
                        //
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     clearTheDatas(whichToclear.ward);
                        //                   });
                        //                 },
                        //               )
                        //                   : null,
                        //             ),
                        //             textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //             onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //               ondoneTheDatas(whichToclear.ward,value);
                        //
                        //             },
                        //             onChanged:  (value) {
                        //               filterSearchward(searchwardController.text);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8,),
                        Stack(
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                height: 96,

                                'assets/dashbord/firstbg.svg', // Path to your SVG
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: 96,

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 158,

                                          child: const AutoSizeText(
                                            textAlign: TextAlign.start,
                                            "Amount Received",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.91,
                                            ),
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            minFontSize: 08,
                                            maxFontSize: 14,
                                            overflow: TextOverflow.ellipsis,
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
                                                fontWeight: FontWeight.w900,
                                                height: 0,
                                              ),
                                              maxLines: 1,
                                              minFontSize: 08,
                                              maxFontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor: 1.0,
                                              " ₹ ${controller.totalPrice2.toString()}",
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
                                            "Amount Pending",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.91,
                                            ),
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            minFontSize: 08,
                                            maxFontSize: 14,
                                            overflow: TextOverflow.ellipsis,
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
                                                fontWeight: FontWeight.w900,
                                                height: 0,
                                              ),
                                              maxLines: 1,
                                              minFontSize: 06,
                                              maxFontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor: 1.0,
                                              " ₹ ${controller.pendingPrice2.toString()}",
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
                        SizedBox(height: 10),
                        Obx(() {
                          if (controller.isLoadingSponsor.value) {
                            return ProgressINdigator();
                          } else if (controller.challengeSponsorlist.isEmpty) {
                            return const Center(
                              child: Text('No entries to show'),
                            );
                          } else {
                            return GetBuilder(
                              builder: (ReportController controller) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    return ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: constraints.maxHeight,
                                      ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .challengeSponsorlist
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color:
                                                      AppColors.primaryColor3,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
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
                                                                  FontWeight
                                                                      .w700,
                                                              height: 0,
                                                            ),
                                                            textScaleFactor:
                                                                1.0,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              controller
                                                                  .challengeSponsorlist[index]
                                                                  .name,
                                                              style: const TextStyle(
                                                                color: Color(
                                                                  0xFF3A3A3A,
                                                                ),
                                                                fontSize: 14,
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
                                                                        .challengeSponsorlist[index]
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
                                                                        .challengeSponsorlist[index]
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
                                                                        .challengeSponsorlist[index]
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
                                                                        .challengeSponsorlist[index]
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
                                                                    'Payable amount :  ',
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
                                                                    "₹${controller.challengeSponsorlist[index].payable.replaceAll(".00", "")}",
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
                                                                    'Date :  ',
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
                                                                    "${controller.challengeSponsorlist[index].date_time.replaceAll(".00", "")}",
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
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Row(
                                                        children: [
                                                          controller
                                                                      .challengeSponsorlist[index]
                                                                      .amount !=
                                                                  "0.00"
                                                              ? SizedBox()
                                                              : Expanded(
                                                                  flex: 2,
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      controller.updateamountsponsor(
                                                                        controller
                                                                            .challengeSponsorlist[index]
                                                                            .id,
                                                                        controller
                                                                            .orgdistModel
                                                                            .value,
                                                                        controller
                                                                            .orgassemblymodel
                                                                            .value,
                                                                        controller
                                                                            .orgPanchaytModel
                                                                            .value,
                                                                        controller
                                                                            .orgwardModel
                                                                            .value,
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                      margin:
                                                                          const EdgeInsets.only(
                                                                            left:
                                                                                6,
                                                                          ),
                                                                      height:
                                                                          28,
                                                                      decoration: ShapeDecoration(
                                                                        color: AppColors
                                                                            .primaryColor2,
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
                                                                            blurRadius:
                                                                                4,
                                                                            offset: Offset(
                                                                              0,
                                                                              4,
                                                                            ),
                                                                            spreadRadius:
                                                                                0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Pay Now',
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                'Fontsemibold',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                0,
                                                                          ),
                                                                          textScaleFactor:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      controller
                                                                  .challengeSponsorlist[index]
                                                                  .show_receipt_status !=
                                                              "1"
                                                          ? SizedBox()
                                                          : Row(
                                                              children: [
                                                                Expanded(
                                                                  child: IgnorePointer(
                                                                    ignoring:
                                                                        false, // ← allows interaction
                                                                    child: Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          Get.to(
                                                                            () => Receiptpagecontribution(
                                                                              name: controller.challengeSponsorlist[index].name,
                                                                              Amount: controller.challengeSponsorlist[index].amount,
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
                                                                                AppColors.primaryColor2,
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
                                                                              'Receipt',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 10,
                                                                                fontFamily: 'Fontsemibold',
                                                                                fontWeight: FontWeight.w500,
                                                                                height: 0,
                                                                              ),
                                                                              textScaleFactor: 1.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Positioned(
                                                right: 8,
                                                top: 50,

                                                child: IgnorePointer(
                                                  ignoring: true,
                                                  child: Container(
                                                    width: 100,
                                                    child: AutoSizeText(
                                                      textAlign: TextAlign.end,
                                                      "₹${controller.challengeSponsorlist[index].amount.trim().replaceAll(".00", "")}",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            controller
                                                                    .challengeSponsorlist[index]
                                                                    .amount ==
                                                                "0.00"
                                                            ? Color(0xFFF60606)
                                                            : Color(0xFF3A3A3A),
                                                        fontFamily:
                                                            'Fontsemibold',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.91,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                      maxLines: 2,
                                                      minFontSize: 08,
                                                      maxFontSize: 18,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        }),
                      ],
                    ),
                  ),

                  ///third tab starts ///
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding:  EdgeInsets.symmetric(horizontal: 0),
                        //       child: Column(
                        //         children: [
                        //           CompositedTransformTarget(
                        //             link: layerLinkdrict,
                        //             child: Container(
                        //               height: 50,
                        //               width: double.infinity,
                        //               child: TextField(
                        //                 controller: searchdistrictController,
                        //                 focusNode: searchdrictFocusNode,
                        //                 decoration: InputDecoration(
                        //                   enabledBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   focusedBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //
                        //                   border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(25),
                        //
                        //                   ),
                        //                   fillColor: Colors.transparent,
                        //                   filled: true,
                        //                   hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //                   hintText: "Select District",
                        //
                        //
                        //                   suffixIcon: searchdistrictController.text.isNotEmpty
                        //                       ? IconButton(
                        //                     icon: Icon(Icons.clear,size: 16,),
                        //                     onPressed: () {
                        //                       setState(() {
                        //                         clearTheDatas(whichToclear.district);
                        //
                        //                       });
                        //                     },
                        //                   )
                        //                       : null,
                        //                 ),
                        //
                        //                 textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //                 onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //                   ondoneTheDatas(whichToclear.district,value);
                        //
                        //                 },
                        //                 onChanged:  (value) {
                        //                   filterSearchdrict(searchdistrictController.text);
                        //                 },
                        //
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 8,),
                        //
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 0),
                        //       child: Column(
                        //         children: [
                        //           CompositedTransformTarget(
                        //             link: layerLinkassembly,
                        //             child: Container(
                        //               height: 50,
                        //               child: TextField(
                        //                 controller: searchassemblyController,
                        //                 focusNode: searchassemblyFocusNode,
                        //
                        //
                        //
                        //                 decoration: InputDecoration(
                        //                   enabledBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   focusedBorder: const OutlineInputBorder(
                        //                       borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                       borderRadius: BorderRadius.all(Radius.circular(12))
                        //                   ),
                        //                   hintText: "Select Assembly",
                        //                   border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(25),
                        //
                        //                   ),
                        //                   fillColor: Colors.transparent,
                        //                   filled: true,
                        //                   hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //
                        //
                        //                   suffixIcon: searchassemblyController.text.isNotEmpty
                        //                       ? IconButton(
                        //                     icon: Icon(Icons.clear,size: 16,),
                        //                     onPressed: () {
                        //                       setState(() {
                        //                         clearTheDatas(whichToclear.assembly);
                        //                       });
                        //                     },
                        //                   )
                        //                       : null,
                        //                 ),
                        //                 textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //                 onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //                   ondoneTheDatas(whichToclear.assembly,value);
                        //
                        //                 },
                        //                 onChanged:  (value) {
                        //                   filterSearchassembly(searchassemblyController.text);
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 8,),
                        //   ],
                        // ),
                        //
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal:0),
                        //   child: Column(
                        //     children: [
                        //       CompositedTransformTarget(
                        //         link: layerLinkpanchayat,
                        //         child: Container(
                        //           height: 50,
                        //           child: TextField(
                        //             controller: searchpanchayatController,
                        //             focusNode: searchpanchayatFocusNode,
                        //             decoration: InputDecoration(
                        //
                        //               hintText: "Select Panchayat/Mun./Corp.",
                        //               enabledBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(25),
                        //
                        //               ),
                        //               fillColor: Colors.transparent,
                        //               filled: true,
                        //               hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //               suffixIcon: searchpanchayatController.text.isNotEmpty
                        //                   ? IconButton(
                        //                 icon: Icon(Icons.clear,size: 16,),
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     clearTheDatas(whichToclear.panchayt);
                        //                   });
                        //                 },
                        //               )
                        //                   : null,
                        //             ),
                        //             textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //             onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //               ondoneTheDatas(whichToclear.panchayt,value);
                        //
                        //             },
                        //             onChanged:  (value) {
                        //               filterSearchpanchayat(searchpanchayatController.text);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8,),
                        //
                        // Padding(
                        //   padding: const EdgeInsets. symmetric(horizontal: 0),
                        //   child: Column(
                        //     children: [
                        //       CompositedTransformTarget(
                        //         link: layerLinkward,
                        //         child: Container(
                        //           height: 50,
                        //           child: TextField(
                        //             controller: searchwardController,
                        //             focusNode: searchwardFocusNode,
                        //             decoration: InputDecoration(
                        //
                        //               hintText: "Select Ward",
                        //               enabledBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(color: AppColors.primaryColor2,width: 1),
                        //                   borderRadius: BorderRadius.all(Radius.circular(12))
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(25),
                        //
                        //               ),
                        //               fillColor: Colors.transparent,
                        //               filled: true,
                        //               hintStyle: const TextStyle(color: Color(0xFF757575),fontFamily: "Fontsemibold",fontSize: 14),
                        //               suffixIcon: searchwardController.text.isNotEmpty
                        //                   ? IconButton(
                        //                 icon: Icon(Icons.clear,size: 16,),
                        //
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     clearTheDatas(whichToclear.ward);
                        //                   });
                        //                 },
                        //               )
                        //                   : null,
                        //             ),
                        //             textInputAction: TextInputAction.done, // ✅ Shows the tick button on the keyboard
                        //             onSubmitted: (value) { // ✅ Called when tick (✔) is pressed
                        //
                        //               ondoneTheDatas(whichToclear.ward,value);
                        //
                        //             },
                        //             onChanged:  (value) {
                        //               filterSearchward(searchwardController.text);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8,),
                        Stack(
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                height: 96,

                                'assets/dashbord/firstbg.svg', // Path to your SVG
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: 96,

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 158,

                                          child: const AutoSizeText(
                                            textAlign: TextAlign.start,
                                            "Amount Received",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.91,
                                            ),
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            minFontSize: 08,
                                            maxFontSize: 14,
                                            overflow: TextOverflow.ellipsis,
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
                                                fontWeight: FontWeight.w900,
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
                                        ),
                                      ],
                                    ),
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
                            return const Center(
                              child: Text('No entries to show'),
                            );
                          } else {
                            return GetBuilder(
                              builder: (ReportController controller) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    return ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: constraints.maxHeight,
                                      ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            controller.contributionList.length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color:
                                                      AppColors.primaryColor3,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
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
                                                                  FontWeight
                                                                      .w700,
                                                              height: 0,
                                                            ),
                                                            textScaleFactor:
                                                                1.0,
                                                          ),
                                                          Expanded(
                                                            child: Text(
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
                                                                    FontWeight
                                                                        .w700,
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
                                                                    'Payable amount :  ',
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
                                                                    "₹${controller.contributionList[index].amount.replaceAll(".00", "")}",
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
                                                                    'Date :  ',
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
                                                                    "${controller.contributionList[index].date}",
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
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: IgnorePointer(
                                                              ignoring:
                                                                  false, // ← allows interaction
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.to(
                                                                      () => Receiptpagecontribution(
                                                                        name: controller
                                                                            .contributionList[index]
                                                                            .name,
                                                                        Amount: controller
                                                                            .contributionList[index]
                                                                            .amount,
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                    margin:
                                                                        const EdgeInsets.only(
                                                                          left:
                                                                              6,
                                                                        ),
                                                                    height: 28,
                                                                    decoration: ShapeDecoration(
                                                                      color: AppColors
                                                                          .primaryColor2,
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                      ),
                                                                      shadows: const [
                                                                        BoxShadow(
                                                                          color: Color(
                                                                            0x3F000000,
                                                                          ),
                                                                          blurRadius:
                                                                              4,
                                                                          offset: Offset(
                                                                            0,
                                                                            4,
                                                                          ),
                                                                          spreadRadius:
                                                                              0,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: const Center(
                                                                      child: Text(
                                                                        'Receipt',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              10,
                                                                          fontFamily:
                                                                              'Fontsemibold',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height:
                                                                              0,
                                                                        ),
                                                                        textScaleFactor:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Positioned(
                                                right: 8,
                                                top: 50,

                                                child: IgnorePointer(
                                                  ignoring: true,
                                                  child: Container(
                                                    width: 100,
                                                    child: AutoSizeText(
                                                      textAlign: TextAlign.end,
                                                      "₹${controller.contributionList[index].amount.trim().replaceAll(".00", "")}",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            controller
                                                                    .contributionList[index]
                                                                    .amount ==
                                                                "0.00"
                                                            ? Color(0xFFF60606)
                                                            : Color(0xFF3A3A3A),
                                                        fontFamily:
                                                            'Fontsemibold',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.91,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                      maxLines: 2,
                                                      minFontSize: 08,
                                                      maxFontSize: 18,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        }),
                      ],
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
        controller.fullproducts();
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
        controller.fullproducts();
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
        controller.fullproducts();
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
        controller.fullproducts();
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
    controller.fullproducts();
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
    controller.fullproducts();
  }

  ///  filter code the sponsorship /////////////

  scrollToEnd_S() {
    _scrollController_S.animateTo(
      _scrollController_S.offset + 160, // Scroll to the bottom
      duration: Duration(milliseconds: 500), // Smooth scrolling duration
      curve: Curves.easeOut, // Animation curve
    );
  }

  TextEditingController searchdistrictController_S = TextEditingController();
  FocusNode searchdrictFocusNode_S = FocusNode();

  TextEditingController searchassemblyController_S = TextEditingController();
  FocusNode searchassemblyFocusNode_S = FocusNode();

  final LayerLink layerLinkdrict_S = LayerLink();
  final LayerLink layerLinkassembly_S = LayerLink();

  void hideDropdown_S() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

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

      controller.orgassemblyList_S.isEmpty
          ? null
          : controller.orgassemblyList_S.clear();
    } else if (value == whichToclear.ward) {
      controller.orgWardModel_S.value = null;
    }
    hideDropdown();
    controller.challegesponsorList();
  }
}

enum whichToclear { district, assembly, panchayt, ward }
