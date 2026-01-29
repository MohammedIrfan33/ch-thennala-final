import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/screens/homepage3.dart';

import 'NewHomeScreen.dart';
import 'Statuspage.dart';

class PaymentsuccessScreen extends StatelessWidget {
  int isShare;
  String name;

  PaymentsuccessScreen({required this.isShare, required this.name});

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
                    Get.offUntil(
                      GetPageRoute(page: () => Homepage3()),
                      (route) => false,
                    );
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
                  'Payment Status',
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

                child: SizedBox(width: 16, height: 20),
              ),
            ],
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * (1 / 10)),
            SvgPicture.asset(
              'assets/successtick.svg',
              width: 65,
              height: 65,
              semanticsLabel: 'Example SVG',
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Text(
                'SUCCESS!',
                style: TextStyle(
                  color: Color(0xFF2C774E),
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your payment was completed',
                style: TextStyle(
                  color: Color(0xFF2C774E),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(height: 65),
            InkWell(
              onTap: isShare == 0
                  ? () {
                      Get.off(Homepage3());
                    }
                  : () {
                      Get.off(StatusScreen(name: name));
                    },
              child: Container(
                width: 184,
                height: 40,
                decoration: ShapeDecoration(
                  color: Color(0xFF2C774E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    textScaleFactor: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
