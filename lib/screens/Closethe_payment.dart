import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../Utils/colors.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:chcenterthennala/modles/AssembelyModel.dart';
import 'package:chcenterthennala/modles/PanchayatModel.dart';
import 'package:chcenterthennala/modles/Sponsorshipmodel.dart';
import '../ApiLists/Apis.dart';
import '../controller/QuickpayDonation.dart';
import '../controller/QuickpayscreenController.dart';
import '../controller/SettlepaymentController.dart';
import '../modles/DistrictModel.dart';
import '../modles/WardModel.dart';
import '../widgets/PorgressIndicator.dart';
import '../widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class Closethepayment extends StatelessWidget {
  String Volunter_id;
  String name;
  String mobile;

  Closethepayment({
    required this.Volunter_id,
    required this.name,
    required this.mobile,
  });

  final controller = Get.put(SettlePaymentController());

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
                  'Collection Settlement',
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
    controller.ChallengeHistory(Volunter_id, name, mobile);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      if (controller.isLoading1.isFalse) {
                        return Center(
                          child: Text(
                            '₹ ${controller.totalPrice} ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontFamily: 'Fontsemibold',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        );
                      } else {
                        return ProgressINdigator();
                      }
                    }),

                    const SizedBox(height: 8),

                    Container(
                      width: 136,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 5,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Image.asset(
                              "assets/images/razorpayfinallogo.png",
                            ),
                          ),
                          const Text(
                            'Secure with razorpay',
                            style: TextStyle(
                              color: Color(0xFF747474),
                              fontSize: 10,
                              fontFamily: 'Fontsemibold',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: (text) {
                            controller.calculate();
                          },
                          textAlign: TextAlign.center,
                          controller: controller.txtAmount,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],

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
                                color: Color(0xff98bdef),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: " Enter Amount",
                            hintStyle: const TextStyle(
                              color: Color(0xFF757575),
                              fontFamily: "Fontsemibold",
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: "Fontsemibold",
                            height: 1.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26.0,
                        vertical: 16,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Balance amount ',
                          style: TextStyle(
                            color: Color(0xFF3A591F),
                            fontSize: 15,
                            fontFamily: 'Fontsemibold',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    Obx(() {
                      return Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 16),
                        margin: EdgeInsets.symmetric(horizontal: 26),

                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 0,
                              color: Color(0xff98bdef),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            '₹ ${controller.balance} ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Fontsemibold',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return InkWell(
                    onTap: () {
                      controller.validateandproceed();
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
            ),
          ],
        ),
      ),
    );
  }
}
