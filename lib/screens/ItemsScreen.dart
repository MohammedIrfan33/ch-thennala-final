import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:chcenterthennala/screens/QuickpayScreen.dart';

import '../Utils/colors.dart';
import '../controller/Sponsorshipcontroller.dart';
import '../widgets/PorgressIndicator.dart';

class itempage extends StatefulWidget {
  final String challengeid;
  final String? volunteerID;
  final String uniqueid;

  itempage({
    required this.uniqueid,
    required this.challengeid,
    required this.volunteerID,
  });

  @override
  State<itempage> createState() => _itempageState();
}

class _itempageState extends State<itempage> {
  final controller = Get.put(Sponsorshipcontroller());
  @override
  void dispose() {
    Get.delete<Sponsorshipcontroller>(); // Dispose of the controller
    super.dispose();
  }

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
                  'Sponsor',
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

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == 1);
  }

  Widget bottomBarTitle() {
    return Container(
      height: 50,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFD5D5D5)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Total Amount',
                style: TextStyle(
                  color: Color(0xFF3A3A3A),
                  fontSize: 14,
                  fontFamily: 'Fmedium',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
                textScaleFactor: 1.0,
              ),
            ),
            Expanded(
              child: Obx(
                () => Text(
                  textAlign: TextAlign.right,
                  "₹ ${controller.totalPrice.value}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Fontsemibold',
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                  textScaleFactor: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBarButton() {
    return InkWell(
      onTap: () {
        if (double.parse(controller.totalPrice.value) > 0) {
          Get.to(
            Quickpay(
              uniqueid: widget.uniqueid,
              modellist: controller.filteredProducts,
              totalmaount: controller.totalPrice.value,
              challengeid: widget.challengeid,
              volunteerID: widget.volunteerID,
            ),
          );
        } else {
          Get.snackbar(
            'Select', // Title of the Snackbar
            "please select any item ", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            // Position of the Snackbar
            backgroundColor: AppColors.primaryColor2,
            // Background color of the Snackbar
            colorText: Colors.white,
            // Text color of the Snackbar
            borderRadius: 10,
            titleText: const Text(
              'Select',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium', // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.0,
            ),
            messageText: const Text(
              "please select any item ",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fontsemibold', // Set your custom font family here
                fontSize: 14,
              ),
              textScaleFactor: 1.0,
            ),
            // Border radius of the Snackbar
            margin: const EdgeInsets.all(10),
            // Margin around the Snackbar
            duration: const Duration(
              seconds: 3,
            ), // Duration for which the Snackbar is displayed
          );
        }
      },
      child: Container(
        height: 50,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [AppColors.primaryColor, AppColors.primaryColor2],
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
            'Sponsor Now',
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: ProgressINdigator());
        } else if (controller.filteredProducts.isEmpty) {
          return const Center(child: Text('No entries to show'));
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  child: GetBuilder(
                    builder: (Sponsorshipcontroller controller) {
                      return ListView.builder(
                        itemCount: controller.filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Container(
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: .5,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE8F0FB),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 22),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller
                                                    .filteredProducts[index]
                                                    .name,
                                                style: const TextStyle(
                                                  color: Color(0xFF3A3A3A),
                                                  fontSize: 14,
                                                  fontFamily: 'Fontsemibold',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                                textScaleFactor: 1.0,
                                              ),
                                              Text(
                                                "₹${controller.filteredProducts[index].rate.replaceAll(".00", "")}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Fontsemibold',
                                                  fontWeight: FontWeight.w900,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1F2F4),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () => controller
                                                  .decreaseItemQuantity(index),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: ShapeDecoration(
                                                  color: Color(0xFFD5D5D5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 76,

                                              child: Center(
                                                child: TextField(
                                                  controller: controller
                                                      .txtcontrollers[index],
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    isDense:
                                                        true, // Removes extra space
                                                    contentPadding: EdgeInsets.all(
                                                      0,
                                                    ), // Adjust the padding as needed
                                                    border: InputBorder.none,
                                                    hintText: controller
                                                        .filteredProducts[index]
                                                        .quantity
                                                        .toString(),
                                                    hintStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          "Fontsemibold",
                                                    ),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  style: const TextStyle(
                                                    fontFamily: "Fontsemibold",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  onChanged: (text) {
                                                    controller.addItemQuantity(
                                                      index,
                                                      text,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => controller
                                                  .increaseItemQuantity(index),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      AppColors.primaryColor2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: .5,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE8F0FB),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),
                bottomBarTitle(),
                const SizedBox(height: 20),
                bottomBarButton(),
                const SizedBox(height: 25),
              ],
            ),
          );
        }
      }),
    );
  }
}
