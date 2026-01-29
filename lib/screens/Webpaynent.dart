import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:chcenterthennala/screens/PaymentsuccessScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../Utils/colors.dart';
import '../controller/WebViewController2.dart';
import 'PaymentfailedScreen.dart';

class WebViewPayment extends StatefulWidget {
  String name;
  String Number;
  String amount;
  int isShow;
  int coount;
  Map<String, String>? orderBody;
  Map<String, dynamic>? fullsave;
  var request;

  WebViewPayment({
    required this.name,
    required this.amount,
    required this.Number,
    this.coount = 3,
    this.isShow = 1,
    required this.request,
    required this.fullsave,
    this.orderBody,
  });

  @override
  _WebViewTextExtractionState createState() => _WebViewTextExtractionState();
}

class _WebViewTextExtractionState extends State<WebViewPayment> {
  late InAppWebViewController _controller;

  @override
  void initState() {
    super.initState();
    controller.orderBody = widget.orderBody;
    widget.fullsave;
    controller.number = widget.Number;
    controller.Amount = widget.amount;
    controller.coount = widget.coount;
    if (widget.fullsave.isNull) {
      controller.saveFulldatatotheseverSponsor(widget.request);
    } else {
      controller.saveFulldatatothesever(widget.fullsave);
    }
  }

  final controller = Get.put(Webviewcontroller2());

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
                  'Participate',
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
                    side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: () {
                    goBackTwoPages();
                  },
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

  // Check if the URL is an external app link
  bool _isExternalAppLink(String url) {
    return url.startsWith('mailto:') ||
        url.startsWith('tel:') ||
        url.startsWith('sms:') ||
        url.startsWith('upi:') || // UPI Payment links
        url.contains('https://www.ups.com'); // Example external link
  }

