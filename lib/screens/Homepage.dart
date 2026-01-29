import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
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

import '../Utils/colors.dart';
import '../main.dart';
import '../modles/ChallenegeListModel.dart';
import '../widgets/PorgressIndicator.dart';
import '../widgets/carousel_widget.dart';
import 'CartScreen.dart';
import 'Closethe_payment.dart';
import 'DetailsScreen.dart';
import 'HistoryScreen.dart';
import 'ItemsScreen.dart';
import 'MyHistory.dart';
import 'QuickPagecontribution.dart';
import 'QuickPaychallenge.dart';
import 'QuickpayScreen.dart';
import 'Reportpage.dart';
import 'TopClubs.dart';
import 'TopSponsors.dart';
import 'TopVolunteers.dart';
import 'UpiPayment.dart';
import 'VolunteerLogin.dart';

List<Widget> carouselItems = [
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/Scrolling 1.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/Scrolling 2.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/Scrolling 3.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20.0), // Set the radius here
    child: Image.asset(
      height: 160,
      width: 326,
      'assets/banner/Scrolling 4.jpg', // Replace with your image path

      fit: BoxFit.cover,
    ),
  ),
];

List<String> images = [
  "assets/first.svg",
  "assets/second.svg",
  "assets/third.svg",
];

enum AppbarActionType { leading, trailing }

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin, RouteAware {
  final controller = Get.put(Homecontroller());
  late TabController _tabController;

  List<int> pakets = [100, 200, 300, 400];

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
    final message = Uri.encodeComponent(
      "Blood \nNeed \nName: Asvin T\nPlace : Koppam",
    );

    final Uri whatsappUri = GetPlatform.isIOS
        ? Uri.parse(
            "whatsapp://send?phone=$phoneNumber&text= Blood \n Need \nName: Asvin T\nPlace :Koppam",
          ) // iOS
        : Uri(
            scheme: 'https',
            host: 'api.whatsapp.com',
            path: 'send',
            queryParameters: {'phone': phoneNumber, 'text': message},
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didPopNext() {
    Get.snackbar("Pop", "Message");
    getshareddata();
    controller.topListpanchat();
    controller.topListconstituency();
    controller.topList();
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
    _tabController.dispose();
    super.dispose();
  }

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: CarousalWidget(),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 18),

                      height: 130,
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              // SVG Background
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: SvgPicture.asset(
                                    height: 98,

                                    'assets/dashbord/firstbg.svg', // Path to your SVG
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // Foreground Content
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: double.infinity,
                                height: 98,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 6),
                                    Obx(() {
                                      return Text(
                                        'Total ${controller.dashmodelList[0].unit.toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFFFE131),
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 1.83,
                                          letterSpacing: -0.41,
                                        ),
                                      );
                                    }),

                                    Obx(
                                      () => AutoSizeText(
                                        style: const TextStyle(
                                          color: Color(0xFFFFE131),
                                          fontFamily: 'Inter',
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                        maxLines: 1,
                                        minFontSize: 12,
                                        maxFontSize: 36,
                                        overflow: TextOverflow.ellipsis,
                                        textScaleFactor: 1.0,
                                        "${controller.dashmodelList[0].count.toString().replaceAll(".0", "")}",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 72),
                              height: 47,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF6C1F21),
                                    Color(0xFFAE252A),
                                  ], // Gradient colors
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7EED6), // Background color
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                margin: EdgeInsets.all(
                                  2,
                                ), // Width of the border
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6A1F21),
                                      ),
                                      child: Obx(() {
                                        if (controller
                                            .dashmodelList
                                            .first
                                            .Received
                                            .isEmpty) {
                                          return SizedBox();
                                        }

                                        return AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              "Amount :  ₹ ${controller.dashmodelList[0].Received.toString().replaceAll(".00", "")}",
                                              speed: Duration(
                                                milliseconds: 200,
                                              ),
                                            ),
                                          ],
                                          repeatForever: false,
                                          isRepeatingAnimation: false,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppData.hide == "0"
                        ? AppData.ischallenge == true
                              ? Column(
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
                                                "assets/dashbord/rupees.png",
                                              ),
                                              height: 24,
                                              width: 24,
                                            ),

                                            Text(
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
                                          ],
                                        ),
                                      ),
                                    ),

                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 12,
                                            top: 12,
                                          ),
                                          height: 26,
                                          child: ListView.builder(
                                            itemCount: 4,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (BuildContext context, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    Quickpaychallenge(
                                                      uniqueid:
                                                          AppData.uniqueid,
                                                      totalmaount: pakets[index]
                                                          .toString(),
                                                      challengid: "1",
                                                      modellist: [
                                                        Challegelistmodel(
                                                          name: "",
                                                          img: "",
                                                          productid: '1',
                                                          quantity: 0,
                                                          rate: "",
                                                        ),
                                                      ],
                                                      showdistrictandassembly:
                                                          AppData
                                                              .showdistrictandassembly,
                                                      volunteer_id: volunteerID,
                                                      backcount: 1,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 25,

                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    left: 6,
                                                  ),

                                                  decoration: ShapeDecoration(
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,
                                                        color: Color(
                                                          0xFF7F8181,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '₹ ${pakets[index]}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF7F8281,
                                                        ),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox()
                        : SizedBox(),

                    Wrap(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),

                                  color: Color(0xFFFFFCDF),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 24,
                                            top: 18,
                                            bottom: 16,
                                          ),
                                          child: Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                  "assets/dashbord/topper.png",
                                                ),
                                                height: 24,
                                                width: 24,
                                              ),
                                              Text(
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
                                            ],
                                          ),
                                        ),
                                      ),

                                      TabBar(
                                        // Selected tab text color
                                        unselectedLabelColor:
                                            Colors.transparent,
                                        // Unselected tab text color
                                        controller: _tabController,

                                        // Tab indicator size
                                        indicatorWeight: 0,
                                        indicator: GradientTabIndicator(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primaryColor2,
                                              AppColors.primaryColor,
                                            ],
                                          ),

                                          thickness: 2.2,
                                          radius: 90.0, // Adjust as needed
                                        ),
                                        dividerColor: Colors.transparent,
                                        tabs: [
                                          Tab(
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.primaryColor2,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              child: AutoSizeText(
                                                "Contributors",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .white, // Must set a color for ShaderMask to work
                                                ),
                                                maxLines: 1,
                                                minFontSize: 6,
                                                maxFontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.primaryColor2,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              child: AutoSizeText(
                                                "Ward",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .white, // Must set a color for ShaderMask to work
                                                ),
                                                maxLines: 1,
                                                minFontSize: 6,
                                                maxFontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.primaryColor2,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              child: AutoSizeText(
                                                "Panchayat",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .white, // Must set a color for ShaderMask to work
                                                ),
                                                maxLines: 1,
                                                minFontSize: 6,
                                                maxFontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          double itemHeight =
                                              46.0; // Approximate height of each ListTile
                                          double listHeight = 3 * itemHeight;

                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            height: listHeight,
                                            child: TabBarView(
                                              controller: _tabController,
                                              children: [
                                                Obx(() {
                                                  return controller
                                                          .isLoading2
                                                          .isTrue
                                                      ? Center(
                                                          child: Container(
                                                            height: 28,
                                                            width: 28,
                                                            child: CircularProgressIndicator(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        )
                                                      : controller
                                                            .topperlist
                                                            .isEmpty
                                                      ? Center(
                                                          child: Text(
                                                            "No data",
                                                          ),
                                                        )
                                                      : ListView.builder(
                                                          itemCount: controller
                                                              .topperlist
                                                              .length,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (
                                                                BuildContext
                                                                context,
                                                                int index,
                                                              ) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        left:
                                                                            24,
                                                                        right:
                                                                            24,
                                                                        bottom:
                                                                            18,
                                                                      ),
                                                                  child: Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Row(
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
                                                                                decoration: const BoxDecoration(),
                                                                                child: SvgPicture.asset(
                                                                                  images[index],
                                                                                  width: 20,
                                                                                  height: 32,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  controller.topperlist[index].name,
                                                                                  style: const TextStyle(
                                                                                    color: Color(
                                                                                      0xFF3A3A3A,
                                                                                    ),
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Fontsemibold',
                                                                                    fontWeight: FontWeight.w700,
                                                                                    height: 0,
                                                                                  ),
                                                                                  textScaleFactor: 1.0,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                4,
                                                                          ),
                                                                          height:
                                                                              21,
                                                                          decoration: ShapeDecoration(
                                                                            gradient: LinearGradient(
                                                                              begin: Alignment(
                                                                                0.00,
                                                                                -1.00,
                                                                              ),
                                                                              end: Alignment(
                                                                                0,
                                                                                1,
                                                                              ),
                                                                              colors: [
                                                                                AppColors.primaryColor,
                                                                                AppColors.primaryColor2,
                                                                              ],
                                                                            ),
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(
                                                                                  10,
                                                                                ),
                                                                                bottomLeft: Radius.circular(
                                                                                  10,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                            '₹ ${controller.topperlist[index].amount}',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 13,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                        );
                                                }),
                                                Obx(() {
                                                  return controller
                                                          .isLoading3
                                                          .isTrue
                                                      ? Center(
                                                          child: Container(
                                                            height: 28,
                                                            width: 28,
                                                            child: CircularProgressIndicator(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        )
                                                      : controller
                                                            .topperlistconstituency
                                                            .isEmpty
                                                      ? Center(
                                                          child: Text(
                                                            "No data",
                                                          ),
                                                        )
                                                      : ListView.builder(
                                                          itemCount: controller
                                                              .topperlistconstituency
                                                              .length,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (
                                                                BuildContext
                                                                context,
                                                                int index,
                                                              ) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        left:
                                                                            24,
                                                                        right:
                                                                            24,
                                                                        bottom:
                                                                            18,
                                                                      ),
                                                                  child: Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Row(
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
                                                                                decoration: const BoxDecoration(),
                                                                                child: SvgPicture.asset(
                                                                                  images[index],
                                                                                  width: 20,
                                                                                  height: 32,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  controller.topperlistconstituency[index].name.toString(),
                                                                                  style: const TextStyle(
                                                                                    color: Color(
                                                                                      0xFF3A3A3A,
                                                                                    ),
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Fontsemibold',
                                                                                    fontWeight: FontWeight.w700,
                                                                                    height: 0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                4,
                                                                          ),
                                                                          height:
                                                                              21,
                                                                          decoration: ShapeDecoration(
                                                                            gradient: LinearGradient(
                                                                              begin: Alignment(
                                                                                0.00,
                                                                                -1.00,
                                                                              ),
                                                                              end: Alignment(
                                                                                0,
                                                                                1,
                                                                              ),
                                                                              colors: [
                                                                                AppColors.primaryColor,
                                                                                AppColors.primaryColor2,
                                                                              ],
                                                                            ),
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(
                                                                                  10,
                                                                                ),
                                                                                bottomLeft: Radius.circular(
                                                                                  10,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                            '₹ ${controller.topperlistconstituency[index].amount.toString()}',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 13,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                        );
                                                }),
                                                Obx(() {
                                                  return controller
                                                          .isLoading4
                                                          .isTrue
                                                      ? Center(
                                                          child: Container(
                                                            height: 28,
                                                            width: 28,
                                                            child: CircularProgressIndicator(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        )
                                                      : controller
                                                            .topperlistpanchat
                                                            .isEmpty
                                                      ? Center(
                                                          child: Text(
                                                            "No data",
                                                          ),
                                                        )
                                                      : ListView.builder(
                                                          itemCount: controller
                                                              .topperlistpanchat
                                                              .length,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (
                                                                BuildContext
                                                                context,
                                                                int index,
                                                              ) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        left:
                                                                            24,
                                                                        right:
                                                                            24,
                                                                        bottom:
                                                                            18,
                                                                      ),
                                                                  child: Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Row(
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
                                                                                decoration: const BoxDecoration(),
                                                                                child: SvgPicture.asset(
                                                                                  images[index],
                                                                                  width: 20,
                                                                                  height: 32,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  controller.topperlistpanchat[index].name.toString(),
                                                                                  style: const TextStyle(
                                                                                    color: Color(
                                                                                      0xFF3A3A3A,
                                                                                    ),
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Fontsemibold',
                                                                                    fontWeight: FontWeight.w700,
                                                                                    height: 0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                4,
                                                                          ),
                                                                          height:
                                                                              21,
                                                                          decoration: ShapeDecoration(
                                                                            gradient: LinearGradient(
                                                                              begin: Alignment(
                                                                                0.00,
                                                                                -1.00,
                                                                              ),
                                                                              end: Alignment(
                                                                                0,
                                                                                1,
                                                                              ),
                                                                              colors: [
                                                                                AppColors.primaryColor,
                                                                                AppColors.primaryColor2,
                                                                              ],
                                                                            ),
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(
                                                                                  10,
                                                                                ),
                                                                                bottomLeft: Radius.circular(
                                                                                  10,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                            '₹ ${controller.topperlistpanchat[index].amount.toString()}',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 13,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                        );
                                                }),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 70),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Stack(
                                children: [
                                  // SVG Background
                                  Positioned(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                      ),
                                      child: SvgPicture.asset(
                                        height: 98,
                                        'assets/dashbord/secondsvg2.svg', // Path to your SVG
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  // Foreground Content
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    width: double.infinity,
                                    height: 98,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,

                                          children: [
                                            Flexible(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Image.asset(
                                                  "assets/dashbord/contacticon1.png",
                                                  height: 48,
                                                  width: 48,
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 8),

                                            Flexible(
                                              flex: 2,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Contact Us',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFFFFE131),
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0.94,
                                                      letterSpacing: -0.41,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Our Support Team\nIs Hear To Help You!',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.30,
                                                      letterSpacing: -0.41,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 40.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,

                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    _makePhoneCall(
                                                      "81380 10133",
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    "assets/dashbord/Phone_1.png",
                                                    height: 29,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    _launchWhatsApp(
                                                      GetPlatform.isIOS
                                                          ? "81380 10133"
                                                          : "9181380 10133",
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    "assets/dashbord/WhatsApp_1.png",
                                                    height: 29,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

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

                    Column(
                      children: [
                        AppData.hide == "0" ? SizedBox(height: 12) : SizedBox(),

                        AppData.hide == "0"
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(
                                    Quickpaycontribution(
                                      volunteerID: AppData.volunteerId,
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/donateiocns/donate1.png', // Ensure the file is added in pubspec.yaml
                                  height: 62,
                                  width: double.infinity,
                                ),
                              )
                            : SizedBox(),

                        // AppData.hide== "0"?AppData.ischallenge? SizedBox(height: 16,):SizedBox():SizedBox(),
                        //
                        // AppData.hide == "0"?AppData.ischallenge?   GestureDetector(
                        //   onTap: () {
                        //     Get.to(itempage(uniqueid: AppData.uniqueid,volunteerID: AppData.volunteerId,showdistrictandassembly:AppData.showdistrictandassembly ,challengeid:AppData.challangeid ,));
                        //     },
                        //   child:Image.asset(
                        //     'assets/donateiocns/donate2.png', // Ensure the file is added in pubspec.yaml
                        //     height: 62,
                        //     width: double.infinity,
                        //   ),
                        // ):SizedBox():SizedBox(),
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),

            AppData.hide == "0"
                ? AppData.ischallenge
                      ? GestureDetector(
                          onTap: () {
                            if (controller.quickpayamount.value == "NA") {
                            } else {
                              // Get.to(CartScreen(amt:controller.quickpayamount.value,uniqueid: '', Gobal_challengeid: AppData.challangeid, volunteer_id: '', showdistrictandassembly:AppData.showdistrictandassembly,));
                            }
                          },
                          child: Image.asset(
                            'assets/donateiocns/donate3.png', // Ensure the file is added in pubspec.yaml
                            height: 62,
                            width: double.infinity,
                          ),
                        )
                      : SizedBox()
                : SizedBox(),
            SizedBox(height: 4),
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
      ..color = AppColors.primaryColor2
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

class GradientTabIndicator extends Decoration {
  final Gradient gradient;
  final double thickness;
  final double radius;

  GradientTabIndicator({
    required this.gradient,
    this.thickness = 2.0,
    this.radius = 0.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientPainter(gradient, thickness, radius);
  }
}

class _GradientPainter extends BoxPainter {
  final Gradient gradient;
  final double thickness;
  final double radius;

  _GradientPainter(this.gradient, this.thickness, this.radius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect indicatorRect = Rect.fromLTWH(
      offset.dx,
      configuration.size!.height - thickness,
      configuration.size!.width,
      thickness,
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(indicatorRect)
      ..style = PaintingStyle.fill;

    final RRect roundedRect = RRect.fromRectAndRadius(
      indicatorRect,
      Radius.circular(radius),
    );
    canvas.drawRRect(roundedRect, paint);
  }
}
