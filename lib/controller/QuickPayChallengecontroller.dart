import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import '../Utils/colors.dart';

import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:chcenterthennala/modles/AssembelyModel.dart';
import 'package:chcenterthennala/modles/ChallenegeListModel.dart';
import 'package:chcenterthennala/modles/ClubModel.dart';
import 'package:chcenterthennala/modles/DistrictModel.dart';
import 'package:chcenterthennala/modles/PanchayatModel.dart';
import 'package:chcenterthennala/modles/WardModel.dart';

import 'package:chcenterthennala/modles/loginModels.dart';
import 'package:chcenterthennala/screens/PaymentfailedScreen.dart';
import 'package:chcenterthennala/screens/PaymentsuccessScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLists/Apis.dart';
import '../modles/NewAssemblyModel.dart';
import '../modles/Sponsorshipmodel.dart';
import '../screens/Webpaynent.dart';
import '../screens/webpaymentchallenge.dart';

class QuickpayChallagecontroller extends GetxController {
  List<Challegelistmodel> list = <Challegelistmodel>[];
  var Errorcheck = <int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
  int? selected_index;

  TextEditingController txtControllername = TextEditingController();
  TextEditingController txtControllerAddress = TextEditingController();
  TextEditingController txtControllerMobile = TextEditingController();
  TextEditingController txtControllerotname = TextEditingController();
  TextEditingController txtControllerotAddress = TextEditingController();
  TextEditingController txtControllerotMobile = TextEditingController();

  String Amount = "";
  String received = "0";
  String hideidendity = "0";
  bool orderforothercheck = false;
  String challengeid = "";
  String headerID = "0";
  int backCount = 2;
  var isLoading = false.obs;
  var isPaymentpage = false.obs;

  Rx<DistrictModel?> orgdistModel = Rx<DistrictModel?>(null); // Explicit type
  RxList<DistrictModel> distristList = <DistrictModel>[].obs;
  List<DistrictModel> ditrictfulllist = <DistrictModel>[];
  fetchDistrictapi() async {
    if (AppData.DistrictList.isEmpty) {
      //Through online
      final response = await get(Uri.parse(DistrictApi));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var list = List<DistrictModel>.from(
          data['data'].map((x) => DistrictModel.fromJson(x)),
        ).toList();
        if (list.isNull) {
        } else {
          distristList!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.DistrictList);
      var list = List<DistrictModel>.from(
        data['data'] /*.where((item) => item['id'] == "10")*/ .map(
          (x) => DistrictModel.fromJson(x),
        ),
      ).toList();
      if (list.isNull) {
      } else {
        ditrictfulllist!.addAll(list);
        distristList!.addAll(list);
      }
    }
  }

