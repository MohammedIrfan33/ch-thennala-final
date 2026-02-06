import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'newReportInnerpage.dart';

class Newreport extends StatefulWidget {
  final String? GlobalId;
  final String uniqueid;
  final Function(int)? onTabChange;

  Newreport({required this.GlobalId, required this.uniqueid, this.onTabChange});

  @override
  State<Newreport> createState() => HistoryState(GlobalId: GlobalId);
}

class HistoryState extends State<Newreport> {
  final String? GlobalId;

  HistoryState({required this.GlobalId});

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(left: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                      const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
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
                    'Report',
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
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                      const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
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
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    controller.fetchPanchaythapi(["1"]);
    controller.fullproducts();

    addListnnerFortheTextController();
  }

  @override
  void dispose() {
    disposetheview();

    super.dispose();
  }

  @override
  void didPopNext() {
    controller.fetchAssemblyapi("1");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
  }

  var controller = Get.put(Newreportcontroller());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 8),
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    CompositedTransformTarget(
                      link: layerLinkassembly,
                      child: Container(
                        height: 50,
                        child: TextField(
                          controller: searchassemblyController,
                          focusNode: searchassemblyFocusNode,
                          decoration: InputDecoration(
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
                            hintText: "Select Assembly",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle: const TextStyle(
                              color: Color(0xFF757575),
                              fontFamily: "Fmedium",
                              fontSize: 14,
                            ),
                            suffixIcon: searchassemblyController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, size: 16),
                                    onPressed: () {
                                      setState(() {
                                        clearTheDatas(whichToclear.assembly);
                                      });
                                    },
                                  )
                                : null,
                          ),
                          textInputAction: TextInputAction
                              .done, // ✅ Shows the tick button on the keyboard
                          onSubmitted: (value) {
                            // ✅ Called when tick (✔) is pressed

                            ondoneTheDatas(whichToclear.assembly, value);
                          },
                          onChanged: (value) {
                            filterSearchassembly(searchassemblyController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //SizedBox(height: 8),
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
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor2,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    hintStyle: const TextStyle(
                      color: Color(0xFF757575),
                      fontFamily: "Fontsemibold",
                      fontSize: 14,
                    ),
                    suffixIcon: searchpanchayatController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, size: 16),
                            onPressed: () {
                              setState(() {
                                clearTheDatas(whichToclear.panchayt);
                              });
                            },
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction
                      .done, // ✅ Shows the tick button on the keyboard
                  onSubmitted: (value) {
                    // ✅ Called when tick (✔) is pressed

                    ondoneTheDatas(whichToclear.panchayt, value);
                  },
                  onChanged: (value) {
                    filterSearchpanchayat(searchpanchayatController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 8),

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
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor2,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    hintStyle: const TextStyle(
                      color: Color(0xFF757575),
                      fontFamily: "Fontsemibold",
                      fontSize: 14,
                    ),
                    suffixIcon: searchwardController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, size: 16),

                            onPressed: () {
                              setState(() {
                                clearTheDatas(whichToclear.ward);
                              });
                            },
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction
                      .done, // ✅ Shows the tick button on the keyboard
                  onSubmitted: (value) {
                    // ✅ Called when tick (✔) is pressed

                    ondoneTheDatas(whichToclear.ward, value);
                  },
                  onChanged: (value) {
                    filterSearchward(searchwardController.text);
                  },
                ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontWeight: FontWeight.w700,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                      maxLines: 1,
                                      minFontSize: 06,
                                      maxFontSize: 20,
                                      overflow: TextOverflow.ellipsis,
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
            SizedBox(height: 8),

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
                } else if (controller.newRportList.isEmpty) {
                  return const Center(child: Text('No entries to show'));
                } else {
                  return ListView.builder(
                    itemCount: controller.newRportList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        fit: StackFit.passthrough,
                        alignment: AlignmentDirectional.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),

                            decoration: ShapeDecoration(
                              color: AppColors.primaryColor3,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryColor2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  Newreportinnerpage(
                                    panyathID: controller
                                        .newRportList[index]
                                        .panchayatid,
                                    wardID:
                                        controller.newRportList[index].wardid,
                                  ),
                                );
                              },

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 12,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                                Expanded(
                                                  child: Text(
                                                    controller
                                                        .newRportList[index]
                                                        .ward,
                                                    style: TextStyle(
                                                      color: Color(0xFF3A3A3A),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      height: 0,
                                                    ),
                                                    textScaleFactor: 1.0,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .newRportList[index]
                                                              .panchayat,
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF3A3A3A,
                                                                ),
                                                                fontSize: 12,
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
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .newRportList[index]
                                                              .assembly,
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF3A3A3A,
                                                                ),
                                                                fontSize: 12,
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
                                                    const SizedBox(height: 4),
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
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            top: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 72,

                                  child: AutoSizeText(
                                    controller.newRportList[index].quantity ==
                                            "1"
                                        ? "${controller.newRportList[index].quantity} Pkt"
                                        : "${controller.newRportList[index].quantity} Pkts",
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontFamily: 'Fmedium',
                                      fontWeight: FontWeight.w900,
                                      height: 0,
                                      letterSpacing: 0.91,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 06,
                                    maxFontSize: 24,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  width: 72,

                                  child: AutoSizeText(
                                    "₹${controller.newRportList[index].amount.trim().replaceAll(".00", "")}",
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontFamily: 'Fregular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      letterSpacing: 0.91,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 06,
                                    maxFontSize: 12,
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

  // Scroll controller for SingleChildScrollView
  final ScrollController _scrollController = ScrollController();

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
    if (value == whichToclear.panchayt) {
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
