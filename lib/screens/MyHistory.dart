import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chcenterthennala/widgets/my_textfield.dart';
import '../ApiLists/Apis.dart';
import '../Utils/colors.dart';
import '../controller/ControllermyHistrory.dart';
import '../main.dart';
import '../modles/WardModel.dart';
import '../widgets/PorgressIndicator.dart';
import 'package:http/http.dart' as http;

import '../widgets/funtionDate.dart';
import 'ReceiptDownloadpage.dart';
import 'ReceiptPageContribution.dart';
import 'Statuspage.dart';

class Myhistory extends StatefulWidget {
  String? identifier;
  final Function(int)? onTabChange;
  Myhistory({required this.identifier, this.onTabChange});

  @override
  State<Myhistory> createState() => _HistoryState();
}

class _HistoryState extends State<Myhistory> with RouteAware {
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
                    'My History',
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
                Container(
                  width: 53,
                  height: 53,
                  margin: const EdgeInsets.all(8),
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.localdatainbase();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.localdatainbase();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  var controller = Get.put(Controllermyhistrory());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Obx(() {
                if (controller.isLoading1.value) {
                  return Center(child: ProgressINdigator());
                } else if (controller.contributionlist.isEmpty) {
                  return Center(child: Text('No Data'));
                } else {
                  return ListView.builder(
                    itemCount: controller.contributionlist.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: ShapeDecoration(
                              color: AppColors.primaryColor3,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Text(
                                                'Name   :',
                                                style: TextStyle(
                                                  color: Color(0xFF3A3A3A),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                                textScaleFactor: 1.0,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller
                                                      .contributionlist[index]
                                                      .name,
                                                  style: TextStyle(
                                                    color: Color(0xFF3A3A3A),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
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
                                              Expanded(
                                                child: Column(
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
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .contributionlist[index]
                                                              .district,
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
                                                        const Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          'Assembly : ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .contributionlist[index]
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
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Panchayath : ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .contributionlist[index]
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
                                                        const Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          'Ward/Club :  ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .contributionlist[index]
                                                              .ward,
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
                                                        const Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          'Date   :  ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          getthedate(
                                                            controller
                                                                .contributionlist[index]
                                                                .date,
                                                          ),
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
                                                        const Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          'Status   :  ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                              .contributionlist[index]
                                                              .status,
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
                                                        const Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          'Transactionid   :  ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            controller
                                                                .contributionlist[index]
                                                                .transactionid,
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
                                                            textScaleFactor:
                                                                1.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          'Transaction Type :  ',
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xFF3A3A3A,
                                                            ),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        Text(
                                                          controller
                                                                      .contributionlist[index]
                                                                      .donation ==
                                                                  "1"
                                                              ? 'Donation'
                                                              : controller
                                                                        .contributionlist[index]
                                                                        .sponorship ==
                                                                    "1"
                                                              ? 'Sponorship'
                                                              : 'Challenge',
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
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .contributionlist[index]
                                                            .donation ==
                                                        "1") {
                                                      Get.to(
                                                        Receiptpagecontribution(
                                                          name: controller
                                                              .contributionlist[index]
                                                              .name,
                                                          Amount: controller
                                                              .contributionlist[index]
                                                              .amount,
                                                        ),
                                                      );
                                                    } else if (controller
                                                            .contributionlist[index]
                                                            .sponorship ==
                                                        "1") {
                                                      Get.to(
                                                        Receiptpagecontribution(
                                                          name: controller
                                                              .contributionlist[index]
                                                              .name,
                                                          Amount: controller
                                                              .contributionlist[index]
                                                              .amount,
                                                        ),
                                                      );
                                                    } else {
                                                      Get.to(
                                                        ReceiptDownload(
                                                          name: controller
                                                              .contributionlist[index]
                                                              .name,
                                                          Amount: controller
                                                              .contributionlist[index]
                                                              .amount,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 15,
                                                        ),

                                                    decoration: ShapeDecoration(
                                                      color: AppColors
                                                          .primaryColor,
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
                                                          blurRadius: 4,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Receipt',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                        textScaleFactor: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              controller
                                                          .contributionlist[index]
                                                          .donation ==
                                                      "0"
                                                  ? Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.to(
                                                            StatusScreen(
                                                              name: controller
                                                                  .contributionlist[index]
                                                                  .name,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 15,
                                                              ),

                                                          decoration: ShapeDecoration(
                                                            color: AppColors
                                                                .primaryColor,
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
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                              textScaleFactor:
                                                                  1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
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
                            right: 8,

                            top: 54,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 92,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      "₹${controller.contributionlist[index].amount.trim().replaceAll(".00", "")}",
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
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                    Text(
                                      'Success',
                                      style: TextStyle(
                                        color: Color(0xFF0D8209),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
  }
}