  RxList<NewAssemblyModel> orgassemblyList = <NewAssemblyModel>[].obs;
  Rx<NewAssemblyModel?> orgassemblymodel = Rx<NewAssemblyModel?>(null);
  List<NewAssemblyModel> orgassemblyfullList = <NewAssemblyModel>[];
  fetchAssemblyapi(String S) async {
    // print(">>>>>>>>>>>>calling${S}");

    orgassemblymodel.value = null;
    orgPanchaytModel.value = null;
    orgwardModel.value = null;
    print("Assembly :::::${AppData.Assembly}");

    if (AppData.Assembly.isEmpty) {
      final response = await post(
        Uri.parse(AssembelyApi),
        body: {'id': S.toString()},
      );
      // print(">>>>>>>>>>>>callingresponse >${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var list = List<NewAssemblyModel>.from(
          data['data'].map((x) => NewAssemblyModel.fromJson(x)),
        ).toList();
        // list.forEach((element) =>// print("output>>>>>>>>>>>>${element.name}"));

        if (list.isNull) {
        } else {
          orgassemblyList!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.Assembly);
      var list = List<NewAssemblyModel>.from(
        data['data']
            .where((item) => item['districtid'] == S)
            .map((x) => NewAssemblyModel.fromJson(x)),
      ).toList();

      if (list.isNull) {
      } else {
        if (orgassemblyList!.isNotEmpty) orgassemblyList!.clear();

        if (panchayatList!.isNotEmpty) panchayatList!.clear();

        if (wardlist!.isNotEmpty) wardlist!.clear();

        if (orgassemblyfullList!.isNotEmpty) orgassemblyfullList!.clear();

        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        orgassemblyList!.addAll(list);
        orgassemblyfullList!.addAll(list);
      }
    }
  }

  RxList<PanchayatModel> panchayatList = <PanchayatModel>[].obs;
  List<PanchayatModel> panchayatListfull = <PanchayatModel>[];
  Rx<PanchayatModel?> orgPanchaytModel = Rx<PanchayatModel?>(null);
  fetchPanchaythapi(List<String> S) async {
    orgPanchaytModel.value = null;
    orgwardModel.value = null;
    // print(">>>>>>>>>>>>callingpanchayth${S}");
    if (AppData.Panchayt.isEmpty) {
      final response = await post(
        Uri.parse(PanchayatApi),
        body: {'id': S.toString()},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var list = List<PanchayatModel>.from(
          data['data'].map((x) => PanchayatModel.fromJson(x)),
        ).toList();

        if (list.isNull) {
        } else {
          panchayatList!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.Panchayt);
      var list = List<PanchayatModel>.from(
        data['data']
            .where((item) => S.contains(item['assemblyid']))
            .map((x) => PanchayatModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        if (panchayatList!.isNotEmpty) panchayatList!.clear();

        if (wardlist!.isNotEmpty) wardlist!.clear();

        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        panchayatList!.addAll(list);
        panchayatListfull!.addAll(list);
      }
    }
  }

  RxList<WardModel> wardlist = <WardModel>[].obs;
  List<WardModel> wardlistfull = <WardModel>[];
  Rx<WardModel?> orgwardModel = Rx<WardModel?>(null);
  fetchwardapi(String S) async {
    selected_index = null;
    orgwardModel.value = null;
    if (wardlist!.isNotEmpty) wardlist!.clear();

    if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

    final response = await post(
      Uri.parse(historypageWardAPi),
      body: {'id': S.toString()},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<WardModel>.from(
        data['data'].map((x) => WardModel.fromJson(x)),
      ).toList();
      // list.forEach((element) =>// print("output>>>>>>>>>>>>${element.name}"));

      if (list.isNull) {
      } else {
        wardlist!.addAll(list);
        wardlistfull!.addAll(list);
      }
    } else {
      throw Exception('Failed to load items');
    }
  }

  /// for challenge Participation //////>>>>>>>>>>>>>>>>>
  Rx<ClubModel?> clubModel = Rx<ClubModel?>(null);
  RxList<ClubModel> clubList = <ClubModel>[].obs;
  List<ClubModel> clubListFull = <ClubModel>[].obs;
  fetchClub() async {
    clubList.isEmpty ? null : clubList.clear();
    clubListFull.isEmpty ? null : clubListFull.clear();

    final response = await get(Uri.parse(ClubApi));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<ClubModel>.from(
        data['data'].map((x) => ClubModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        clubList!.addAll(list);
        clubListFull!.addAll(list);
      }
    } else {
      throw Exception('Failed to load items');
    }
  }

  String? volunteerid;

  String uniqueid = "";

  // customersave_volunteer() async {
  //   isLoading(true);
  //   final response = await post(Uri.parse(Savecustomer), body: {
  //     'name': txtControllername.text,
  //     'Address': txtControllerAddress.text,
  //     'isphoto': "0",
  //     'Mobile': txtControllerMobile.text,
  //     'District': orgdistModel.value.isNull ? "0" : orgdistModel.value!.id,
  //     'Assembly': orgassemblymodel.value.isNull ? "0" : orgassemblymodel.value!.id,
  //     'Panchayat': orgPanchaytModel.value.isNull ? "0" : orgPanchaytModel.value!.id,
  //     'Ward': orgwardModel.value.isNull ? "0" : orgwardModel.value!.id,
  //   });
  //  // print("Headersave_volunteer>>>>>>>>>>>>>>>>>>>>>>>>");
  //
  //  // print(response.body);
  //   //isLoading(false);
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //       // Check the status
  //       if (parsedJson['Status'] == 'True') {
  //         Headersave_volunteer(parsedJson['data'].toString());
  //       } else {
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // Headersave_volunteer(String id) async {
  //   final response = await post(Uri.parse(Savethehaderdatails), body: {
  //     'donation': "0",
  //     'sponsorship': "0",
  //     'challengeid': challengeid,
  //     'clubid': clubModel.value.isNull ? "0" : clubModel.value!.id,
  //     'hideidendity': hideidendity,
  //     'orderid':"0",
  //     'customerid': id,
  //     'orderforothers': orderforothercheck ? "1" : "0",
  //     'name': txtControllerotname.text,
  //     'address': txtControllerotAddress.text,
  //     'mobile': txtControllerotMobile.text,
  //     'Transid': "",
  //     'Amount': Amount,
  //     'Received': received,
  //     'volunteer': AppData.volunteerId??"0"
  //   });
  //  // print("Headersave_volunteer>>>>>>>>>>>>>>>>>>>>>>>>");
  //  // print(response.body);
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //       if (parsedJson['Status'] == 'True') {
  //         titlesave_volunteer(parsedJson['data'].toString());
  //
  //       } else {
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // titlesave_volunteer(String id) async {
  //   int index = 0;
  //   int lastIndex = 0;
  //   for (var element in list) {
  //     if (element.quantity != 0) {
  //       lastIndex++;
  //     }
  //   }
  //   lastIndex--;
  //
  //   for (var element in list) {
  //     if (element.quantity != 0) {
  //       final response = await post(Uri.parse(Savethetitle), body: {
  //         'hdrid': id,
  //         'item': element.productid,
  //         'qty': element.quantity.toString(),
  //         'rate': element.rate,
  //         'amount': (element.quantity * double.parse(element.rate)).toString(),
  //       });
  //      // print("titlesave_volunteer>>>>>>>>>>>>>>>>>>>>>>>>");
  //      // print(response.body);
  //       if (response.statusCode == 200) {
  //         if (response.body.isEmpty) {
  //           isLoading(false);
  //         } else {
  //           Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //           if (parsedJson['Status'] == 'True') {
  //            // print(">>>>>>>>>>>>>>>>>>>>>>> index ${index}");
  //            // print(">>>>>>>>>>>>>>>>>>>>>>> lastIndex ${lastIndex} ");
  //
  //             if (index == lastIndex) {
  //              // print(">>>>>>>>>>>>>>>>>>>>>>> details ");
  //
  //             }
  //           } else {
  //             isLoading(false);
  //           }
  //         }
  //       } else {
  //         isLoading(false);
  //         throw Exception('Failed to load data');
  //       }
  //       index++;
  //     }
  //   }
  //
  //   //isLoading(false);
  // }

  clearthetextdata() {
    txtControllername.clear();
    txtControllerAddress.clear();
    txtControllerMobile.clear();
    txtControllerotname.clear();
    txtControllerotAddress.clear();
    txtControllerotMobile.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  savetotheserver(bool Club_selected, String? showpanchayath) {
    print(
      '========================calling=====================================================',
    );
    for (int i = 0; i < 11; i++) {
      Errorcheck[i] = 0;
    }
    if (Club_selected) {
      if (clubModel.value.isNull) {
        Errorcheck[10] = 1;
      } else if (orgwardModel.value.isNull) {
        Errorcheck[5] = orgPanchaytModel.value.isNull ? 1 : 0;
        Errorcheck[6] = orgwardModel.value.isNull ? 1 : 0;
      } else if (txtControllername.text.isEmpty ||
          txtControllerMobile.text.isEmpty ||
          txtControllerAddress.text.isEmpty ||
          txtControllerMobile.text.length != 10) {
        Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
        Errorcheck[1] = txtControllerMobile.text.toString().isEmpty
            ? 1
            : txtControllerMobile.text.length != 10
            ? 2
            : 0;
        Errorcheck[2] = txtControllerAddress.text.toString().isEmpty ? 1 : 0;
      } else if (orderforothercheck &&
          (txtControllerotname.text.isEmpty ||
              txtControllerotMobile.text.isEmpty ||
              txtControllerotAddress.text.isEmpty ||
              txtControllerotMobile.text.length != 10)) {
        Errorcheck[7] = txtControllerotname.text.toString().isEmpty ? 1 : 0;
        Errorcheck[8] = txtControllerotAddress.text.toString().isEmpty ? 1 : 0;
        Errorcheck[9] = txtControllerotMobile.text.toString().isEmpty
            ? 1
            : txtControllerotMobile.text.length != 10
            ? 2
            : 0;
        print(">>>>>>>>>>>>>>>CALLING");
      } else {
        sendingdatatowebview();
      }
    } else if (orgwardModel.value.isNull) {
      Errorcheck[5] = orgPanchaytModel.value.isNull ? 1 : 0;
      Errorcheck[6] = orgwardModel.value.isNull ? 1 : 0;
    } else if (orderforothercheck) {
      if (txtControllername.text.isEmpty ||
          txtControllerMobile.text.isEmpty ||
          txtControllerAddress.text.isEmpty ||
          txtControllerMobile.text.length != 10) {
        Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
        Errorcheck[1] = txtControllerMobile.text.toString().isEmpty
            ? 1
            : txtControllerMobile.text.length != 10
            ? 2
            : 0;
        Errorcheck[2] = txtControllerAddress.text.toString().isEmpty ? 1 : 0;
      } else if (txtControllerotname.text.isEmpty ||
          txtControllerotMobile.text.isEmpty ||
          txtControllerotAddress.text.isEmpty ||
          txtControllerotMobile.text.length != 10) {
        Errorcheck[7] = txtControllerotname.text.toString().isEmpty ? 1 : 0;
        Errorcheck[8] = txtControllerotAddress.text.toString().isEmpty ? 1 : 0;
        Errorcheck[9] = txtControllerotMobile.text.toString().isEmpty
            ? 1
            : txtControllerotMobile.text.length != 10
            ? 2
            : 0;
      } else {
        sendingdatatowebview();
      }
    } else {
      if (txtControllername.text.isEmpty ||
          txtControllerMobile.text.isEmpty ||
          txtControllerAddress.text.isEmpty ||
          txtControllerMobile.text.length != 10) {
        Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
        Errorcheck[1] = txtControllerMobile.text.toString().isEmpty
            ? 1
            : txtControllerMobile.text.length != 10
            ? 2
            : 0;
        Errorcheck[2] = txtControllerAddress.text.toString().isEmpty ? 1 : 0;
      } else {
        sendingdatatowebview();
      }
    }
  }

  sendingdatatowebview() {
    print('kkkkkkkkkkkkkkkkkkkkkkkk');
    Map<String, dynamic> fullBodySave = {
      'name': txtControllername.text,
      'isphoto': "0",
      'Address': txtControllerAddress.text,
      'Mobile': txtControllerMobile.text,
      'District': '1',
      'Assembly': '1',
      'Panchayat': orgPanchaytModel.value.isNull
          ? "0"
          : orgPanchaytModel.value!.id,
      'Ward': orgwardModel.value.isNull ? "0" : orgwardModel.value!.id,
      'donation': "0",
      'orderid': "",
      'sponsorship': "0",
      'challengeid': challengeid,
      'clubid': clubModel.value.isNull ? "0" : clubModel.value!.id,
      'hideidendity': hideidendity,
      "uniquedid": AppData.uniqueid,
      'customerid': "",
      'orderforothers': orderforothercheck ? "1" : "0",
      'custname': txtControllerotname.text,
      'custaddress': txtControllerotAddress.text,
      'custmobile': txtControllerotMobile.text,
      'Transid': "",
      'Amount': Amount,
      'Received': "0",
      'volunteer': AppData.volunteerId == null ? "0" : volunteerid,
      'qty': list.first.quantity.toString(),
      'mode': "1",
    };

    Map<String, String> orderBody = {
      'total': Amount,
      'customer': txtControllername.text,
      'mobile': txtControllerMobile.text,
      'Custid': "",
    };

    Get.to(
      Webpaymentchallenge(
        name: txtControllername.text,
        amount: Amount,
        Number: txtControllerMobile.text,
        coount: backCount + 1,
        isShow: 0,

        fullsave: fullBodySave,
        orderBody: orderBody,
      ),
    );
  }

  savefromvolunterr(
    String received,
    bool Club_selected,
    String? showpanchayath,
    bool orderfoothers,
  ) {
    this.received = received!;
    Errorcheck.fillRange(0, 11, 0);

    if (txtControllername.text.isEmpty) {
      Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
    } else if (txtControllerMobile.text.isNotEmpty &&
        txtControllerMobile.text.length != 10) {
      Errorcheck[1] = txtControllerMobile.text.length != 10 ? 2 : 0;
    } else if (orderforothercheck &&
        (txtControllerotname.text.isEmpty ||
            txtControllerotMobile.text.isEmpty ||
            txtControllerotAddress.text.isEmpty ||
            txtControllerotMobile.text.length != 10)) {
      Errorcheck[7] = txtControllerotname.text.toString().isEmpty ? 1 : 0;
      Errorcheck[8] = txtControllerotAddress.text.toString().isEmpty ? 1 : 0;
      Errorcheck[9] = txtControllerotMobile.text.toString().isEmpty
          ? 1
          : txtControllerotMobile.text.length != 10
          ? 2
          : 0;
    } else {
      customersave_volunteer(Club_selected);
    }
  }

  customersave_volunteer(bool Club_selected) async {
    isLoading(true);
    Map<String, dynamic> fullBodySave = {
      'name': txtControllername.text,
      'isphoto': "0",
      'Address': txtControllerAddress.text,
      'Mobile': txtControllerMobile.text,
      'District': orgdistModel.value.isNull ? "1" : orgdistModel.value!.id,
      'Assembly': orgassemblymodel.value.isNull
          ? "1"
          : orgassemblymodel.value!.id,
      'Panchayat': orgPanchaytModel.value.isNull
          ? "0"
          : orgPanchaytModel.value!.id,
      'Ward': orgwardModel.value.isNull ? "0" : orgwardModel.value!.id,
      'donation': "0",
      'orderid': "",
      'sponsorship': "0",
      'challengeid': challengeid,
      'clubid': AppData.volunteerId.isNull
          ? clubModel.value.isNull
                ? "0"
                : clubModel.value!.id
          : !Club_selected
          ? "0"
          : AppData.clubId ?? "0",
      'hideidendity': hideidendity,
      "uniquedid": AppData.uniqueid,
      'customerid': "",
      'orderforothers': orderforothercheck ? "1" : "0",
      'custname': txtControllerotname.text,
      'custaddress': txtControllerotAddress.text,
      'custmobile': txtControllerotMobile.text,
      'Transid': "",
      'Amount': Amount,
      'Received': received,
      'volunteer': AppData.volunteerId == null ? "0" : volunteerid,
      'qty': list.first.quantity.toString(),
      'qty1': list[1].quantity.toString(),
      'mode': "1",
    };

    print("Json data ${jsonEncode(fullBodySave)}");

    final response = await post(Uri.parse(setthefulldatas), body: fullBodySave);
    isLoading(false);
    print("Responese of data${response.body}");
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'] == 'True') {
          print("Customer data saved >>>>>>>>>>>>>>>>");
          goBackTwoPages();

          Get.snackbar(
            'successfull', // Title of the Snackbar
            "successfully placed your order", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'successfull',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium',
                // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'successfully placed your order',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fontsemibold',
                // Set your custom font family here
                fontSize: 14,
              ),
            ),
            // Position of the Snackbar
            backgroundColor: AppColors.primaryColor2,
            // Background color of the Snackbar
            colorText: Colors.white,
            // Text color of the Snackbar
            borderRadius: 10,
            // Border radius of the Snackbar
            margin: EdgeInsets.all(10),
            // Margin around the Snackbar
            duration: Duration(
              seconds: 3,
            ), // Duration for which the Snackbar is displayed
          );
        } else {
          Get.back();
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // transationfailed(String id) async {
  //   isLoading(true);
  //   final response = await post(Uri.parse(failedtransation), body: {
  //     'id': id,
  //   });
  //   //isLoading(false);
  //  // print(">>>>>>>>>>>>>>>>>>>>>>> details  save${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //       if (parsedJson['Status'] == 'True') {
  //         goBackTwoPages();
  //         Get.to(PaymentfailedScreen());
  //       } else {
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == backCount);
  }
}

enum gateway { razorpay, ccevenue }
