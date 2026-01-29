import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chcenterthennala/modles/Appversion.dart';
import 'package:chcenterthennala/modles/DonationListModel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ApiLists/Apis.dart';
import '../modles/ChallengeModel.dart';
import '../modles/HomeImageModel.dart';
import '../modles/TodaystopperModel.dart';
import '../modles/TopdaysTopModel.dart';
import '../modles/dashBoardModel.dart';
import 'dart:io' show Platform;

import '../screens/CartScreen.dart';
import '../screens/ExpiredScreen.dart';
import '../screens/ItemsScreen.dart';
import '../screens/UpdationScreen.dart';

class Homecontroller extends GetxController {
  var isLoading = false.obs;

  var isLoading2 = true.obs;
  var isLoading3 = true.obs;
  var isLoading4 = true.obs;

  var quickpayamount = "NA".obs;
  List<Donationlistmodel> Donationlist = <Donationlistmodel>[
    Donationlistmodel(
      id: "0",
      name: "ഒരു ദിവസത്തെ ഡയാലിസിസ് നിരക്ക്",
      amount: "1000.00",
    ),
    Donationlistmodel(
      id: "1",
      name: "ഒരു ആഴ്ചയിലെ ഡയാലിസിസ് നിരക്ക്",
      amount: "3000.00",
    ),
    Donationlistmodel(
      id: "2",
      name: "ഒരു മാസത്തെ ഡയാലിസിസ് നിരക്ക്",
      amount: "12000.00",
    ),
  ];
  RxList<TodayTopperModel> topperlist = <TodayTopperModel>[].obs;
  RxList<TopdaysTopModel> topperlistconstituency = <TopdaysTopModel>[].obs;
  RxList<TopdaysTopModel> topperlistpanchat = <TopdaysTopModel>[].obs;

  Timer? _timer;
  final int intervalSeconds = 5; // Set your interval here

  List<Donationlistmodel> templist = <Donationlistmodel>[];
  RxList<DashboardModel> dashmodelList = <DashboardModel>[
    DashboardModel(count: 0, description: "Challenge", unit: "", Received: ""),
  ].obs;

