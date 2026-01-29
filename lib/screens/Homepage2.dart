import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:chcenterthennala/controller/HomeScreenController.dart';
import 'package:chcenterthennala/screens/Quickpaydonation.dart';

import 'package:chcenterthennala/screens/TopReports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ApiLists/Appdata.dart';
import '../Utils/colors.dart';
import '../main.dart';
import '../widgets/PorgressIndicator.dart';
import 'CartScreen.dart';
import 'Closethe_payment.dart';
import 'DetailsScreen.dart';
import 'HistoryScreen.dart';
import 'ItemsScreen.dart';
import 'QuickPagecontribution.dart';
import 'QuickpayScreen.dart';
import 'Reportpage.dart';
import 'TopClubs.dart';
import 'TopVolunteers.dart';
import 'UpiPayment.dart';
import 'VolunteerLogin.dart';

List<Widget> carouselItems = [
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/banner1.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/banner2.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/banner3.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
  // ClipRRect(
  //   borderRadius: BorderRadius.circular(20.0), // Set the radius here
  //   child: Image.asset(
  //     height: 160,
  //     width: 326,
  //     'assets/banner/banner4.jpg', // Replace with your image path
  //
  //     fit: BoxFit.cover,
  //   ),
  // ),
  // ClipRRect(
  //   borderRadius: BorderRadius.circular(20.0), // Set the radius here
  //   child: Image.asset(
  //     height: 160,
  //     width: 326,
  //     'assets/banner/banner5.jpg', // Replace with your image path
  //
  //     fit: BoxFit.cover,
  //   ),
  // ),
];

List<String> images = [
  "assets/first.svg",
  "assets/second.svg",
  "assets/third.svg",
];

enum AppbarActionType { leading, trailing }

class Homepage2 extends StatefulWidget {
  Homepage2({super.key});

