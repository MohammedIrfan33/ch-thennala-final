import 'package:chcenterthennala/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/PaymentIntentcontroller.dart';

class Paymentintent extends StatefulWidget {
  String totalmaount;
  String order_id;
  String name;
  String nameOrg;
  String phone;
  String hash;
  int count;
  bool isUpi;
  bool isUpiPhonepe;
  String customerID;

  Paymentintent({
    required this.customerID,
    required this.totalmaount,
    required this.name,
    required this.nameOrg,
    required this.order_id,
    required this.hash,
    required this.count,
    required this.isUpi,
    required this.isUpiPhonepe,
    required this.phone,
  });

  @override
  State<Paymentintent> createState() => _PaymentintentState();
}

class _PaymentintentState extends State<Paymentintent>
    with WidgetsBindingObserver {
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
                  'Payment',
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_getxcontroller.paymentLaunched &&
        !_getxcontroller.hasReturnedFromPayment &&
        state == AppLifecycleState.resumed) {
      _getxcontroller.hasReturnedFromPayment = true;

      _getxcontroller.CheckThePayment(widget.order_id, widget.nameOrg);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final Paymentintentcontroller _getxcontroller = Get.put(
    Paymentintentcontroller(),
  );

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 8),

            Align(
              alignment: Alignment.center,
              child: IntrinsicWidth(
                child: Container(
                  padding: EdgeInsets.only(right: 12),
                  height: 66,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2FBFF), // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.006,
                        ), // Shadow color with opacity
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(0, -1), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ), // Add padding inside the container
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          color: AppColors.primaryColor2,
                          size: 36,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${widget.totalmaount.replaceAll(".0", "")}',
                              style: const TextStyle(
                                color: AppColors.primaryColor2,
                                fontSize: 40,
                                fontFamily: 'Fontsemibold',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Select Payment Option',
                      style: TextStyle(
                        color: const Color(0xFF9597A4),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: const Color(0xFF005876),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: _size.height * (.042)),
            GestureDetector(
              onTap: () {
                _getxcontroller.isChecked1.value =
                    _getxcontroller.isChecked1.isTrue ? false : true;

                _getxcontroller.isChecked2.value = false;
                _getxcontroller.isChecked3.value = false;
              },
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF9597A4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 18),
                    Image.asset(
                      "assets/StaticImg/gpay.png",
                      width: 34,
                      height: 29,
                    ),
                    SizedBox(width: 28),
                    Text(
                      'Google Pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _getxcontroller.isChecked1.value =
                              _getxcontroller.isChecked1.isTrue ? false : true;
                          _getxcontroller.isChecked2.value = false;
                          _getxcontroller.isChecked3.value = false;
                        },
                        child: CustomPaint(
                          size: Size(14.0, 14.0),
                          painter: RadioCheckboxPainter(
                            isChecked: _getxcontroller.isChecked1.value,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: _size.height * (.020)),
            GestureDetector(
              onTap: () {
                _getxcontroller.isChecked2.value =
                    _getxcontroller.isChecked2.isTrue ? false : true;
                _getxcontroller.isChecked3.value = false;
                _getxcontroller.isChecked1.value = false;
              },
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF9597A4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 18),
                    Image.asset(
                      "assets/StaticImg/phonepe.png",
                      width: 34,
                      height: 29,
                    ),
                    SizedBox(width: 28),
                    Text(
                      'PhonePe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _getxcontroller.isChecked3.value = false;
                          _getxcontroller.isChecked1.value = false;
                          _getxcontroller.isChecked2.value =
                              _getxcontroller.isChecked2.isTrue ? false : true;
                        },
                        child: CustomPaint(
                          size: Size(14.0, 14.0),
                          painter: RadioCheckboxPainter(
                            isChecked: _getxcontroller.isChecked2.value,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: _size.height * (.020)),
            GestureDetector(
              onTap: () {
                _getxcontroller.isChecked3.value =
                    _getxcontroller.isChecked3.isTrue ? false : true;
                _getxcontroller.isChecked2.value = false;
                _getxcontroller.isChecked1.value = false;
              },
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF9597A4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 18),
                    Image.asset(
                      "assets/StaticImg/netcard.png",
                      width: 34,
                      height: 29,
                    ),
                    SizedBox(width: 28),
                    Expanded(
                      child: Text(
                        'Cards,Net Banking,UPI',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _getxcontroller.isChecked2.value = false;
                          _getxcontroller.isChecked1.value = false;
                          _getxcontroller.isChecked3.value =
                              _getxcontroller.isChecked3.isTrue ? false : true;
                        },
                        child: CustomPaint(
                          size: Size(14.0, 14.0),
                          painter: RadioCheckboxPainter(
                            isChecked: _getxcontroller.isChecked3.value,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.0),
                  ],
                ),
              ),
            ),

            SizedBox(height: _size.height * (.032)),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Make payment and wait until you get confirmation',
                    style: TextStyle(
                      color: const Color(0xFF9597A4),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: const Color(0xFF005876),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              'പയ്മെന്റ് നടത്തി സ്ഥിതീകരണം ലഭിക്കുന്നതുവരെ കാത്തിരിക്കുക ',
              style: TextStyle(
                color: const Color(0xFF9597A4),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Obx(() {
              if (_getxcontroller.isLoading.isTrue) {
                return Container(
                  height: 20,
                  width: 20,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 08),

                  child: InkWell(
                    onTap: () {
                      _getxcontroller.sendTheData(
                        widget.customerID,
                        widget.nameOrg,
                        widget.totalmaount,
                        widget.name,
                        widget.order_id,
                        widget.hash,
                        widget.count,
                        widget.isUpi,
                        widget.isUpiPhonepe,
                        widget.phone,
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, 0.50),
                          end: Alignment(1.00, 0.50),
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor2,
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class RadioCheckboxPainter extends CustomPainter {
  final bool isChecked;

  RadioCheckboxPainter({required this.isChecked});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF005876)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the outer circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    if (isChecked) {
      // Draw the inner dot if checked
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(size.center(Offset.zero), size.width / 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
