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

class ReceiptDownload extends StatefulWidget {
  String name;
  String Amount;
  ReceiptDownload({required this.name, required this.Amount});

  @override
  State<ReceiptDownload> createState() => _ReceiptDownloadState();
}

class _ReceiptDownloadState extends State<ReceiptDownload> {
  

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
                      width: 340,
                      height: 400,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 52, // Adjust as per your template
                    top: 233, // Adjust as per your template
                    child: Container(
                      width: 106,
                      height: 38,
                      child: Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,
                        children: [
                          AutoSizeText(
                            textAlign: TextAlign.start,
                            " ${widget.Amount.replaceAll(".00", "")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Fmedium',
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            minFontSize: 10,
                            maxFontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 105, // Adjust as per your template
                    top: 111, // Adjust as per your template
                    child: Container(
                      width: 220,

                      child: AutoSizeText(
                        "${widget.name}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Fmedium',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        minFontSize: 4,
                        maxFontSize: 12,
                        overflow: TextOverflow.ellipsis,
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
                      pathName: 'receipt',
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
