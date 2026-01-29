import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:chcenterthennala/controller/Usercontroller.dart';

import '../Utils/colors.dart';
import '../widgets/PorgressIndicator.dart';
import '../widgets/my_textfield.dart';

class VolunteerLogin extends StatelessWidget {
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
                  'Leaders Login',
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

  final controller = Get.put(Usercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * (1 / 10)),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontSize: 30,
                  fontFamily: 'Fontsemibold',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                textScaleFactor: 1.0,
              ),
            ),
            const SizedBox(height: 30),
            MyTextField(
              isNumber: false,
              fontPading: 0,
              controller: controller.userid,
              hintText: 'Enter Username',
              obscureText: false,
              height: 50,
            ),
            const SizedBox(height: 28),
            MyTextField(
              isNumber: false,
              fontPading: 0,
              controller: controller.password,
              hintText: 'Enter Password',
              obscureText: false,
              height: 50,
            ),
            const SizedBox(height: 28),
            Obx(() {
              if (controller.isLoading.value) {
                return ProgressINdigator();
              } else {
                return InkWell(
                  onTap: () {
                    if (controller.userid.text.isEmpty ||
                        controller.password.text.isEmpty) {
                      Get.snackbar(
                        'Enter', // Title of the Snackbar
                        "Please Enter Username and password ", // Message of the Snackbar
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          'Enter',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                'Fmedium', // Set your custom font family here
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: 1.0,
                        ),
                        messageText: Text(
                          'Please Enter Username and password',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                'Fontsemibold', // Set your custom font family here
                            fontSize: 14,
                          ),
                          textScaleFactor: 1.0,
                        ), // Position of the Snackbar
                        backgroundColor: AppColors
                            .primaryColor2, // Background color of the Snackbar
                        colorText: Colors.white, // Text color of the Snackbar
                        borderRadius: 10, // Border radius of the Snackbar
                        margin: EdgeInsets.all(
                          10,
                        ), // Margin around the Snackbar
                        duration: Duration(
                          seconds: 3,
                        ), // Duration for which the Snackbar is displayed
                      );
                    } else {
                      controller.volunteerlogin();
                    }
                  },
                  child: Container(
                    width: 325,
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
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Fontsemibold',
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
          ],
        ),
      ),
    );
  }
}
