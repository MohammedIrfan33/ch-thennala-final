import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:chcenterthennala/controller/TopvolunteersController.dart';

class TopVolunteer extends StatelessWidget {
  final controller = Get.put(TopvolunteerController());
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
                  'Top Leaders',
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.volunterlist.isEmpty) {
          return const Center(child: Text('No entries to show'));
        } else {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GetBuilder(
                        builder: (TopvolunteerController controller) {
                          return ListView.builder(
                            itemCount: controller.volunterlist.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Container(
                                  height: 86,
                                  decoration: ShapeDecoration(
                                    color: AppColors.primaryColor3,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 42,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: SvgPicture.asset(
                                                      "assets/images/topvolunteer.svg",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 6),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .volunterlist[index]
                                                          .name,
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 13,
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
                                                          .volunterlist[index]
                                                          .volunteernumber,
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF3A3A3A,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Fontsemibold',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${controller.volunterlist[index].amount.toString()}",
                                            style: const TextStyle(
                                              color: Color(0xFF3A3A3A),
                                              fontSize: 13,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                            textScaleFactor: 1.0,
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
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