  checkthechallenge() async {
    final response = await http.get(Uri.parse(Challengeexist));
    //print(response.body);

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        //print(">>>>>>>>>checkthechallenge>>>>>>>>>>>>>>>>> ${parsedJson.toString()}");

        // Check the status
        if (parsedJson['Status'] == 'true') {
          AppData.ischallenge = true;
          AppData.showdistrictandassembly =
              parsedJson['data'][0]['showdistrict_assembly'];
          AppData.challangeid = parsedJson['data'][0]['id'];
        } else {
          AppData.ischallenge = false;
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  checktheVersion() async {
    final response = await http.post(
      Uri.parse(versionCheck),
      body: {"version": AppData.versions[0].toString()},
    );
    //print(response.body);

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        log('respose body :${response.body}');
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Check the status
        if (parsedJson['Status'] == 'True') {
          var data = List<Appverssion>.from(
            parsedJson['data'].map((x) => Appverssion.fromJson(x)),
          ).toList();

         
          if (data.isNull) {
          } else {
            //  Platform.isIOS?hide.value=data.first.hide:hide.value="0";

            if (data.first.expired == 1) {
              Get.off(Expiredscreen());
            } else if (data.first.appversionnumber ==
                    AppData.versions[0].toString() ||
                data.first.appversionnumber == AppData.versions[1].toString()) {
            } else {
              Get.off(
                Updationscreen(
                  url: Platform.isAndroid
                      ? parsedJson['data'][0]['playstore_url'] ?? ""
                      : parsedJson['data'][0]['appstore_url'] ?? "",
                ),
              );
            }
          }
        } else {}
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  quickpaygetamount() async {
    final response = await http.post(
      Uri.parse(getquickpayAmount),
      body: {'id': "1"},
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Check the status
        if (parsedJson['Status'] == 'true') {
          quickpayamount.value = parsedJson['data'][0]['Amount'];
        } else {
          quickpayamount.value = "";
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // fulllist() async {
  //   try {
  //     var challengesResult = await getDonationList();
  //     Donationlist.assignAll(challengesResult);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  //
  // Future<List<Donationlistmodel>> getDonationList() async {
  //   final response = await http.get(Uri.parse(DonationlistApi));
  //  //print("Todays Topper>>>>>>>>>> ${response.body}");
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //     // Check the status
  //     if (parsedJson['Status'] == 'true') {
  //       var data = List<Donationlistmodel>.from(
  //               parsedJson['data'].map((x) => Donationlistmodel.fromJson(x)))
  //           .toList();
  //       templist.assignAll(data);
  //       for (var list in templist) {
  //        //print("dadats>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  //        //print(list.name);
  //       }
  //     }
  //     return templist;
  //   } else {
  //     throw Exception('Failed to load challenges');
  //   }
  // }
  ////////////topper list participation/sponsor
  topList() async {
    try {
      var challengesResult = await gettoperList();
      if (!challengesResult.isEmpty) topperlist.assignAll(challengesResult);
    } finally {
      isLoading2(false);
    }
  }

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<List<TodayTopperModel>> gettoperList() async {
    final response = await http.get(Uri.parse(todattopList));

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      _storage.write(key: "toplist", value: response.body);
      // Check the status
      if (parsedJson['Status'].toString().toLowerCase() == 'true') {
        var data = List<TodayTopperModel>.from(
          parsedJson['data'].map((x) => TodayTopperModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <TodayTopperModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  Future<void> getlocaltoplist() async {
    isLoading2(false);
    String? value = await _storage.read(key: "toplist") ?? "";

    //print("check value>>>>>>>>>>>>>>>>>>>>>${value}");
    if (value.toString().isNotEmpty) {
      //print("check value2>>>>>>>>>>>>>>>>>>>>>${value}");
      Map<String, dynamic> parsedJson = jsonDecode(value.toString());

      if (parsedJson['Status'].toString().toLowerCase() == "true") {
        var data = List<TodayTopperModel>.from(
          parsedJson['data'].map((x) => TodayTopperModel.fromJson(x)),
        ).toList();
        if (!data.isNull) {
          topperlist.assignAll(data);
        }
      }
    }
  }

  ////toperlist ward//////////

  //15-03-2025 title changed to ward///
  topListconstituency() async {
    try {
      var challengesResult = await gettoperListConstituency();
      topperlistconstituency.assignAll(challengesResult);
    } finally {
      isLoading3(false);
    }
  }

  Future<List<TopdaysTopModel>> gettoperListConstituency() async {
    final response = await http.get(Uri.parse(todattopListward));
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      if (parsedJson['Status'] == 'true') {
        var data = List<TopdaysTopModel>.from(
          parsedJson['data'].map((x) => TopdaysTopModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <TopdaysTopModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  topListpanchat() async {
    try {
      var challengesResult = await gettoperListpanchayat();
      topperlistpanchat.assignAll(challengesResult);
    } finally {
      isLoading4(false);
    }
  }

  Future<List<TopdaysTopModel>> gettoperListpanchayat() async {
    final response = await http.get(Uri.parse(todayttoppanchayat));
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      if (parsedJson['Status'].toString().toLowerCase() == 'true') {
        var data = List<TopdaysTopModel>.from(
          parsedJson['data'].map((x) => TopdaysTopModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <TopdaysTopModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  getthetotal() async {
    try {
      var _Result = await getDashBoard();
      dashmodelList.assignAll(_Result);
      dashmodelList.refresh();
    } finally {}
  }

  final box = GetStorage();

  Future<List<DashboardModel>> getDashBoard() async {
    //print("1>>>>>>>>>>>");
    final response = await http.get(Uri.parse(dashboardTotalAPi));
    ////// print(">>>>>>>>>>>>>>>>>>getthetotal ${response.body}");

    if (response.isNull) {
      return [
        DashboardModel(
          count: 0,
          description: "Challenge",
          unit: "",
          Received: "",
        ),
      ];
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      //print("2>>>>>>>>>>>${parsedJson.toString()}");
      // Check the status
      if (parsedJson['Status'].toString().toLowerCase() == 'true') {
        box.write('homepage', response.body);
        //print("Status>>>>>>>>>>>${parsedJson.toString()}");
        var data = List<DashboardModel>.from(
          parsedJson['data'].map((x) => DashboardModel.fromJson(x)),
        ).toList();
        if (!data.isNull) {
          //print("data>>>>>>>>>>>${data.first.description}");
          return data;
        }
      }
    } else {
      throw Exception('Failed to load challenges');
    }
    return [
      DashboardModel(
        count: 0,
        description: "Challenge",
        unit: "",
        Received: "",
      ),
    ];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _connectionChecker =
        InternetConnectionChecker.createInstance(); // ✅ Use createInstance()
    _listener = _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        print(">>>>>>>>>>>>>>>>>>>>>> net connected");
        fullapicall();
      } else {
        getthetotalfirst();
        getlocaltoplist();
      }
    });
    super.onInit();
  }

  // void _checkInternet() async {
  //   try {
  //     bool result = await _connectionChecker.hasConnection;
  //     isConnected.value = result;
  //   }catch(e){
  //
  //     print("error. $e");
  //
  //   }
  // }

  RxBool isConnected = true.obs;
  late final InternetConnectionChecker _connectionChecker;
  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onClose() {
    // _connectivitySubscription.cancel();
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchDistrictapi() async {
    final response = await http.get(Uri.parse(DistrictApi));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['Status'].toString().toLowerCase() == 'true') {
        AppData.DistrictList = response.body;
      }
    } else {
      throw Exception('Failed to load items');
    }
    return;
  }

  Future<void> fetchAssemblyapi() async {
    final response = await http.get(Uri.parse(newAssemblyApi));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['Status'].toString().toLowerCase() == 'true') {
        AppData.Assembly = response.body;
      }
    } else {
      throw Exception('Failed to load items');
    }
    return;
  }

  Future<void> fetchPanchaythapi() async {
    final response = await http.get(Uri.parse(newPanchaytApi));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['Status'].toString().toLowerCase() == 'true') {
        AppData.Panchayt = response.body;
      }
    } else {
      throw Exception('Failed to load items');
    }
    return;
  }

  void getthetotalfirst() async {
    final value = await box.read("homepage") ?? "";
    if (value.toString().isNotEmpty) {
      Map<String, dynamic> parsedJson = jsonDecode(value.toString());
      if (parsedJson['Status'].toString().toLowerCase() == "true") {
        var data = List<DashboardModel>.from(
          parsedJson['data'].map((x) => DashboardModel.fromJson(x)),
        ).toList();
        if (!data.isNull) {
          //print("data>>>>>>>>>>>${data.first.description}");
          dashmodelList.assignAll(data);
          dashmodelList.refresh();
        }
      }
    }
  }

  void startApiCallTimer() {
    _timer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      getthetotal();
      topList();
      topListconstituency();
    });
  }

  //   List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  //   final Connectivity _connectivity = Connectivity();
  //   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  //
  // // Platform messages are asynchronous, so we initialize in an async method.
  //   Future<void> initConnectivity() async {
  //     late List<ConnectivityResult> result;
  //     // Platform messages may fail, so we use a try/catch PlatformException.
  //     try {
  //       result = await _connectivity.checkConnectivity();
  //     } on PlatformException catch (e) {
  //
  //       return;
  //     }
  //
  //
  //     if (!Get.isRegistered<Homecontroller>()) {
  //       return Future.value(null);
  //     }
  //
  //     return _updateConnectionStatus(result);
  //   }
  //
  //   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
  //
  //     if (result.contains(ConnectivityResult.wifi)) {
  //
  //       fullapicall();
  //
  //      //print("Connected to WiFi");
  //     } else if (result.contains(ConnectivityResult.mobile)) {
  //       fullapicall();
  //
  //      //print("Connected to Mobile Data");
  //     } else if (result.contains(ConnectivityResult.ethernet)) {
  //       fullapicall();
  //
  //
  //      //print("Connected to Ethernet");
  //     } else if (result.contains(ConnectivityResult.vpn)) {
  //      //print("Connected via VPN");
  //     } else if (result.contains(ConnectivityResult.bluetooth)) {
  //      //print("Connected via Bluetooth");
  //     } else if (result.contains(ConnectivityResult.other)) {
  //      //print("Connected via Other Network");
  //     } else {
  //       getthetotalfirst();
  //       getlocaltoplist();
  //      //print("No Internet Connection");
  //     }
  //   }

  fullapicall() async {
    if (AppData.DistrictList.isEmpty) fetchDistrictapi();

    if (AppData.Assembly.isEmpty) fetchDistrictapi();

    if (AppData.Panchayt.isEmpty) fetchDistrictapi();

    getthetotalfirst();
    getthetotal();
    getlocaltoplist().then((value) => topList());
    checkthechallenge();
    checktheVersion();
    topListconstituency();
    //quickpaygetamount();

    AppData.productlist.isNotEmpty ? null : fetchproducts();
    AppData.Sponsorproductlist.isNotEmpty ? null : fetchSponsorproducts();

    //topListconstituency();
    //topListpanchat();
    startApiCallTimer();
  }

  fetchproducts() async {
    final response = await http.get(Uri.parse(challengeitemlist));

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        AppData.productlist = response.body;
      }
      return;
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  fetchSponsorproducts() async {
    final response = await http.get(Uri.parse(SponsorshipList));

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      if (parsedJson['Status'].toString().toLowerCase() == 'true') {
        AppData.Sponsorproductlist = response.body;
      }
    } else {
      throw Exception('Failed to load challenges');
    }
  }
}

enum Status { challenge, sponsor, quickpay }
