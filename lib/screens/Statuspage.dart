import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/Appcore/helper.dart';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image/image.dart' as img;

import 'NewHomeScreen.dart';

class StatusScreen extends StatefulWidget {
  String name;
  StatusScreen({required this.name});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
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
                  'Make my status',
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
                // margin: const EdgeInsets.all(8),
                // decoration: ShapeDecoration(
                //   color: Colors.white,
                //   shape: RoundedRectangleBorder(
                //     side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                //     borderRadius: BorderRadius.circular(18),
                //   ),
                // ),
                // child: IconButton(
                //   padding: const EdgeInsets.all(8),
                //   onPressed: () {Get.back();},
                //   icon: SvgPicture.asset(
                //     'assets/images/bellicon.svg',
                //     width: 16,
                //     height: 20,
                //     semanticsLabel: 'Example SVG',
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? imagefile;
  void pickImage() async {
    XFile? image;
    final picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final cropedfile = await cropImages(image);
      setState(() {
        imagefile = File(cropedfile.path);
      });
    }
  }

  Future<CroppedFile> cropImages(XFile image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image1',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,

          aspectRatioPresets: [
            CropAspectRatioPreset.square, // Square aspect ratio (1:1)
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          rectHeight: 124,
          rectWidth: 124,
          aspectRatioPresets: [CropAspectRatioPresetCustom()],
        ),
      ],
    );

    return croppedFile!;
  }

  /// this is for the

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
                alignment: Alignment.center,
                children: [
                  if (imagefile != null)
                    Positioned(
                      right: 47, // Adjust as per circle position on the placeholder
                      top: 80, // Adjust as per circle position on the placeholder
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.transparent, width: 0),
                        ),
                        child: ClipOval(
                          child: Image(
                            image: FileImage(imagefile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/thennala/status_image_new.png',
                      width: 340, // Adjust as per your template
                      height: 400, // Adjust as per your template
                      fit: BoxFit.fill,
                    ),
                  ),

                  Positioned(
                    // Position name below the uploaded photo
                    // Photo is at right: 47, top: 80, size: 120x120
                    // Photo center horizontally: (340 - 47 - 60) = 233 from left
                    // Name width: 150, so left position: 233 - 75 = 158
                    left: (355 - 47 - 60) - 75, // Center below photo horizontally
                    top: 80 + 128 , // Below the photo: photo top (80) + photo height (120) + spacing (10)
                    child: Container(
                      height: 50, // Increased height to accommodate 2 lines
                      width: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          textAlign: TextAlign.center,
                          widget.name,
                          style: TextStyle(
                            wordSpacing: -1,
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            height: 1.2, // Changed from 0 to allow proper line spacing
                          ),
                          textScaleFactor: 1.0,
                          maxLines: 2,
                          minFontSize: 8,
                          maxFontSize: 18,
                          overflow: TextOverflow.visible, // Changed to visible to allow wrapping
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

              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => pickImage(),
                      child: Container(
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
                            SvgPicture.asset(
                              'assets/upload.svg',
                              width: 22,
                              height: 22,
                              semanticsLabel: 'Example SVG',
                            ),
                            Text(
                              'Upload Photo',
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
                  SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        capturePng(
                          pathName: 'status_image',
                          context: context,
                        );
                      },
                      child: Container(
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
                            SvgPicture.asset(
                              'assets/share.svg',
                              width: 22,
                              height: 22,
                              semanticsLabel: 'Example SVG',
                            ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (1, 1); // Ensures a perfect square

  @override
  String get name => '1x1 (Square)';
}