  @override
  State<Homepage2> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage2> with RouteAware {
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
                    side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    SystemNavigator.pop();
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
                  'Home',
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
                    side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: () {},
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitApp = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you really want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // stay
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // exit
                child: Text('Exit'),
              ),
            ],
          ),
        );

        return exitApp;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: _appBar,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      return Column(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: AutoSizeText(
                                style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'Fontbold',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                                maxLines: 1,
                                minFontSize: 12,
                                maxFontSize: 35,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 1.0,
                                controller.dashmodelList.first.description ==
                                        "Challenge"
                                    ? "${controller.dashmodelList[0].count.toString().replaceAll(".0", "")} ${controller.dashmodelList[0].unit.toString()}"
                                    : " ₹  ${controller.dashmodelList[0].count.round().toString()}  ${controller.dashmodelList[0].unit.toString()}",
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              controller.dashmodelList.first.description ==
                                      "Challenge"
                                  ? "Ordered So Far"
                                  : "Collected So Far",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFACB1C6),
                                fontSize: 13,
                                fontFamily: 'Fontsemibold',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: 0.91,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ),
                        ],
                      );
                    }),
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
                            autoPlayCurve: Curves.fastOutSlowIn,
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
                    Visibility(
                      visible: AppData.hide == "0"
                          ? AppData.ischallenge
                                ? true
                                : true
                          : false,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 24,
                                top: 20,
                                bottom: 16,
                              ),
                              child: Text(
                                'Challenge',
                                style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontSize: 16,
                                  fontFamily: 'Fontsemibold',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Get.to(
                                CartScreen(
                                  Gobal_challengeid: AppData.challangeid,
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/dashbord/icon2.png",
                              height: 62,
                            ),
                          ),
                          SizedBox(height: 8),

                          GestureDetector(
                            onTap: () {
                              Get.to(
                                itempage(
                                  uniqueid: AppData.uniqueid,
                                  volunteerID: AppData.volunteerId,
                                  challengeid: AppData.challangeid,
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/dashbord/icon1.png",
                              height: 62,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (AppData.hide == "0")
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 24,
                                top: 20,
                                bottom: 16,
                              ),
                              child: Text(
                                'Quick Pay',
                                style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontSize: 16,
                                  fontFamily: 'Fontsemibold',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ),
                          Container(
                            child: GetBuilder(
                              builder: (Homecontroller controller) {
                                return ListView.builder(
                                  itemCount: controller.Donationlist.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                        bottom: 18,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            Quickpaycontribution(
                                              volunteerID: volunteerID,
                                              amount: controller
                                                  .Donationlist[index]
                                                  .amount
                                                  .replaceAll(".00", ""),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsetsGeometry.symmetric(
                                            horizontal: 4,
                                          ),
                                          height: 63,
                                          decoration: ShapeDecoration(
                                            gradient: const LinearGradient(
                                              begin: Alignment(1.00, 0.00),
                                              end: Alignment(-1, 0),
                                              colors: [
                                                Color(0xFF7DBF43),
                                                Color(0xFF3A591F),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x19000000),
                                                blurRadius: 7,
                                                offset: Offset(0, 2),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                flex: 3,
                                                child: AutoSizeText(
                                                  controller
                                                      .Donationlist[index]
                                                      .name,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Fontsemibold',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.91,
                                                  ),
                                                  maxLines: 2,
                                                  minFontSize: 08,
                                                  maxFontSize: 13,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  "₹${controller.Donationlist[index].amount.replaceAll(".00", "")}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontFamily: 'Fontsemibold',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.91,
                                                  ),
                                                  textScaleFactor: 1.0,
                                                  maxLines: 2,
                                                  minFontSize: 08,
                                                  maxFontSize: 17,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
                        child: Text(
                          'Today’s Toppers',
                          style: TextStyle(
                            color: Color(0xFF3A3A3A),
                            fontSize: 16,
                            fontFamily: 'Fontsemibold',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.isLoading2.isTrue) {
                        return ProgressINdigator();
                      } else if (controller.topperlist.isEmpty) {
                        return const Center(child: Text('No topper today'));
                      } else {
                        return Container(
                          child: GetBuilder(
                            builder: (Homecontroller controller) {
                              return ListView.builder(
                                itemCount: controller.topperlist.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                      bottom: 18,
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                width: 35,
                                                height: 34,
                                                clipBehavior: Clip.antiAlias,
                                                decoration:
                                                    const BoxDecoration(),
                                                child: SvgPicture.asset(
                                                  images[index],
                                                  width: 20,
                                                  height: 32,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    controller
                                                        .topperlist[index]
                                                        .name,
                                                    style: const TextStyle(
                                                      color: Color(0xFF3A3A3A),
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Fontsemibold',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${controller.topperlist[index].amount}",
                                            style: const TextStyle(
                                              color: Color(0xFF3A3A3A),
                                              fontSize: 13,
                                              fontFamily: 'Fontsemibold',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                    }),
                    Visibility(
                      visible: true,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 24,
                                top: 0,
                                bottom: 4,
                              ),
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/dashbord/volunteeriocn.png",
                                    ),
                                    height: 31,
                                    width: 31,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Leaders\n& Report',
                                    style: TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontSize: 16,
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(TopVolunteer());
                                    },
                                    child: SvgPicture.asset(
                                      'assets/dashbord/topvolunteer.svg', // Ensure the file is added in pubspec.yaml
                                      width: 52,
                                      height: 52,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    'Top \n Leaders',
                                    style: TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontSize: 12,
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),

                              Column(
                                children: [
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
                                    child: SvgPicture.asset(
                                      'assets/dashbord/collectionsettlement.svg', // Ensure the file is added in pubspec.yaml
                                      width: 52,
                                      height: 52,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  const Text(
                                    "Collection \nSettlement",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontSize: 12,
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),

                              Column(
                                children: [
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
                                    child: SvgPicture.asset(
                                      'assets/dashbord/volunteerreport.svg', // Ensure the file is added in pubspec.yaml
                                      width: 52,
                                      height: 52,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  const Text(
                                    "Leaders\nReport",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontSize: 12,
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),

                              Column(
                                children: [
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
                                    child: SvgPicture.asset(
                                      'assets/dashbord/volunterlogin.svg', // Ensure the file is added in pubspec.yaml
                                      width: 52,
                                      height: 52,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    'Leader\nLogin',
                                    style: TextStyle(
                                      color: Color(0xFF3A3A3A),
                                      fontSize: 12,
                                      fontFamily: 'Fontsemibold',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // SizedBox(height: 12,),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Column(
                          //       children: [
                          //         GestureDetector(
                          //           onTap: () {
                          //                  Get.to(Topsponsors());
                          //           },
                          //           child: Image.asset(
                          //             'assets/dashbord/topdonors.png', // Ensure the file is added in pubspec.yaml
                          //             width: 52,
                          //             height: 52,
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 9,
                          //         ),
                          //         const Text(
                          //           textAlign: TextAlign.center,
                          //           'Top\nDonors',
                          //           style: TextStyle(
                          //             color: Color(0xFF3A3A3A),
                          //             fontSize: 12,
                          //             fontFamily: 'Fontsemibold',
                          //             fontWeight: FontWeight.w600,
                          //             height: 0,
                          //           ),
                          //           textScaleFactor: 1.0,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                        child: Text(
                          'Quick Connect',
                          style: TextStyle(
                            color: Color(0xFF3A3A3A),
                            fontSize: 16,
                            fontFamily: 'Fontsemibold',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 53,
                              height: 53,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF7FAFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: [
                                  const BoxShadow(
                                    color: Color(0x21000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: const EdgeInsets.all(8),
                                  onPressed: () {
                                    _makePhoneCall('8606991001');
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/phone_s.svg',
                                    width: 16,
                                    height: 20,
                                    semanticsLabel: 'Example SVG',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 9),
                            const Text(
                              textAlign: TextAlign.center,
                              'Phone',
                              style: TextStyle(
                                color: Color(0xFF3A3A3A),
                                fontSize: 12,
                                fontFamily: 'Fontsemibold',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 53,
                              height: 53,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF7FAFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x21000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: const EdgeInsets.all(8),
                                  onPressed: () {
                                    _launchWhatsApp("918606991001");
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/whatsapp_s.svg',
                                    width: 16,
                                    height: 20,
                                    semanticsLabel: 'Example SVG',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 9),
                            const Text(
                              "Watsapp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF3A3A3A),
                                fontSize: 12,
                                fontFamily: 'Fontsemibold',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 53,
                              height: 53,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF7FAFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x21000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: const EdgeInsets.all(8),
                                  onPressed: () {
                                    _sendEmail('shadecharitycell@gmail.com');
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/email_s.svg',
                                    width: 16,
                                    height: 20,
                                    semanticsLabel: 'Example SVG',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              textAlign: TextAlign.center,
                              'E-mail',
                              style: TextStyle(
                                color: Color(0xFF3A3A3A),
                                fontSize: 12,
                                fontFamily: 'Fontsemibold',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ],
                        ),
                        Column(children: [Container(width: 53, height: 53)]),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            AppData.hide == "0"
                ? Padding(
                    padding: const EdgeInsets.only(left: 26, right: 26),
                    child: InkWell(
                      // onLongPress: (){
                      //   Get.to(UpiPayment(
                      // ));},
                      onTap: () {
                        Get.to(Quickpaycontribution(volunteerID: volunteerID));
                      },
                      child: Container(
                        height: 50,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFF7DBF43), Color(0xFF3A591F)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x21000000),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Donate Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Fontbold',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ImageWithLoadingIndicator extends StatelessWidget {
  final String imageUrl;

  ImageWithLoadingIndicator({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder:
          (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child; // The image is fully loaded, return the image.
            } else {
              double progress = loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                  : 0;
              return Stack(
                children: [
                  Center(child: child),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CustomPaint(
                            painter: _CircularProgressPainter(progress),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
            return Center(child: Text('Failed to load image'));
          },
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;

  _CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFF7DBF43)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final double startAngle =
        -90.0 * (3.1415926535897932 / 180.0); // Convert to radians
    final double sweepAngle = 2 * 3.1415926535897932 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
