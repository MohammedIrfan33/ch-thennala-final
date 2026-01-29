// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:shadekadapadi/Bindders/Itemslistbinder.dart';
//
// import '../controller/ChallengeController.dart';
// import '../widgets/PorgressIndicator.dart';
// import 'CartScreen.dart';
// import 'DonationThroughDetailspage.dart';
// import 'ItemsScreen.dart';
// import '../Utils/colors.dart';
// import '../Utils/colors.dart';
//
//
//
// class Detailspage extends StatelessWidget{
//   String? volunteerID;
//   String uniqueid;
//
//   Detailspage({required this.volunteerID,required this.uniqueid});
//   PreferredSize get _appBar {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(70),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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
//                 child:IconButton(
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
//                     'Details',
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
//                     side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                 ),
//                 child: IconButton(
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
//   final Challengecontroller  controller=Get.put(Challengecontroller());
//
//   //sponser button//////////
//   Widget bottomBarButton() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 24,right: 4),
//       child:InkWell(
//         onTap: (){
//           Get.to(itempage(uniqueid: uniqueid,challengeid: controller.Challengedeatils.first.id,volunteerID: volunteerID,showdistrictandassembly: controller.Challengedeatils.first.showdistrictandassembly,));
//         },
//         child: Container(
//           width: 325,
//           height: 50,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//
//               borderRadius: BorderRadius.circular(12),
//             ),
//             shadows:const [
//               BoxShadow(
//                 color: Color(0x21000000),
//                 blurRadius: 10,
//                 offset: Offset(0, 4),
//                 spreadRadius: 3,
//               )
//             ],
//           ),
//           child:const  Center(
//             child:  Text(
//               'Sponsor Now',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 13,
//                 fontFamily: 'Fontsemibold',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//               textScaleFactor: 1.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget bottomBarButton1() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 24,right: 24),
//       child:InkWell(
//         onTap: (){
//        //  Get.to(CartScreen(uniqueid:uniqueid ,Gobal_challengeid: controller.Challengedeatils.first.id,volunteer_id:volunteerID,showdistrictandassembly: controller.Challengedeatils.first.showdistrictandassembly,));
//         },
//         child: Container(
//           width: 325,
//           height: 50,
//           decoration: ShapeDecoration(
//             gradient: LinearGradient(
//               begin: Alignment(1.00, 0.00),
//               end: Alignment(-1, 0),
//               colors: [AppColors.primaryColor, AppColors.primaryColor2],
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child:const  Center(
//             child:  Text(
//               'Participate Now',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//                 fontFamily: 'Fontsemibold',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//               textScaleFactor: 1.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   //participate button //
//   Widget bottomBarButton2() {
//     return Padding(
//       padding: const EdgeInsets.only(right: 24,left: 4),
//       child:InkWell(
//         onTap: () => Get.to(DontionCart(uniqueid:uniqueid ,Gobal_challengeid: controller.Challengedeatils.first.id,volunteer_id:volunteerID,showdistrictandassembly: controller.Challengedeatils.first.showdistrictandassembly,)),
//         child: Container(
//           width: 326,
//           height: 50,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               side: const BorderSide(width: 1, color: Color(0xFF757575)),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             shadows:const [
//               BoxShadow(
//                 color: Color(0x21000000),
//                 blurRadius: 10,
//                 offset: Offset(0, 2),
//                 spreadRadius: -2,
//               )
//             ],
//           ),
//
//           child: Center(
//             child: Text(
//               'Donate Now',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 13,
//                 fontFamily: 'Fontsemibold',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//               textScaleFactor: 1.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: _appBar,
//      body:  Obx(() {
//        if (controller.isLoading.value) {
//          return Center(child: ProgressINdigator());
//        } else if (controller.Challengedeatils.isEmpty) {
//          return Center(child: Text('No challenges available'));
//        } else {
//          return  Column(
//            children: [
//              Expanded(
//                child: Container(
//                  margin:const EdgeInsets.symmetric(horizontal: 24),
//                  child: SingleChildScrollView(
//                    child: Column(
//                      children: [
//                        ClipRRect(
//                            borderRadius: BorderRadius.circular(25.0),
//                            child: Image.asset("assets/banner/detailsimg.jpg",
//                              )),
//
//                        const SizedBox(
//                          height: 22,
//                        ),
//                        Align(
//                          alignment: Alignment.centerLeft,
//                          child:   Text(
//                            textAlign: TextAlign.left,
//                            controller.Challengedeatils.value.first.challenge_name,
//                            style: const TextStyle(
//                              color: Color(0xFF3A3A3A),
//                              fontSize: 14,
//                              fontFamily: 'Fontsemibold',
//                              fontWeight: FontWeight.w600,
//                              height: 0,
//                            ),
//                            textScaleFactor: 1.0,
//                          ),
//                        ),
//                        const SizedBox(height: 8,),
//                        Text(
//                          controller.Challengedeatils.value.first.description,
//                          style: const TextStyle(
//                            color: Color(0xFF757575),
//                            fontSize: 11,
//                            fontFamily: 'Fontsemibold',
//                            fontWeight: FontWeight.w600,
//                            height: 0,
//                            letterSpacing: 0.77,
//                          ),
//                          textScaleFactor: 1.0,
//                        ),
//                        const   SizedBox(height: 16,),
//
//
//
//
//
//
//
//
//
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//              SizedBox(height: 4,),
//
//              bottomBarButton1(),
//              SizedBox(height: 4,),
//
//               Row(
//                 children: [
//                   Expanded(child:  bottomBarButton(),),
//                   Expanded(child: bottomBarButton2(), )
//                 ],
//               ),
//
//
//
//
//              SizedBox(
//                height: 25,
//              ),
//            ],
//          );
//        }
//      }),
//
//
//
//    );
//
//   }
//
// }