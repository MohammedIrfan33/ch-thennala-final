import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:chcenterthennala/Appcore/app_color.dart';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:chcenterthennala/controller/HomeScreenController.dart';
import 'package:chcenterthennala/main.dart';
import 'package:chcenterthennala/screens/CartScreen.dart';
import 'package:chcenterthennala/screens/Closethe_payment.dart';
import 'package:chcenterthennala/screens/HistoryScreen.dart';
import 'package:chcenterthennala/screens/ItemsScreen.dart';
import 'package:chcenterthennala/screens/MyHistory.dart';
import 'package:chcenterthennala/screens/QuickPagecontribution.dart';
import 'package:chcenterthennala/screens/Reportpage.dart';
import 'package:chcenterthennala/screens/TopReports.dart';
import 'package:chcenterthennala/screens/TopVolunteers.dart';
import 'package:chcenterthennala/screens/VolunteerLogin.dart';
import 'package:chcenterthennala/screens/newReport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage3 extends StatefulWidget {
  const Homepage3({super.key});

  @override
  State<Homepage3> createState() => _Homepage3State();
}

class _Homepage3State extends State<Homepage3> with RouteAware {
  List<Widget> carouselItems = [
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Set the radius here
      child: Image.asset(
        height: 160,
        width: 326,
        'assets/thennala/Scrolling 1.jpg', // Replace with your image path

        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Set the radius here
      child: Image.asset(
        height: 160,
        width: 326,
        'assets/thennala/Scrolling 2.jpg', // Replace with your image path

        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Set the radius here
      child: Image.asset(
        height: 160,
        width: 326,
        'assets/thennala/Scrolling 3.jpg', // Replace with your image path

        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Set the radius here
      child: Image.asset(
        height: 160,
        width: 326,
        'assets/thennala/Scrolling 4.jpg', // Replace with your image path

        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Set the radius here
      child: Image.asset(
        height: 160,
        width: 326,
        'assets/thennala/Scrolling 5.jpg', // Replace with your image path

        fit: BoxFit.cover,
      ),
    ),
  ];
  List<String> paketsCounts = ['1', '2', '5', '10'];
  final PageController _pageController = PageController(initialPage: 0);
  List<String> tabList = ['Contributors', 'Ward'];
  int selectedIndex = 0;
  List<String> images = [
    "assets/first.svg",
    "assets/second.svg",
    "assets/third.svg",
  ];

  final controller = Get.put(Homecontroller());

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: 'subject=Hi&body=Can i ask ', // Optional parameters
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'api.whatsapp.com',
      path: 'send',
      queryParameters: {'phone': phoneNumber, 'text': ""},
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }

  String? volunteerID;
  String? userName;
  String? mobile;

  Future getshareddata() async {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>getshareddata");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      volunteerID = prefs.getString("id");
      userName = prefs.getString("name");
      mobile = prefs.getString("mobile");
    });
    AppData.volunteerId = prefs.getString("id") ?? null;
    AppData.clubId = prefs.getString("clubid") ?? null;
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    getshareddata();
  }

  @override
  void initState() {
    // TODO: implement initState
    getshareddata();
    super.initState();
  }

