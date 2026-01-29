// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:shadekadapadi/modles/AssembelyModel.dart';
// import 'package:shadekadapadi/modles/PanchayatModel.dart';
// import 'package:shadekadapadi/modles/Sponsorshipmodel.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import '../ApiLists/Apis.dart';
// import '../Utils/colors.dart';
// import '../controller/QuickpayDonation.dart';
// import '../controller/QuickpayscreenController.dart';
// import '../modles/DistrictModel.dart';
// import '../modles/WardModel.dart';
// import '../widgets/my_textfield.dart';
// import 'package:http/http.dart' as http;
//
// class Quickpaydonation extends StatefulWidget {
//   String totalmaount;
//
//   Quickpaydonation({
//     required this.totalmaount,
//   });
//
//   @override
//   State<Quickpaydonation> createState() =>
//       _QuickpayState(totalmaount: totalmaount);
// }
//
//
// class _QuickpayState extends State<Quickpaydonation> {
//   _QuickpayState({required this.totalmaount});
//
//   final QuickpayDonationcontroller controller =
//       Get.put(QuickpayDonationcontroller());
//
//   ///////////////////////////////////////////////////////////////
//
//   final String totalmaount;
//
//   @override
//   void initState() {
//     super.initState();
//     controller.Amount = totalmaount;
//     fetchDistrictapi();
//   }
//
//   ////////////////models //////
//   WardModel? wardModel;
//   List<WardModel>? wardList = <WardModel>[];
//
//
//
//   fetchwardapi(String S) async {
//
//     setState(() {
//       wardList = <WardModel>[];
//       wardModel=null;
//
//     });
//     final response = await http.post(Uri.parse(historypageWardAPi), body: {
//       'id': S.toString(),
//     });
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       var list =
//       List<WardModel>.from(data['data'].map((x) => WardModel.fromJson(x)))
//           .toList();
//       // list.forEach((element) =>//// print("output>>>>>>>>>>>>${element.name}"));
//
//       setState(() {
//         if (list.isNull) {
//         } else {
//           wardList!.addAll(list);
//         }
//       });
//     } else {
//       throw Exception('Failed to load items');
//     }
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
//                     'Participate',
//                     style: TextStyle(
//                       color: Color(0xFF3A3A3A),
//                       fontSize: 14,
//                       fontFamily: 'Fontsemibold',
//                       fontWeight: FontWeight.w600,
//                       height: 0,
//                     ),textScaleFactor: 1.0
//                   )),
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
//                 child:  IconButton(
//                   padding: const EdgeInsets.all(8),
//                   onPressed: () {Get.back();},
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
//
//
//
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _appBar,
//       body: Center(
//         child: Column(
//           children: [
//
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text(
//                       '₹  ${totalmaount.replaceAll(".00", "")}',
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 35,
//                         fontFamily: 'Fontsemibold',
//                         fontWeight: FontWeight.w600,
//                         height: 0,
//                       ),textScaleFactor: 1.0
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//
//                     Container(
//                       width: 136,
//                       height: 26,
//                       decoration: ShapeDecoration(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         shadows: const [
//                           BoxShadow(
//                             color: Color(0x19000000),
//                             blurRadius: 5,
//                             offset: Offset(0, 4),
//                             spreadRadius: 0,
//                           )
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             width: 18,
//                             height: 18,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: BoxDecoration(),
//                             child: Image.asset("assets/images/razorpayfinallogo.png"),
//                           ),
//                           const Text(
//                             'Secure with razorpay',
//                             style: TextStyle(
//                               color: Color(0xFF747474),
//                               fontSize: 10,
//                               fontFamily: 'Fontsemibold',
//                               fontWeight: FontWeight.w500,
//                               height: 0,
//                             ),textScaleFactor: 1.0
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Obx((){return controller.Errorcheck[0]==0?SizedBox():
//                     const   Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text("Please Enter * ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//
//                     // Name textfield
//                     MyTextField(
//                       isNumber: false,
//                       fontPading: 24,
//                       controller: controller.txtControllername,
//                       hintText: 'Enter Name',
//                       obscureText: false,
//                       height: 50,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isChecked = !isChecked;
//                                 if(isChecked){
//                                   controller.hideidendity ="1";
//                                 }else{
//                                   controller.hideidendity ="0";
//                                 }
//                               });
//                             },
//                             child: CustomPaint(
//                               size: Size(18.0, 18.0),
//                               painter: RadioCheckboxPainter(isChecked: isChecked),
//                             ),
//                           ),
//                           SizedBox(width: 8.0),
//                           const Text(
//                             'Hide Name ',
//                             style: TextStyle(
//                               color: Color(0xFF3A591F),
//                               fontSize: 15,
//                               fontFamily: 'Fontsemibold',
//                               fontWeight: FontWeight.w600,
//                               height: 0,
//                             ),textScaleFactor: 1.0
//                           ),
//                         ],
//                       ),
//                     ),
//                     Obx((){return controller.Errorcheck[1]==0?SizedBox():
//                        Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text(controller.Errorcheck[1]==1?"Please Enter * ":"Please Enter valid number* ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//                     MyTextField(
//                       isNumber: true,
//                       fontPading: 24,
//                       controller: controller.txtControllerMobile,
//                       hintText: 'Enter Mobile Number',
//                       obscureText: false,
//                       height: 50,
//                     ),
//                     const SizedBox(
//                       height: 28,
//                     ),
//                     Obx((){return controller.Errorcheck[2]==0?SizedBox():
//                     const   Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text("Please Enter * ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//                     MyTextField(
//                       isNumber: false,
//                       fontPading: 24,
//                       controller: controller.txtControllerAddress,
//                       hintText: 'Enter your Address',
//                       obscureText: false,
//                       height: 50,
//                     ),
//                     const SizedBox(
//                       height: 28,
//                     ),
//                     Obx((){return controller.Errorcheck[3]==0?SizedBox():
//                     const   Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text("Please Enter * ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//                      Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       width: MediaQuery.sizeOf(context)
//                           .width -
//                           48,
//                       height: 50,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFF7FAFF),
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(
//                               width: 1,
//                               color: Color(0xFFE8F0FB)),
//                           borderRadius:
//                           BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Padding(
//                         padding:
//                         const EdgeInsets.symmetric(
//                             horizontal: 16),
//                         child:
//                         DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             value: districtModel,
//                             hint: const Text(
//                                 'Select your district ', style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0),
//                             onChanged: (DistrictModel?
//                             newValue) {
//                               setState(() {
//                                 districtModel = newValue;
//                                 fetchAssemblyapi(
//                                     newValue!.id);
//                               });
//                             },
//                             items: distristList!.map<
//                                 DropdownMenuItem<
//                                     DistrictModel>>(
//                                     (item) {
//                                   return DropdownMenuItem<
//                                       DistrictModel>(
//                                     value: item,
//                                     child: Text(
//                                         item.name.toString(), style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0),
//                                   );
//                                 }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Obx((){return controller.Errorcheck[4]==0?SizedBox():
//                     const   Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text("Please Enter * ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       width: MediaQuery.sizeOf(context).width - 48,
//                       height: 50,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFF7FAFF),
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(
//                               width: 1, color: Color(0xFFE8F0FB)),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             value: assemblyModel,
//                             hint: const Text('Select your assembly', style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0),
//                             onChanged: (AssemblyModel? newValue) {
//                               setState(() {
//                                 assemblyModel = newValue;
//                                 fetchPanchaythapi(newValue!.id);
//                               });
//                             },
//                             items: assemblyList!.map<
//                                 DropdownMenuItem<
//                                     AssemblyModel>>((item) {
//                               return DropdownMenuItem<
//                                   AssemblyModel>(
//                                 value: item,
//                                 child: AutoSizeText(item.name.toString().removeAllWhitespace, style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0,maxLines: 1,maxFontSize: 14,minFontSize: 8,),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Obx((){return controller.Errorcheck[5]==0?SizedBox():
//                     const   Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text("Please Enter * ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       width: MediaQuery.sizeOf(context).width - 48,
//                       height: 50,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFF7FAFF),
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(
//                               width: 1, color: Color(0xFFE8F0FB)),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             value: panchayatModel,
//                             hint: const Text('Select your panchayat', style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0),
//                             onChanged: (PanchayatModel? newValue) {
//                               setState(() {
//                                 panchayatModel = newValue;
//                                 fetchwardapi(newValue!.id);
//                               });
//                             },
//                             items: panchayatList!.map<
//                                 DropdownMenuItem<
//                                     PanchayatModel>>((item) {
//                               return DropdownMenuItem<
//                                   PanchayatModel>(
//                                 value: item,
//                                 child: AutoSizeText(item.name.toString().removeAllWhitespace, style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0,maxLines: 1,maxFontSize: 14,minFontSize: 8,),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Obx((){return controller.Errorcheck[6]==0?SizedBox():
//                     const   Padding(
//                       padding:  EdgeInsets.only(right: 24,bottom: 4),
//                       child:   Align(
//                         alignment: Alignment.topRight,
//                         child:  Text("Please Enter * ",style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 13,
//                           fontFamily: 'Fontsemibold',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                           textAlign: TextAlign.right,textScaleFactor: 1.0
//                         ),
//                       ),
//                     );}),
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       width: MediaQuery.sizeOf(context).width - 48,
//                       height: 50,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFF7FAFF),
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(
//                               width: 1, color: Color(0xFFE8F0FB)),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             value: wardModel,
//                             hint: const Text('Select your ward', style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0),
//                             onChanged: (WardModel? newValue) {
//                               setState(() {
//                                 wardModel = newValue;
//                               });
//                             },
//                             items: wardList!
//                                 .map<DropdownMenuItem<WardModel>>(
//                                     (item) {
//                                   return DropdownMenuItem<WardModel>(
//                                     value: item,
//                                     child: AutoSizeText(item.name.toString().removeAllWhitespace, style: TextStyle(fontFamily: 'Fontsemibold',fontSize: 14),textScaleFactor: 1.0,maxLines: 1,maxFontSize: 14,minFontSize: 8,),
//                                   );
//                                 }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                 child: Obx(
//                   () {
//                     if (controller.isLoading.isTrue) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else {
//                       return InkWell(
//                         onTap: () {
//
//                           controller.validation(
//                               wardModel,null,null,"1");
//                         },
//                         child: Container(
//                           height: 50,
//                           decoration: ShapeDecoration(
//                             gradient: const LinearGradient(
//                               begin: Alignment(1.00, 0.00),
//                               end: Alignment(-1, 0),
//                               colors: [AppColors.primaryColor, AppColors.primaryColor2],
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             shadows: const [
//                               BoxShadow(
//                                 color: Color(0x21000000),
//                                 blurRadius: 10,
//                                 offset: Offset(0, 2),
//                                 spreadRadius: -2,
//                               )
//                             ],
//                           ),
//                           child: const Center(
//                               child: Text(
//                             'Continue',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                               fontFamily: 'Fmedium',
//                               fontWeight: FontWeight.w700,
//                               height: 0,
//                             ),textScaleFactor: 1.0
//                           )),
//                         ),
//                       );
//                     }
//                   },
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//
// }
//
//
// class RadioCheckboxPainter extends CustomPainter {
//   final bool isChecked;
//
//   RadioCheckboxPainter({required this.isChecked});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Color(0xFF3A591F)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//
//     // Draw the outer circle
//     canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
//
//     if (isChecked) {
//       // Draw the inner dot if checked
//       paint.style = PaintingStyle.fill;
//       canvas.drawCircle(size.center(Offset.zero), size.width / 4, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
