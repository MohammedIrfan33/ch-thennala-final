// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:shadekadapadi/Utils/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:image/image.dart' as img;
//
// class HunderedClub extends StatefulWidget{
//   String name;
//   String name_panchayath;
//
//
//   HunderedClub({required this.name,required this.name_panchayath});
//
//   @override
//   State<HunderedClub> createState() => _ReceiptDownloadState();
// }
//
// class _ReceiptDownloadState extends State<HunderedClub> {
//   final GlobalKey _globalKey = GlobalKey();
//   File? _savedImage;
//
//   Future<void> _capturePng(bool isshare) async {
//     try {
//       RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       var image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();
//
//
//       // // Use the image package to decode and crop the image
//       // img.Image decodedImage = img.decodeImage(pngBytes)!;
//       //
//       // // Define the crop area (e.g., crop 100x100 from the top-left corner)
//       // img.Image croppedImage = img.copyCrop(decodedImage,  x:0, y: 25, width: decodedImage.width, height: decodedImage.height-50);
//       //
//       // // Now you can use the cropped image or save it, etc.
//       // // For example, encode the cropped image back to png
//       // Uint8List croppedPngBytes = Uint8List.fromList(img.encodePng(croppedImage));
//
//
//
//
//
//
//
//       final directory = await getApplicationDocumentsDirectory();
//       final path = '${directory.path}/Receipts';
//       await Directory(path).create(recursive: true);
//       _savedImage = File('$path/Receipt.png');
//       await _savedImage!.writeAsBytes(pngBytes);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image saved to $path/Receipt.png')),
//       );
//
//       if(isshare){
//         if (_savedImage != null) {
//           Share.shareXFiles([XFile(_savedImage!.path)], text: '');
//
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Please save the image first')),
//           );
//         }
//       }
//
//
//     } catch (e) {
//       print(">>>>>>>>>>>>>>>>>>>>>>>>>>exit  ${e.toString()}");
//       Get.back();
//     }
//
//   }
//
//   PreferredSize get _appBar {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(90),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 53,
//                 height: 53,
//                 margin: const EdgeInsets.all(8),
//                 decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                 ),
//                 child: IconButton(
//                   padding: const EdgeInsets.all(8),
//                   constraints: const BoxConstraints(),
//                   onPressed: () {Get.back();},
//                   icon: SvgPicture.asset(
//                     'assets/backarrow_s.svg',
//                     width: 22,
//                     height: 22,
//                     semanticsLabel: 'Example SVG',
//                   ),
//                 ),
//               ),
//               const Center(
//                   child: Text(
//                       'Poster',
//                       style: TextStyle(
//                         color: Color(0xFF3A3A3A),
//                         fontSize: 14,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w600,
//                         height: 0,
//                       ),textScaleFactor: 1.0
//                   )),
//               Container(
//                   width: 53,
//                   height: 53,
//                   margin: const EdgeInsets.all(8),
//
//                   child: SizedBox( width: 16,
//                     height: 20,)
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _appBar,
//       body:  Center(
//         child: Column(
//
//           children: [
//             RepaintBoundary(
//               key: _globalKey,
//               child: Stack(
//                 fit: StackFit.loose,
//                 alignment: Alignment.center,
//                 children: [
//
//
//
//                   ClipRRect(
//                     child: Image.asset(
//                       'assets/StaticImg/hunderes.jpg',
//                       width: 340, // Adjust as per your template
//                       height: 400, // Adjust as per your template
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//
//                   Positioned(
//                       left:72, // Adjust as per your template
//                       top: 176,  // Adjust as per your template
//                       child: Column(
//                         children: [
//                           Container(
//
//                             height: 20,
//                             width:214,
//                             child: AutoSizeText(
//                               textAlign: TextAlign.center,
//                               "${widget.name}",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontFamily: 'Fmedium',
//                                 fontWeight: FontWeight.w800,
//                                 height: 0,
//                               ),textScaleFactor: 1.0,
//                               maxLines: 1,
//                               minFontSize: 4,
//                               maxFontSize:18 ,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           Container(
//
//                             height: 20,
//                             width:214,
//                             child: AutoSizeText(
//                               textAlign: TextAlign.center,
//                               "${widget.name_panchayath}",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontFamily: 'Fmedium',
//                                 fontWeight: FontWeight.w800,
//                                 height: 0,
//                               ),textScaleFactor: 1.0,
//                               maxLines: 1,
//                               minFontSize: 4,
//                               maxFontSize:18 ,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           )
//                         ],
//                       )
//                   ),
//
//
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: EdgeInsets.only(top: 48,left: 24,right: 24),
//
//               child:Align(
//                 alignment: Alignment.center,
//                 child: InkWell(
//                   onTap: (){_capturePng(true);},
//                   child: Container(
//                     width: MediaQuery.sizeOf(context).width-60,
//                     height: 41,
//                     decoration: ShapeDecoration(
//                       color: AppColors.primaryColor2,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//
//                         Text(
//                             'Share',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               height: 0,
//                             ),textScaleFactor: 1.0
//                         )
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),),
//
//
//           ],
//         ),
//       ),
//     );
//
//
//
//
//
//
//
//   }
// }