  @override
  void didPopNext() {
    getshareddata();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  List<String> badgeUrlList = [
    'assets/home3/badge1.png',
    'assets/home3/badge2.png',
    'assets/home3/badge3.png',
  ];

  @override
  Widget build(BuildContext context) {
    final padingTop = MediaQuery.of(context).padding.top;
    final padingBottom = MediaQuery.of(context).padding.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      SizedBox(height: padingTop),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: CarouselSlider(
                            items: carouselItems,
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                              // Set the desired options for the carousel
                              height: 160,
                              // Set the height of the carousel
                              autoPlay: true,
                              // Enable auto-play
                              autoPlayCurve: Curves.easeOutQuart,
                              // Set the auto-play curve
                              autoPlayAnimationDuration: const Duration(
                                milliseconds: 500,
                              ),
                              // Set the auto-play animation duration
                              aspectRatio:
                                  16 / 9, // Set the aspect ratio of each item
                              // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
                            ),
                          ),
                        ),
                      ),

                      /// order packets
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 12,
                          children: [
                            Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/home3/orderpackedbg.png",
                                  ),
                                ),
                              ),
                              child: Obx(() {
                                return Column(
                                  mainAxisAlignment: .center,
                                  children: [
                                    Center(
                                      child: Container(
                                        child: AutoSizeText(
                                          style: const TextStyle(
                                            color: Color(0xffFFE131),
                                            fontFamily: 'Fontbold',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          maxFontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          textScaleFactor: 1.0,
                                          '${controller.dashmodelList[0].unit.toString()}',
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        child: AutoSizeText(
                                          style: const TextStyle(
                                            color: Color(0xffFFE131),
                                            fontFamily: 'Fontbold',
                                            fontSize: 48,
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          maxFontSize: 48,
                                          overflow: TextOverflow.ellipsis,
                                          textScaleFactor: 1.0,
                                          controller
                                                      .dashmodelList
                                                      .first
                                                      .description ==
                                                  "Challenge"
                                              ? "${controller.dashmodelList[0].count.toString().replaceAll(".0", "")} "
                                              : " ₹  ${controller.dashmodelList[0].count.round().toString()}  ",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),

                            //
                            if (AppData.hide != "1")
                              Column(
                                spacing: 14,
                                children: [
                                  Row(
                                    spacing: 4,
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                          'assets/home3/cart_Iocn.png',
                                        ),
                                      ),
                                      Text(
                                        'Quick Order',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: .w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 38,
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        ...List.generate(paketsCounts.length, (
                                          index,
                                        ) {
                                          return Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  CartScreen(
                                                    packetCount: int.parse(
                                                      paketsCounts[index],
                                                    ),
                                                    Gobal_challengeid:
                                                        AppData.challangeid,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(4),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    paketsCounts[index] + "Pkts",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 240,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xffB5F4F0),
                                  border: Border(
                                    top: BorderSide(color: Color(0xff024344)),
                                  ),
                                ),
                                child: Column(
                                  spacing: 12,
                                  mainAxisSize: .max,
                                  children: [
                                    Row(
                                      spacing: 04,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                            'assets/home3/badge.png',
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Today’s',
                                              style: TextStyle(
                                                color: Color(0xff024344),
                                                fontSize: 14,
                                                fontWeight: .w400,
                                              ),
                                            ),
                                            Text(
                                              'Toppers',
                                              style: TextStyle(
                                                color: Color(0xff024344),
                                                fontSize: 14,
                                                fontWeight: .w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    ///
                                    Row(
                                      spacing: 16,
                                      children: [
                                        ...List.generate(tabList.length, (
                                          index,
                                        ) {
                                          final isSeleced =
                                              selectedIndex == index;
                                          return Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                _pageController.animateToPage(
                                                  index,
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.easeInOutQuart,
                                                );
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isSeleced
                                                      ? Color(0xff024344)
                                                      : null,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(4),
                                                      ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    tabList[index],
                                                    style: TextStyle(
                                                      color: isSeleced
                                                          ? Colors.white
                                                          : Color(0xff024344),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),

                                    Expanded(
                                      child: PageView(
                                        controller: _pageController,
                                        children: [
                                          Obx(() {
                                            if (controller.isLoading2.isTrue) {
                                              return Center(
                                                child: Container(
                                                  child:
                                                      CircularProgressIndicator(),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              );
                                            } else if (controller
                                                .topperlist
                                                .isEmpty) {
                                              return Center(
                                                child: Text(
                                                  "No data",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          spacing: 06,
                                                          children: [
                                                            Image.asset(
                                                              badgeUrlList[index],
                                                              height: 30,
                                                              width: 30,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .topperlist[index]
                                                                  .name,
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xff024344,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      24,
                                                                    ),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      24,
                                                                    ),
                                                              ),
                                                        ),
                                                        child: Text(
                                                          controller
                                                              .topperlist[index]
                                                              .amount,
                                                          style: TextStyle(
                                                            fontWeight: .bold,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                      return SizedBox(
                                                        height: 08,
                                                      );
                                                    },
                                                itemCount: controller
                                                    .topperlist
                                                    .length,
                                              );
                                            }
                                          }),

                                          Obx(() {
                                            if (controller.isLoading3.isTrue) {
                                              return Center(
                                                child: Container(
                                                  child:
                                                      CircularProgressIndicator(),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              );
                                            } else if (controller
                                                .topperlistconstituency
                                                .isEmpty) {
                                              return Center(
                                                child: Text(
                                                  "No data",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          spacing: 06,
                                                          children: [
                                                            Image.asset(
                                                              badgeUrlList[index],
                                                              height: 30,
                                                              width: 30,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .topperlistconstituency[index]
                                                                  .name,
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xff024344,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      24,
                                                                    ),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      24,
                                                                    ),
                                                              ),
                                                        ),
                                                        child: Text(
                                                          controller
                                                              .topperlistconstituency[index]
                                                              .amount,

                                                          style: TextStyle(
                                                            fontWeight: .bold,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                      return SizedBox(
                                                        height: 08,
                                                      );
                                                    },
                                                itemCount: controller
                                                    .topperlistconstituency
                                                    .length,
                                              );
                                            }
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Visibility(
                            //   visible: false,
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //       horizontal: 24,
                            //       vertical: 8,
                            //     ),
                            //     margin: EdgeInsets.symmetric(horizontal: 32),
                            //     height: 72,
                            //     decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //         fit: .fill,
                            //         image: AssetImage(
                            //           'assets/home3/containerbg.png',
                            //         ),
                            //       ),
                            //     ),
                            //     child: Column(
                            //       children: [
                            //         Expanded(
                            //           child: AutoSizeText(
                            //             maxFontSize: 14,
                            //             maxLines: 3,
                            //             minFontSize: 08,
                            //             'തൃത്താലയിലെ ഹരിത വിദ്യാർത്ഥി-യുവജന മുന്നേറ്റങ്ങൾക്ക് കരുത്ത് പകരാൻ',
                            //             textAlign: .center,
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 14,

                            //               fontWeight: .w700,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            // Visibility(
                            //   visible: false,
                            //   child: Row(
                            //     mainAxisAlignment: .spaceEvenly,
                            //     children: [
                            //       Column(
                            //         spacing: 4,

                            //         mainAxisSize: .max,
                            //         children: [
                            //           GestureDetector(
                            //             onTap: () {
                            //               Get.to(
                            //                 itempage(
                            //                   uniqueid: AppData.uniqueid,
                            //                   volunteerID: AppData.volunteerId,
                            //                   challengeid: AppData.challangeid,
                            //                 ),
                            //               );
                            //             },
                            //             child: Container(
                            //               height: 70,
                            //               width: 70,
                            //               decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                   image: AssetImage(
                            //                     'assets/home3/sponsor_icon.png',
                            //                   ),
                            //                 ),
                            //                 borderRadius: BorderRadius.all(
                            //                   Radius.circular(12),
                            //                 ),
                            //                 gradient: LinearGradient(
                            //                   colors: [
                            //                     Color(0xff00A8A2),
                            //                     Color(0xff0069B2),
                            //                   ],
                            //                   begin: Alignment.topRight,
                            //                   end: Alignment.bottomLeft,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           Text(
                            //             'Sponsorship',
                            //             style: TextStyle(
                            //               color: Color(0xff333333),
                            //               fontSize: 14,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       Column(
                            //         spacing: 4,

                            //         mainAxisSize: .max,
                            //         children: [
                            //           GestureDetector(
                            //             onTap: () {
                            //               Get.to(
                            //                 Quickpaycontribution(
                            //                   volunteerID: volunteerID,
                            //                 ),
                            //               );
                            //             },
                            //             child: Container(
                            //               height: 70,
                            //               width: 70,
                            //               decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                   image: AssetImage(
                            //                     'assets/home3/donation_icon.png',
                            //                   ),
                            //                 ),
                            //                 borderRadius: BorderRadius.all(
                            //                   Radius.circular(12),
                            //                 ),
                            //                 gradient: LinearGradient(
                            //                   colors: [
                            //                     Color(0xff00A8A2),
                            //                     Color(0xff0069B2),
                            //                   ],
                            //                   begin: Alignment.topRight,
                            //                   end: Alignment.bottomLeft,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           Text(
                            //             'Donation',
                            //             style: TextStyle(
                            //               color: Color(0xff333333),
                            //               fontSize: 14,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              height: 104,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: .fill,
                                  image: AssetImage(
                                    'assets/home3/contact_container_bg.png',
                                  ),
                                ),
                              ),

                              child: Column(
                                mainAxisAlignment: .end,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          spacing: 08,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _launchWhatsApp(
                                                    "918138010133",
                                                  );
                                                },
                                                child: Image.asset(
                                                  "assets/home3/whatapp_icon.png",
                                                  fit: .fill,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _makePhoneCall('8138010133');
                                                },
                                                child: Image.asset(
                                                  fit: .fill,
                                                  "assets/home3/phone_icon.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: SizedBox(), flex: 1),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 06),

                            if (AppData.hide != "1")
                              SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: .spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(TopVolunteer());
                                      },
                                      child: Image.asset(
                                        fit: .fill,
                                        'assets/home3/top_leader_icon.png',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (!volunteerID.isNull) {
                                          Get.to(
                                            Closethepayment(
                                              Volunter_id: volunteerID!,
                                              name: userName!,
                                              mobile: mobile!,
                                            ),
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Access denied ',
                                            // Title of the Snackbar
                                            " You don't have access to this page ",
                                            // Message of the Snackbar
                                            snackPosition: SnackPosition.BOTTOM,
                                            // Position of the Snackbar
                                            backgroundColor:
                                                AppColors.primaryColor2,
                                            // Background color of the Snackbar
                                            colorText: Colors.white,
                                            // Text color of the Snackbar
                                            borderRadius: 10,
                                            titleText: const Text(
                                              'Access denied ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fmedium',
                                                // Set your custom font family here
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            messageText: const Text(
                                              "You don't have access to this page",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fontsemibold',
                                                // Set your custom font family here
                                                fontSize: 14,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            // Border radius of the Snackbar
                                            margin: const EdgeInsets.all(10),
                                            // Margin around the Snackbar
                                            duration: const Duration(
                                              seconds: 3,
                                            ), // Duration for which the Snackbar is displayed
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        fit: .fill,
                                        'assets/home3/collection_settle_icon.png',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (!volunteerID.isNull) {
                                          Get.to(
                                            Reportscreen(
                                              volunteer_ID: volunteerID!,
                                            ),
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Access denied ',
                                            // Title of the Snackbar
                                            " You don't have access to this page ",
                                            // Message of the Snackbar
                                            snackPosition: SnackPosition.BOTTOM,
                                            // Position of the Snackbar
                                            backgroundColor:
                                                AppColors.primaryColor2,
                                            // Background color of the Snackbar
                                            colorText: Colors.white,
                                            // Text color of the Snackbar
                                            borderRadius: 10,
                                            titleText: const Text(
                                              'Access denied ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fmedium',
                                                // Set your custom font family here
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            messageText: const Text(
                                              "You don't have access to this page",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fontsemibold',
                                                // Set your custom font family here
                                                fontSize: 14,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            // Border radius of the Snackbar
                                            margin: const EdgeInsets.all(10),
                                            // Margin around the Snackbar
                                            duration: const Duration(
                                              seconds: 3,
                                            ), // Duration for which the Snackbar is displayed
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        fit: .fill,
                                        'assets/home3/leader_report_icon.png',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (volunteerID.isNull) {
                                          Get.to(VolunteerLogin());
                                        } else {
                                          Get.snackbar(
                                            'Loging',
                                            // Title of the Snackbar
                                            "You are already login",
                                            // Message of the Snackbar
                                            snackPosition: SnackPosition.BOTTOM,
                                            // Position of the Snackbar
                                            backgroundColor:
                                                AppColors.primaryColor2,
                                            // Background color of the Snackbar
                                            colorText: Colors.white,
                                            // Text color of the Snackbar
                                            borderRadius: 10,
                                            // Border radius of the Snackbar
                                            margin: const EdgeInsets.all(10),
                                            // Margin around the Snackbar
                                            duration: const Duration(seconds: 3),

                                            titleText: const Text(
                                              'Loging',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fmedium',
                                                // Set your custom font family here
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            messageText: const Text(
                                              'You are already login',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fontsemibold',
                                                // Set your custom font family here
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textScaleFactor: 1.0,
                                            ),
                                            // Duration for which the Snackbar is displayed
                                            mainButton: TextButton(
                                              onPressed: () {
                                                Get.closeCurrentSnackbar();
                                                logout();
                                              },
                                              child: const Text(
                                                'Logout',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Fmedium',
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        fit: .fill,
                                        'assets/home3/leader_login_icon.png',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        Historyscreen(
                                          uniqueid: AppData.uniqueid,
                                          GlobalId: AppData.volunteerId,
                                          onTabChange: (index) {},
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      fit: .fill,
                                      'assets/home3/transaction_icon.png',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        Myhistory(
                                          identifier: AppData.uniqueid,
                                          onTabChange: (index) {},
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      fit: .fill,
                                      'assets/home3/my_history_icon.png',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        Newreport(
                                          uniqueid: AppData.uniqueid,
                                          GlobalId: AppData.volunteerId,
                                          onTabChange: (index) {},
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      fit: .fill,
                                      'assets/home3/report_icon.png',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        TopReport(onTabChange: (index) {}),
                                      );
                                    },
                                    child: Image.asset(
                                      fit: .fill,
                                      'assets/home3/top_report_icon.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                spacing: 24,
                children: [
                  if (AppData.hide != "1")
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          CartScreen(Gobal_challengeid: AppData.challangeid),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        height: 62,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/home3/participate_button.png',
                            ),
                            fit: .fill,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: .end,
                          children: [Image.asset('assets/home3/gold.png')],
                        ),
                      ),
                    ),
                  Container(
                    height: padingBottom,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff00A8A2), Color(0xff0069B2)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
