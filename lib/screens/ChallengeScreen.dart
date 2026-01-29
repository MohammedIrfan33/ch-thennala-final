import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utils/colors.dart';
import '../controller/ChallengeController.dart';

class ChallengeSCreen extends StatelessWidget {
  final challengecontroller = Get.put(Challengecontroller());

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
                child: Image.network(challengecontroller.Challengedeatils.first.challenge_image),
              ),
              const Center(
                  child: Text(
                'Details',
                style: TextStyle(
                  color: Color(0xFF3A3A3A),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
                    textScaleFactor: 1.0,
              )),
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
                  onPressed: () {},
                  icon: Image.asset("assets/images/notiffiicon.png"),
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
      body:  Obx(() => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 22),
                child: Container(
                  height: 285,
                  padding: const EdgeInsets.all(16),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0x33757575)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 297,
                          height: 111,
                          decoration: ShapeDecoration(
                            // image: const DecorationImage(
                            //   image:AssetImage("assets/images/challange.png"),
                            //   fit: BoxFit.cover,
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Image.network(
                              challengecontroller
                                  .Challengedeatils.value.first.challenge_image,
                              height: 100,
                              width: 150),
                        ),

                      const SizedBox(height: 16),
                      SizedBox(
                          width: double.infinity,
                          child: Text(
                            challengecontroller
                                .Challengedeatils.value.first.challenge_name,
                            style: const  TextStyle(
                              color: Color(0xFF29272E),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.64,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),

                      const SizedBox(height: 16),
                     SizedBox(
                          width: double.infinity,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
              challengecontroller
                  .Challengedeatils.value.first.description,
                                  style: TextStyle(
                                    color: Color(0xFF615F68),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: -0.56,
                                  ),
                                ),
                                TextSpan(
                                  text: 'more...',
                                  style: TextStyle(
                                    color: Color(0xFF71AD3D),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: -0.56,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [AppColors.primaryColor, AppColors.primaryColor2],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Participate Now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.56,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}