  // Handle external app links
  Future<void> _openExternalApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url); // Launch the external app or browser
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open: $url')));
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white,
            ),

            Obx(() {
              if (controller.showthewebview.isFalse) {
                return SizedBox();
              } else {
                return Container(
                  color: Colors.white, // Ensures white background
                  child: InAppWebView(
                    initialSettings: InAppWebViewSettings(
                      forceDark: ForceDark.OFF, // Prevents dark mode effects
                    ),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                        useShouldOverrideUrlLoading:
                            true, // Ensure this is true
                      ),
                    ),
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        'https://shadekadapadi.in/ccavenue/ccavRequestHandler.php?name=${widget.name}&amount=${widget.amount}&mobile=${widget.Number}&id=${controller.headerID}',
                      ),
                    ),
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                          Uri? uri = navigationAction.request.url;

                          if (uri != null) {
                            // Show the URL in a SnackBar

                            // Handle external app links
                            if (_isExternalAppLink(uri.toString())) {
                              _openExternalApp(uri.toString());
                              return NavigationActionPolicy
                                  .CANCEL; // Prevent WebView navigation
                            }
                          }

                          return NavigationActionPolicy
                              .ALLOW; // Allow WebView navigation
                        },
                    onWebViewCreated: (InAppWebViewController controller) {
                      _controller = controller;
                      // Add JavaScript Handler
                      _controller.addJavaScriptHandler(
                        handlerName: 'Android.sendJsonData',
                        callback: (args) {
                          //print("Received JSON data: $args");
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Navigating to: ${args.toString()}')),
                          // );

                          if (args.isNotEmpty) {
                            String jsonString = args[0];
                            try {
                              Map<String, dynamic> jsonData = json.decode(
                                jsonString,
                              );
                              // print("Extracted JSON: $jsonData");
                              String status = jsonData['Status'];
                              if (status.toLowerCase() == "true") {
                                goBackTwoPages();
                                Get.to(
                                  PaymentsuccessScreen(
                                    isShare: widget.isShow == 1
                                        ? AppData.volunteerId == null
                                              ? 1
                                              : 0
                                        : 0,
                                    name: widget.name,
                                  ),
                                );
                              } else {
                                goBackTwoPages();
                                Get.to(PaymentfailedScreen());
                              }

                              // String data = jsonData['data'];
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status: $status, Data: $data')));
                            } catch (e) {
                              // print("Failed to parse JSON: $e");
                            }
                          }
                        },
                      );
                    },

                    onLoadStop: (_con, url) async {
                      Future.delayed(Duration(seconds: 1), () {
                        controller.isLoadingAlert(false);
                        print("Executed after 3 seconds");
                      });
                    },
                  ),
                );
              }
            }),

            //   InAppWebView(
            //     initialSettings: InAppWebViewSettings(
            //
            //       disableDefaultErrorPage: true,  // Avoid default black error screen
            //       forceDark: ForceDark.OFF,  // Disable dark mode
            //     ),
            //
            //     initialUrlRequest: URLRequest(
            //       url: ,
            //     ),
            //     initialOptions: InAppWebViewGroupOptions(
            //       crossPlatform: InAppWebViewOptions(
            //         javaScriptEnabled: true,
            //         useShouldOverrideUrlLoading: true, // Ensure this is true
            //       ),
            //     ),
            //     shouldOverrideUrlLoading: (controller, navigationAction) async {
            //       Uri? uri = navigationAction.request.url;
            //
            //       if (uri != null) {
            //         // Show the URL in a SnackBar
            //
            //
            //         // Handle external app links
            //         if (_isExternalAppLink(uri.toString())) {
            //           _openExternalApp(uri.toString());
            //           return NavigationActionPolicy.CANCEL; // Prevent WebView navigation
            //         }
            //       }
            //
            //       return NavigationActionPolicy.ALLOW; // Allow WebView navigation
            //     },
            //     onLoadStart: (controller, url) {
            //
            //     },
            //
            //     onLoadStop: (controller, url) async {
            //       await controller.evaluateJavascript(source: """
            // document.body.style.backgroundColor = 'white';
            //       """);
            //       setState(() {
            //         isLoading = false;
            //       });
            //     },
            //     onLoadError: (controller, url, code, message) {
            //       setState(() {
            //         isLoading = false;
            //       });
            //     },
            //
            //
            //     onWebViewCreated: (InAppWebViewController controller) {
            //       _controller = controller;
            //       // Add JavaScript Handler
            //       _controller.addJavaScriptHandler(
            //         handlerName: 'Android.sendJsonData',
            //         callback: (args) {
            //          //print("Received JSON data: $args");
            //           // ScaffoldMessenger.of(context).showSnackBar(
            //           //   SnackBar(content: Text('Navigating to: ${args.toString()}')),
            //           // );
            //
            //           if (args.isNotEmpty) {
            //             String jsonString = args[0];
            //             try {
            //               Map<String, dynamic> jsonData = json.decode(jsonString);
            //              // print("Extracted JSON: $jsonData");
            //               String status = jsonData['Status'];
            //               if(status.toLowerCase()=="true"){
            //
            //                 goBackTwoPages();
            //                 Get.to(PaymentsuccessScreen(isShare:widget.isShow==1?AppData.volunteerId==null?1:0:0, name: widget.name));
            //
            //
            //               } else{
            //
            //                 goBackTwoPages();
            //                 Get.to(PaymentfailedScreen());
            //               }
            //
            //
            //               // String data = jsonData['data'];
            //               // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status: $status, Data: $data')));
            //             } catch (e) {
            //              // print("Failed to parse JSON: $e");
            //             }
            //           }
            //         },
            //       );
            //     },
            //   ),
            Obx(() {
              if (controller.showthewebviewLoading.isTrue) {
                return Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.sizeOf(context).height * (.30),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      textAlign: TextAlign.center,
                      'പേയ്‌മെന്റ് പ്രക്രിയ പൂർത്തിയാകുന്നതുവരെ സ്‌ക്രീനിൽ തുടരുക..',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else {
                if (controller.isLoadingAlert.isTrue)
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    height: double.maxFinite,
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 30),

                        Container(
                          color: Color(0xFFFFF9F9),

                          child: Column(
                            children: [
                              Container(
                                height: 66,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFFBD1E2C),
                                      Color(0xFF790812),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/StaticImg/alert.svg",
                                    height: 40,
                                    width: 35,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 32,
                                ),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'പേയ്മെന്റ് പ്രക്രിയ :\n\n',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'ഗൂഗിൾ പേ, ഫോൺപേ പോലുള്ള UPI പേയ്‌മെന്റ് അപ്ലിക്കേഷനുകളിൽ നിന്നും പണമടക്കൽ പൂർത്തിയായതിന് ശേഷം  അപ്ലിക്കേഷനിലേക്ക് തിരികെ വന്ന് Receipt/Status Poster ലഭിക്കുന്നത് വരെ കാത്തിരിക്കേണ്ടതാണ്. അല്ലാത്തപക്ഷം നിങ്ങളുടെ പണമടക്കൽ പൂർത്തിയാകുന്നതല്ല',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                      20,
                                    ), // Rounded top corners
                                    left: Radius.circular(
                                      20,
                                    ), // Rounded bottom corners
                                  ),

                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFFBD1E2C),
                                      Color(0xFF790812),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),

                        Align(
                          alignment: Alignment.bottomCenter,

                          child: Column(
                            children: [
                              Text(
                                "Your payment is being processed. This may take a moment. Please wait",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Fontsemibold',
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 12),
                              Container(
                                width: 18,
                                height: 18,

                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
              }
              return SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == widget.coount);
  }
}
