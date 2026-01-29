// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shadekadapadi/controller/ChallengeListController.dart';
// import 'package:shadekadapadi/screens/QuickPaychallenge.dart';
//
// import '../Utils/colors.dart';
// import '../widgets/PorgressIndicator.dart';
//
// class DontionCart extends StatelessWidget {
//
//
//
//   final String uniqueid;
//   final String Gobal_challengeid;
//   final String? volunteer_id;
//   final String? showdistrictandassembly;
//   DontionCart({required this.uniqueid,required this.Gobal_challengeid,required this.volunteer_id,required this.showdistrictandassembly});
//
//
//   final  controller = Get.put(ChallengeListcontroller());
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
//                     side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                 ),
//                 child: IconButton(
//                   padding: const EdgeInsets.all(8),
//                   constraints: const BoxConstraints(),
//                   onPressed: () {
//                     Get.back();
//                   },
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
//                     'Cart',
//                     style: TextStyle(
//                       color: Color(0xFF3A3A3A),
//                       fontSize: 14,
//                       fontFamily: 'Fontsemibold',
//                       fontWeight: FontWeight.w600,
//                       height: 0,
//                     ),
//                     textScaleFactor: 1.0,
//                   )),
//               Container(
//                 width: 53,
//                 height: 53,
//                 margin: const EdgeInsets.all(8),
//                 decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                 ),
//                 child:  IconButton(
//                   padding: const EdgeInsets.all(8),
//                   onPressed: () {
//                     goBackTwoPages();
//                   },
//                   icon: SvgPicture.asset(
//                     'assets/home.svg',
//                     width: 18,
//                     height: 20,
//                     semanticsLabel: 'Example SVG',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void goBackTwoPages() {
//     int count = 0;
//     Get.until((route) => count++ == 2);
//   }
//   Widget bottomBarTitle() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Container(
//         height: 50,
//         decoration: ShapeDecoration(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             side: const BorderSide(width: 1, color: Color(0xFFD5D5D5)),
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   'Total Amount',
//                   style: TextStyle(
//                     color: Color(0xFF3A3A3A),
//                     fontSize: 14,
//                     fontFamily: 'Fmedium',
//                     fontWeight: FontWeight.w600,
//                     height: 0,
//                   ),textScaleFactor: 1.0,
//                 ),
//               ),
//               Expanded(child:   Obx(() =>  Text(
//                 textAlign: TextAlign.right,
//                 "₹ ${controller.totalPrice.value}",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 17,
//                   fontFamily: 'Fontsemibold',
//                   fontWeight: FontWeight.w900,
//                   height: 0,
//                 ),textScaleFactor: 1.0,
//               ),))
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget bottomBarButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: InkWell(
//         onTap: (){
//
//           if(controller.totalPrice.value>0){
//             Get.to(Quickpaychallenge(uniqueid: uniqueid,modellist: controller.filteredProducts, totalmaount: controller.totalPrice.toString(),challengid:Gobal_challengeid,volunteer_id: volunteer_id,showdistrictandassembly: showdistrictandassembly,isChecked2: true,));
//           }else {
//             Get.snackbar(
//               'Select', // Title of the Snackbar
//               "please select any item ", // Message of the Snackbar
//               snackPosition: SnackPosition.BOTTOM,
//               titleText: const Text(
//                 'Select',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Fmedium', // Set your custom font family here
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textScaleFactor: 1.0,
//               ),
//               messageText: const Text(
//                 'please select any item',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Fontsemibold', // Set your custom font family here
//                   fontSize: 14,
//                 ),
//                 textScaleFactor: 1.0,
//               ),// Position of the Snackbar
//               backgroundColor:  AppColors.primaryColor2, // Background color of the Snackbar
//               colorText: Colors.white, // Text color of the Snackbar
//               borderRadius: 10, // Border radius of the Snackbar
//               margin: const EdgeInsets.all(10), // Margin around the Snackbar
//               duration: const Duration(seconds: 3), // Duration for which the Snackbar is displayed
//
//             );
//           }
//         },
//         child: Container(
//           height: 50,
//           decoration: ShapeDecoration(
//             gradient: const LinearGradient(
//               begin: Alignment(1.00, 0.00),
//               end: Alignment(-1, 0),
//               colors: [AppColors.primaryColor, AppColors.primaryColor2],
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             shadows: const [
//               BoxShadow(
//                 color: Color(0x21000000),
//                 blurRadius: 10,
//                 offset: Offset(0, 2),
//                 spreadRadius: -2,
//               )
//             ],
//           ),
//           child: const Center(
//               child: Text(
//                 'Order Now',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontFamily: 'Fmedium',
//                   fontWeight: FontWeight.w700,
//                   height: 0,
//                 ), textScaleFactor: 1.0,
//               )),
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
//       body:Obx(() {
//         if (controller.isLoading.value) {
//           return  Center(child: ProgressINdigator());
//         } else if (controller.filteredProducts.isEmpty) {
//           return const Center(child: Text('No entries to show'));
//         } else {
//           return  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             Expanded(
//                 child: GetBuilder(builder: (ChallengeListcontroller controller) {
//                   return ListView.builder(
//                     itemCount: controller.filteredProducts.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 14),
//                         child: Container(
//                           child: Column(
//                             children: [
//
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20,bottom: 8),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child:  Text(
//                                     controller.filteredProducts[index].name,
//                                     style: const TextStyle(
//                                       color: Color(0xFF3A3A3A),
//                                       fontSize: 14,
//                                       fontFamily: 'Fontsemibold',
//                                       fontWeight: FontWeight.w600,
//                                       height: 0,
//                                     ),
//                                     textScaleFactor: 1.0,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     index==1?"₹${controller.filteredProducts[index].rate}/Kg":"₹${controller.filteredProducts[index].rate}",
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 17,
//                                       fontFamily: 'Fontsemibold',
//                                       fontWeight: FontWeight.w900,
//                                       height: 0,
//                                     ),
//                                     textScaleFactor: 1.0,
//                                   ),
//                                   Container(
//
//                                     decoration: BoxDecoration(
//                                       color:const Color(0xFFF1F2F4),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         InkWell(
//                                           onTap:()=>  controller.decreaseItemQuantity(index) ,
//                                           child: Container(
//                                             width: 30,
//                                             height: 30,
//                                             decoration: ShapeDecoration(
//                                               color: const Color(0xFFD5D5D5),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                             child: const Icon(
//                                               Icons.remove,
//                                               color: Color(0xFFFFFFFF),
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           width: 76,
//                                           child:  Center(
//                                             child: TextField(
//                                               controller: controller.txtcontrollers[index],
//                                               textAlign: TextAlign.center,
//                                               decoration:   InputDecoration(
//                                                   isDense: true, // Removes extra space
//                                                   contentPadding: EdgeInsets.all(0), // Adjust the padding as needed
//                                                   border: InputBorder.none,
//                                                   hintText: controller.filteredProducts[index].quantity.toString(),
//                                                   hintStyle: const TextStyle(color: Colors.black,fontFamily: "Fontsemibold")
//
//                                               ),
//                                               keyboardType: TextInputType.number,
//                                               inputFormatters: [
//                                                 FilteringTextInputFormatter.digitsOnly,
//                                               ],
//                                               style: const TextStyle(
//
//                                                 fontFamily: "Fontsemibold",
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w700,
//
//                                               ),
//                                               onChanged: (text) {
//                                                 controller.addItemQuantity(index,text);
//                                               },
//
//                                             ),
//
//                                           ),
//
//                                         ),
//                                         InkWell(
//                                           onTap: ()=>  controller.increaseItemQuantity(index),
//                                           child: Container(
//                                             width: 30,
//                                             height: 30,
//                                             decoration: ShapeDecoration(
//                                               color:  AppColors.primaryColor2,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                             child: const Icon(
//                                               Icons.add,
//                                               color: Color(0xFFFFFFFF),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },)
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             bottomBarTitle(),
//             Padding(
//               padding: const EdgeInsets.only(top: 16, bottom: 25),
//               child: bottomBarButton(),
//             ),
//           ]);
//         }}),
//
//
//
//
//
//     );
//
//
//
//   }
// }
//
// class ImageWithLoadingIndicator extends StatelessWidget {
//   final String imageUrl;
//
//   ImageWithLoadingIndicator({required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//       imageUrl,
//       fit:BoxFit.cover ,
//       height: 164,
//       loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//         if (loadingProgress == null) {
//           return child; // The image is fully loaded, return the image.
//         } else {
//           double progress = loadingProgress.expectedTotalBytes != null
//               ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
//               : 0;
//           return Stack(
//             children: [
//               Center(child: child),
//               Padding(
//                 padding: const EdgeInsets.only(top: 60),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: CustomPaint(
//                         painter: _CircularProgressPainter(progress),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//       errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//         return Container(
//           height: 164,
//           child: Center(
//             child: Text('Failed to load image'),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
//
// class _CircularProgressPainter extends CustomPainter {
//   final double progress;
//
//   _CircularProgressPainter(this.progress);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = AppColors.primaryColor2
//       ..strokeWidth = 4.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     final Offset center = Offset(size.width / 2, size.height / 2);
//     final double radius = size.width / 2;
//     final double startAngle = -90.0 * (3.1415926535897932 / 180.0); // Convert to radians
//     final double sweepAngle = 2 * 3.1415926535897932 * progress;
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle,
//       sweepAngle,
//       false,
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(_CircularProgressPainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// }
