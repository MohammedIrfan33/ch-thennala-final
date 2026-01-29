import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:chcenterthennala/Appcore/helper.dart';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image/image.dart' as img;

class Receiptpagecontribution extends StatefulWidget {
  String name;
  String Amount;
  Receiptpagecontribution({required this.name, required this.Amount});

  @override
  State<Receiptpagecontribution> createState() => _ReceiptDownloadState();
}

class _ReceiptDownloadState extends State<Receiptpagecontribution> {

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
                  'Receipt',
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Center(
        child: Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/thennala/receipt.jpg',
                      width: 340, // Adjust as per your template
                      height: 400, // Adjust as per your template
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 60, // Adjust as per your template
                    top: 232, // Adjust as per your template
                    child: Container(
                      width: 120,
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          textAlign: TextAlign.left,
                          "${widget.Amount.replaceAll(".00", "")}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Fmedium',
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: 48, left: 24, right: 24),

              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    capturePng(
                      pathName: 'receipt_contribution',
                      context: context,
                    );
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 60,
                    height: 41,
                    decoration: ShapeDecoration(
                      color: AppColors.primaryColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Share',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
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
